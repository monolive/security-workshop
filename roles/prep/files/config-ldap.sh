#!/bin/sh
# ----------------------------------------------------------------------
# Instructions for configuring a system with nss-pam-ldapd as a IPA
# client. This set of instructions is targeted for platforms that
# include the authconfig utility, which are all Red Hat based platforms.
# ----------------------------------------------------------------------
# Schema Compatibility plugin has not been configured on this server. To
# configure it, run "ipa-adtrust-install --enable-compat"
# Install required packages via yum
yum install -y wget openssl nss-pam-ldapd pam_ldap authconfig

# NOTE: IPA certificate uses the SHA-256 hash function. SHA-256 was
# introduced in RHEL5.2. Therefore, clients older than RHEL5.2 will not
# be able to interoperate with IPA server 3.x.
# Please note that this script assumes /etc/openldap/cacerts as the
# default CA certificate location. If this value is different on your
# system the script needs to be modified accordingly.
# Download the CA certificate of the IPA server
mkdir -p -m 755 /etc/openldap/cacerts
wget http://hwxipa.hwxipa.a7.internal.cloudapp.net/ipa/config/ca.crt -O /etc/openldap/cacerts/ipa.crt

# Generate hashes for the openldap library
command -v cacertdir_rehash
if [ $? -ne 0 ] ; then
 wget "https://fedorahosted.org/authconfig/browser/cacertdir_rehash?format=txt" -O cacertdir_rehash ;
 chmod 755 ./cacertdir_rehash ;
 ./cacertdir_rehash /etc/openldap/cacerts/ ;
else
 cacertdir_rehash /etc/openldap/cacerts/ ;
fi

# Use the authconfig to configure nsswitch.conf and the PAM stack
authconfig --updateall --enableldap --enableldapauth --ldapserver=ldap://hwxipa.hwxipa.a7.internal.cloudapp.net --ldapbasedn=cn=compat,dc=internal,dc=cloudapp,dc=net
authconfig --enablemkhomedir --update