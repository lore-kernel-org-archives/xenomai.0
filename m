Mime-Version: 1.0 (Apple Message framework v1075.2)
Content-Type: multipart/signed; boundary=Apple-Mail-20--746130653;
	protocol="application/pkcs7-signature"; micalg=sha1
From: Alphan Ulusoy <alphan@domain.hid>
In-Reply-To: <4AA6AF80.5090902@domain.hid>
Date: Tue, 8 Sep 2009 22:42:56 +0300
Message-Id: <769D9865-1128-4D8E-BE41-6A38C7806D2E@su.sabanciuniv.edu>
References: <793108.19562.qm@domain.hid>
	<89DE9B44-67FD-4DFE-BFE6-7445851AABCD@su.sabanciuniv.edu>
	<4AA6AF80.5090902@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


--Apple-Mail-20--746130653
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes

My post was probably not clear enough: I was thinking about something  
more like a source-sink scheme: an RT task generating some data to be  
processed (to be saved, printed, displayed, etc.) by the non-RT task  
or a non-RT task streaming chunks of data to the RT-task (to be  
decoded, etc.); not a non-RT => RT feedback mechanism.

> Waiting for the non real-time task to post an answer through rt- 
> pipes is
> as dangerous for the real-time task determinism as with message queues
> of any kind.

For other cases, your above comment is totally accurate of course.

-- 
alphan




On 8 Sep, 2009, at 10:24 PM, Gilles Chanteperdrix wrote:

> Alphan Ulusoy wrote:
>> You can always use the Xenomai's _wonderful_ pipe functionality (and
>> other task communication services as well) to communicate data back
>> and forth between RT (Xenomai user -or- kernel space tasks) and non- 
>> RT
>> (dedicated linux executables) tasks. This also ensures that your RT
>> and non-RT domains are clearly separated by design, which is a good
>> thing IMHO.
>
> Waiting for the non real-time task to post an answer through rt- 
> pipes is
> as dangerous for the real-time task determinism as with message queues
> of any kind.
>
> Besides, a task with low priority which oscillates between first and
> secondary modes does not threaten a primary mode only task determinism
> any more than a non real-time tasks. However, it can communicates with
> the primary mode only task with a lot more IPCs and synchronization
> mechanisms.
>
> And there is no difference in design between an application separated
> between real-time and non real-time tasks on the one hand, and an
> application separated between real-time and oscillating tasks on the
> other hand. The real gain in design happens when you can split driver
> code from application code.
>
> -- 
> 					    Gilles.
>


--Apple-Mail-20--746130653
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
MQ8XDTA5MDkwODE5NDI1NlowIwYJKoZIhvcNAQkEMRYEFARE1h2006qc6NjiifGF4e0aytPDMIGF
BgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGlu
ZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBD
QQIQWVsRulyu1HASB5MPpvv9RjCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlpBMSUw
IwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVy
c29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQWVsRulyu1HASB5MPpvv9RjANBgkqhkiG9w0BAQEF
AASCAQBDkPI6ycza8QGf1f1IpXntFMGcb7DsPdmMf3qeZc596bWF/IPl0Ohq+2nkjvvA3XDgV2fB
rVuBgX8LR8V7o7GEwQLWhikZSTEpYmVvGgn9J5vcDV+mzdcO40DqqAw9+JmuUiToynk9SaJaiOIO
pf3yeou2mJZ9jj3J21PVmij+Kq5QqcwkIQ/qLLN/vX1atjix75TDx5Adt18L6FmzWUa5XEeDjUu5
t7loHu9AASLqp8KALgkwylJ23di4OsRrEf14N9wI4hxH64jfxRfCtrgu9k8vnVDHnvgMOVBW8s0u
S1nfTqi74pEq/c49ecailuZBtsemzoKkCEu7RVq40ro8AAAAAAAA

--Apple-Mail-20--746130653--

