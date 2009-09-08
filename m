Mime-Version: 1.0 (Apple Message framework v1075.2)
Content-Type: multipart/signed; boundary=Apple-Mail-18--754516662;
	protocol="application/pkcs7-signature"; micalg=sha1
From: Alphan Ulusoy <alphan@domain.hid>
In-Reply-To: <793108.19562.qm@domain.hid>
Date: Tue, 8 Sep 2009 20:23:10 +0300
Message-Id: <89DE9B44-67FD-4DFE-BFE6-7445851AABCD@su.sabanciuniv.edu>
References: <793108.19562.qm@domain.hid>
Subject: Re: [Xenomai-help] RT Task RPC over a POSIX/Native Queue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Guvenc Gulce <gulceg@domain.hid>
Cc: xenomai@xenomai.org


--Apple-Mail-18--754516662
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes

You can always use the Xenomai's _wonderful_ pipe functionality (and  
other task communication services as well) to communicate data back  
and forth between RT (Xenomai user -or- kernel space tasks) and non-RT  
(dedicated linux executables) tasks. This also ensures that your RT  
and non-RT domains are clearly separated by design, which is a good  
thing IMHO.


-- 
alphan




On 8 Sep, 2009, at 8:10 PM, Guvenc Gulce wrote:

> Hi
> As far as I know an Xenomai RT Task can not call Linux API functions  
> without leaving the Xenomai domain.
>
> I was thinking about a generic library/framework which would allow  
> an Xenomai RT Task call a Linux API
> function which would be then marshalled over a Posix/Native Queue to  
> another Xenomai RT Task which then
> would do the dirty job of calling Linux functions. The responses and  
> function return values from linux functions
> can be marshalled back to the original Xenomai RT-Task caller again  
> over another Posix/Native Queue. In such
> a scenario the original caller RT Task would stay always in Xenomai  
> domain.
>
> I would like to hear whether such an approach sounds feasible/ 
> reasonable given the fact that currently
> Xenomai RT Tasks can not call Linux functions without leaving the  
> Xenomai domain. Such a library/framework
> would be a solution to overcome that constraint. I would be glad to  
> hear some opinions about this.
>
> Thanks & Regards,
>
> Guvenc
>
>
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>


--Apple-Mail-18--754516662
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGMzCCAuww
ggJVoAMCAQICEFlbEbpcrtRwEgeTD6b7/UYwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA4MDkxMDE4MjkxMFoXDTA5MDkxMDE4Mjkx
MFowSzEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEoMCYGCSqGSIb3DQEJARYZYWxw
aGFuQHN1LnNhYmFuY2l1bml2LmVkdTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKju
oEccePvK+1FqYYzkT3ZagQMkK86SRcJIznx9wqt7mIE6oYI/SjcjURCvuaoU4l0zG3dhC5Jlgg1A
u5xtAQCxd/mrvyRm6fM+AMs+qvyZjVBLqAnHT/HxHTV3Ju5BE4U2G6Dj+x18WuRy/YSj4fihhdAI
AcsPuJri8Dfvusecef7Xam6gcl0kkRexmEDiiMSb3SEziOdjQqAZEArTRMYZYGFANsMJvXzNN76I
qyAkaAcr8IuUoXt0RYwwn2DhUcBTrg1SfIqYdTrWi7TmCVpudfND6hHlz8+RogQi7ohbMbwKFwKa
3gXhcRnc1dABGNnyXDJR1nCWKMHq1KE72DUCAwEAAaM2MDQwJAYDVR0RBB0wG4EZYWxwaGFuQHN1
LnNhYmFuY2l1bml2LmVkdTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUAA4GBACe45E4PvEZO
ZjwogK3R7lVPLQ4bfNF1hpUDfK0Kgba6jbDlIRSmx0Cz3xgMdC2SGpf3aCu+7PJQa4u0NA2QAlEs
AMI9QFNtu0HhyXKtdR3a7sHRCR4XiczLQUHS4S9LRKueHGvWaVx6jQICMH9lJBlW62gnd2TgOcWP
TGxJWK9YMIIDPzCCAqigAwIBAgIBDTANBgkqhkiG9w0BAQUFADCB0TELMAkGA1UEBhMCWkExFTAT
BgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3dGUg
Q29uc3VsdGluZzEoMCYGA1UECxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIG
A1UEAxMbVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25h
bC1mcmVlbWFpbEB0aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVowYjEL
MAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNV
BAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEBAQUA
A4GNADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9RzgHU5VAK
MNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CAAmTXp6a7
n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYBAf8CAQAw
QwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBlcnNvbmFsRnJl
ZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2YXRl
TGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2asZw9/r6y+whehQ5aUnX9M
Ibj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSeJVCUYsfbJ3FXJY3dqZw5jowg
T2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHTHUb/XV9lTzGCAxAwggMMAgEBMHYw
YjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAq
BgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhBZWxG6XK7UcBIHkw+m
+/1GMAkGBSsOAwIaBQCgggFvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTA5MDkwODE3MjMxMFowIwYJKoZIhvcNAQkEMRYEFBlytuL2E9CKVHZ1qnYHoA66XoG5MIGF
BgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGlu
ZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBD
QQIQWVsRulyu1HASB5MPpvv9RjCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlpBMSUw
IwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVy
c29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQWVsRulyu1HASB5MPpvv9RjANBgkqhkiG9w0BAQEF
AASCAQBK906ZXQGklfeSpBDsATVScl0CR+OiicBShGFwRPQZwvuQVDe1qA1LZ/5z8fEKacXclIy+
YDdQGt2gr5WJLZ/fX7DyCYdbxElj3SHWdz/EQps6AEhQrJQ669bM6Y3zqBZtPxo4y7lALu7LDZO3
ArTQD/kSM/O+x1GCzuZswSK4UdUuYoJq7AB+V5/Jd81QOTUZ+lRpV7ZkstDqgnA/QVqPlA261hpp
xex6Z2mTYHL4YOpX8Sv+fy0RTsGcQl0x1XW2eOFV7kJS9PbNcL4wPNXZU1O3kahL8HpirSQcqtpy
3DkIlZFU9PfiAV7xWdJ34iSGF8lBq9hTOKe2rACLECcvAAAAAAAA

--Apple-Mail-18--754516662--

