Message-ID: <4C191D91.6060209@domain.hid>
Date: Wed, 16 Jun 2010 20:53:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <181804936ABC2349BE503168465576460EBD5C0D@exchserver.basler.com>	<1274047063.2972.1.camel@domain.hid>	<2319761F7FA0D1479BA77EC2E0A8E7BCE8A603@domain.hid>	<1275033915.27918.31.camel@domain.hid>	<2319761F7FA0D1479BA77EC2E0A8E7BCEDCE09@domain.hid>
	<4C191D07.4050203@domain.hid>
In-Reply-To: <4C191D07.4050203@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_sleep causing crashes on PowerPC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Abhijit Majumdar <abhijit.majumdar@domain.hid>
Cc: xenomai@xenomai.org, Steve Deiters <SteveDeiters@domain.hid>

Gilles Chanteperdrix wrote:
> Abhijit Majumdar wrote:
>> Hi Philippe
>>
>> I have attached a standalone test program which crashes my system. It
>> uses poxis skin to create a simple task which sleeps for 10 micro sec
>> and wakes up and continues to do so until the user kills the process.
>>
>> Interesting things note -- 
>>
>> 	1. If I uncomment the printf statement at the beginning of the
>> while loop the program does not crash any more.
>> 	2. OR if I use rt_task_sleep instead of clock_nanosleep it does
>> not crash.
>>
>> I am using xenomai 2.5.2 and the arm platform has kernel 2.6.28.
> 
> That is a not vague. In any case, 10us on an ARM is much too short. As I
> think I already told someone at pivotal systems, ARM latencies are
> larger than 50 us, and most of the time larger than 100us. So, asking
> for a 10us sleep is preposterous.
> 
> However, if you want your report to be useful:
> - please try the latest version (that would be Xenomai 2.5.3)
> - send us the full log of the serial console, not the part you think is
> relevant (the error comes here while xnpod_schedule is trying to print a
> message, the interesting part is not the failure of add_preempt_count,
> but probably more the error message which xnpod_schedule wants to print).
> - sens us your kernel configuration.

And include the version of the I-pipe patch you are using.

> 


-- 
					    Gilles.

