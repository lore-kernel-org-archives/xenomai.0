Message-Id: <7FE1BC10-B7AE-45AD-A848-F429D5C584F8@domain.hid>
From: Alphan Ulusoy <alphan@domain.hid>
In-Reply-To: <4950DE5E.6040700@domain.hid>
Content-Type: multipart/signed; boundary=Apple-Mail-3-820254339; micalg=sha1;
	protocol="application/pkcs7-signature"
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Sat, 27 Dec 2008 15:04:00 +0200
References: <20081127175234.163sujmgcgcgs4gk@domain.hid>	<492EF786.4040303@domain.hid>	<20081128181906.mnv2mvjgo44wgoc0@domain.hid>	<49301B0B.9010208@domain.hid>	<20081128182944.qp8yhwpk6cw8cwss@domain.hid>	<49302630.4080104@domain.hid>	<D6B7B711-7E2F-466D-857F-53EB7A7C30DC@su.sabanciuniv.edu>	<B41FD0F2-09C0-4DB6-B36C-892B72A63875@domain.hid>	<C7714144-0328-4258-95BD-133AB45C72E9@domain.hid>	<494F6250.50707@domain.hid>
	<20081222133253.lscsfad40kswkwsc@domain.hid>
	<494F9007.5060600@domain.hid>
	<1B44D448-6E28-45CD-97E7-7230D3E44D61@domain.hid>
	<4950C326.4050003@domain.hid>
	<9EB4E9E6-B9D4-433C-ABC9-FBBEF29DB0A3@domain.hid>
	<4950DB54.3000804@domain.hid>
	<C59B6CFD-F977-4130-B8D9-DEB86F055160@domain.hid>
	<4950DE5E.6040700@domain.hid>
Subject: Re: [Xenomai-help] Zombie user tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


--Apple-Mail-3-820254339
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

I've downloaded and installed Xenomai 2.4.6.1 on a 2.6.27.10 kernel. I  
wanted to be sure before posting: the system ran for 13+ hours without  
crashing or anything. I guess the problem was the bug in the  
gatekeeper code you mentioned. Thanks a lot for pointing me in the  
right direction and helping me solve this issue! (I was reluctant to  
upgrade due to the problem with the I-pipe patch included in the 2.4.6  
release)


-- 
alphan




On Dec 23, 2008, at 2:49 PM, Gilles Chanteperdrix wrote:

> Alphan Ulusoy wrote:
>> Ok I will do that and post my findings. I use the adeos-ipipe-2.6.26-
>> x86-2.0-15.patch. Is upgrading xenomai and i-pipe enough or would you
>> recommend upgrading the kernel too (if there're any relevant changes
>> in the new releases) ?
>
> Please use the patch in the v2.4.6.1 release. I think it is for linux
> 2.6.26.7 and later, so, you will have to upgrade the kernel too.
>
> -- 
>                                                 Gilles.
>


--Apple-Mail-3-820254339
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
MQ8XDTA4MTIyNzEzMDQwMVowIwYJKoZIhvcNAQkEMRYEFF5avshwVdDWSft73UC2cYrxQx+bMIGF
BgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGlu
ZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBD
QQIQWVsRulyu1HASB5MPpvv9RjCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlpBMSUw
IwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVy
c29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQWVsRulyu1HASB5MPpvv9RjANBgkqhkiG9w0BAQEF
AASCAQAr/rFyb3yfcQ6x6DfVMD9PrnOjiZATyUc73tF+Ypqv7qujc83whvCM+bcSF3HqJJbzgvZK
08igzdb5Wl/iHaJa/ZKpzWAxSZs61tKur/vTRLQBM98JnTwafmG+cI9bS2L+qPB17vWzxWTYAeRj
ZVPvWzPq8NQxA1x48q4jv4fGujrPggGs4NyDI72D1nCUFFvd5e2epnXh1YUx5a8FvIrZrjgRPGH1
LtSLmv0uzYL2AqJ0hJFUpQOcbjZIZWr98T1iVEbtajKKgY36KRhD9uSF3/7krLwGHsHXTXUcJXi1
jivy1Z6PBW7Ko7VmP4xM8Uz8n2jG59NFgJf00Ys9fdfHAAAAAAAA

--Apple-Mail-3-820254339--

