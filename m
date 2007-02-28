Message-ID: <45E59B3C.70803@domain.hid>
Date: Wed, 28 Feb 2007 16:09:48 +0100
From: Stephan Zimmermann <s.zimmermann@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [BUG] trunk: oops with Stephan's stress test
References: <45DEDED6.4070202@domain.hid>	<1172237401.26738.13.camel@domain.hid>		<45DEED50.4070007@domain.hid>	<1172238537.26738.15.camel@domain.hid>	<45DEF482.9030903@domain.hid>	<45E58CE3.20807@domain.hid>	<45E58FB4.6070603@domain.hid>
	<45E59574.50808@domain.hid> <45E599F1.5020205@domain.hid>
In-Reply-To: <45E599F1.5020205@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Stephan Zimmermann schrieb:
> Jan Kiszka schrieb:
>> Jan Kiszka wrote:
>>> Stephan Zimmermann wrote:
>>>> Jan Kiszka schrieb:
>>>>> Philippe Gerum wrote:
>>>>>> On Fri, 2007-02-23 at 14:34 +0100, Jan Kiszka wrote:
>>>>>>
>>>>>>> Attached with 3000 points (to play safe).
>>>>>> Great, thanks.
>>>>>>
>>>>> FYI: Switching prio-coupling off doesn't let it trigger anymore. Which
>>>>> /may/ mean that it's related to this feature, but which may also mean
>>>>> that this corner-case race is just far more unlikely in non-RPI setups
>>>>> (and the effects Stephan see are all related to the same bug -
>>>>> hopefully).
>>>>>
>>>>> Jan
>>>>>
>>>> To trigger you again, I just updated my Pentium M Notebook to 2.3.x svn
>>>> revision 2264, recompiled everything and gave it a try. (kernel 2.6.20)
>>>> Some runs of my already well-known software and the machine freezes
>>>> during shutdown. No oops, no backtrace, no error message. It doesn't
>>>> matter if priority coupling is enabled or not, when it tells me
>>>> 'Stopping K Display Manager: kdm' the cursor freezes, that's it. My
>>>> colleague report's the same beahviour on his AMD SMP mashine. The
>>>> Celeron M crashes during reboot showing ugly backtraces like before.
>>                            ^^^^
>> _Re_boot - now I read your message correctly. So you are not facing
>> elementary boot issues on some boxes, but always memory corruption
>> *after* running your demo code, right?
> 
> yes, exactly
> 
>>
>> Then we should try to find out what mechanism of Xenomai might cause the
>> corruption. Could you, step by step, simplify your test, e.g. leaving
>> out some of the tasks or not using the message queues? This would help
>> to focus the analysis on (hopefully) only a few facilities.
> 
> Yes, I will try this. May take some time, stand by.
> 
>> Still, the compiler question remains relevant. 2.6.20 e.g. warns me that
>> gcc 4.1.0 may miscompile the kernel (but I'm using a SUSE-patched
>> version that so far behaves).
> 
> We are using gcc 3.3 - the debian 3.1 standard compiler - on all of our 
> Linux boxes. Maybe we should give a try to some newer release?
> 
> Stephan

Forgot to mention, HPET Timer Support is off.

