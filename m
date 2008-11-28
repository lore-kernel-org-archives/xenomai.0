Message-Id: <4EE80EC6-EA2C-4B3F-A308-8FFD125C4FDC@su.sabanciuniv.edu>
From: Alphan Ulusoy <alphan@domain.hid>
In-Reply-To: <49302630.4080104@domain.hid>
Content-Type: multipart/signed; boundary=Apple-Mail-84-490286033; micalg=sha1;
	protocol="application/pkcs7-signature"
Mime-Version: 1.0 (Apple Message framework v929.2)
Date: Fri, 28 Nov 2008 22:53:09 +0200
References: <20081127175234.163sujmgcgcgs4gk@domain.hid>	<492EF786.4040303@domain.hid>	<20081128181906.mnv2mvjgo44wgoc0@domain.hid>	<49301B0B.9010208@domain.hid>
	<20081128182944.qp8yhwpk6cw8cwss@domain.hid>
	<49302630.4080104@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


--Apple-Mail-84-490286033
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

I've tried sysRq+t & Alt+SysRq+T but nothing happened. I guess I  
didn't turn on the magic keys option last time I compiled the kernel.

Below you can find a code snippet that mimics the behavior of the  
process that spawns user space tasks. The user space rt task itself is  
quite long but I believe the cleanup routine that I've sent prevously  
can help. Please note that I didn't compile this code to reproduce the  
behaviour but still, this is a good representative of what the actual  
father task does.

And I've noticed that I didn't change the wait() call with the wait4()  
you've suggested. But does it matter in this case? The forking process  
always has a single child at any given time (I assume system() call  
becomes a child of the calling process), at least I believe so...

///////////////////
/////////////////// The forking process
///////////////////


#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>

int forkResult=0;

void waitChild(int junk)
{

     int status =0;

     wait(&status);

}

int main(void)
{

     int result=0;

     signal(SIGCHLD, SIG_IGN);

     // Fork only once
     while (!forkResult)
     {

         forkResult = fork();

         // Only the child process executes here
         if (forkResult == 0)
         {

             // Install the signal handler (if set to SIG_IGN,  
system() always returns -1)
     	    signal(SIGCHLD, waitChild);

             while (1)
             {

                 // Execute the task in the background
                 result=system("/some_dir/userTask &");

                 sleep(60);

		//Terminate
		result=system("pkill -SIGTERM userTask");

		sleep(5);

		//Are we done?
		result=system("while ps -p `pgrep userTask` > /dev/null 2>&1; do  
sleep 1; done");
		

             }
         }
     }
}

/////////////////////

On Nov 28, 2008, at 7:11 PM, Gilles Chanteperdrix wrote:

> Mehmet Alphan Ulusoy wrote:
>> ps aux says Task's state is "Zl+" and it's there for over 6 hours  
>> now,
>> is init's mentioned behavior standard or somewhat optional?
>>
>> If it's standard, then does this mean that there's something else  
>> going on?
>
> If you are able to reproduce this issue with a simple program, could  
> you
> send it to us?
>
> -- 
>                                                 Gilles.
>

On Nov 28, 2008, at 7:11 PM, Gilles Chanteperdrix wrote:

> Mehmet Alphan Ulusoy wrote:
>> ps aux says Task's state is "Zl+" and it's there for over 6 hours  
>> now,
>> is init's mentioned behavior standard or somewhat optional?
>>
>> If it's standard, then does this mean that there's something else  
>> going on?
>
> If you are able to reproduce this issue with a simple program, could  
> you
> send it to us?
>
> -- 
>                                                 Gilles.
>


--Apple-Mail-84-490286033
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
MQ8XDTA4MTEyODIwNTMwOVowIwYJKoZIhvcNAQkEMRYEFAFZlPAbQTk9fKFPPpS5SkoSBTfdMIGF
BgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGlu
ZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBD
QQIQWVsRulyu1HASB5MPpvv9RjCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlpBMSUw
IwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVy
c29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQWVsRulyu1HASB5MPpvv9RjANBgkqhkiG9w0BAQEF
AASCAQAbKo+wvuEevxyac4GQHVFyiKhWYaFOGVswpgk/OkM0fQ9So5mCDBRh7/ip+mHJN4h3cA+Z
pzXbL/SIvRq8xr1Tcl/sSXpZNSeygcedOH8wfyRgXUE8Kbi665oYo5m5YToNTjmF0NFlpbCMSzrc
7qqXSlZZaJPrW5f6Fm9tJh2z30RwtCd5wsYILoyGOGJeY/5NG3CVak1Z102eCy3CqR5Nh2tViS6n
yio2bXlwAYK4v8LD1D2ZMYv7UKpNnDYF/TNtZI3iV9dmrBr9luItouLYuEnyZAJ17Yzli7WW6a6z
WbJMtXBJvR1k5/EvAYl5W7XCVlkx+FM3Fl7u6ZMDx0uNAAAAAAAA

--Apple-Mail-84-490286033--

