Message-ID: <499E9DCD.4010400@domain.hid>
Date: Fri, 20 Feb 2009 13:10:53 +0100
From: Roman Pisl <rpisl@domain.hid>
MIME-Version: 1.0
References: <499B36C5.3060104@domain.hid> <499C5E49.90002@domain.hid>
	<20090219183812.6bslw8zfkk44sgko@domain.hid>
	<499E95F5.10307@domain.hid>
In-Reply-To: <499E95F5.10307@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] BUG fs/buffer.c with Linux 2.6.26,27
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum napsal(a):
> Roman Pisl wrote:
>> Hello Philippe, Jan and other experts,
>> I did some tests on the desktop and the bug is still present.
>>
>> I tried both disabling CONFIG_PREEMPT and applying __ipipe_syscall_root
>> patch.
>>
>> Unfortunately I couldn't test Xenomai from trunk with our application,
>> because events are probably broken - attached example segfaults on
>> rt_event_wait. So I still use 2.4.6.1 and that is the reason for the
>> problem with void rthal_propagate_irq when
>> adeos-ipipe-2.6.27.13-x86-2.2-05.patch is applied.
>>
>> Jan wrote:
>> The tracer log for .27 looks strange - did you apply my
>> ipipe-trace-over-ftrace patch or just enabled the existing code? In the
>> latter case, the .26-based trace log would be nice to cross-check and
>> exclude tracer artifacts.
>>
>> Sorry, but I don't know where this patch comes from. I enabled existing
>> code only.
>>
>> .configs and logs are attached.
>>
> 
> FYI, testev.c is broken; the rt_event_wait() arglist is really wrong: mask_r
> is a mandatory arg that may not be passed as NULL, and the mode/timeout args
> have been inverted.
> 
>> Roman
>>
>>
>> ------------------------------------------------------------------------
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
> 
> 

Thank you for this important notice. Now I see, rt_event_clear accepts 
NULL, but in rt_event_wait it is a mandatory arg.

I corrected it immediately, now I'm running 2.6.27 and can't trigger the 
bug!



