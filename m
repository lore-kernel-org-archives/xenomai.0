Message-ID: <4DE1724A.2040400@domain.hid>
Date: Sun, 29 May 2011 00:08:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DDE8DC9.2020905@domain.hid>	<4DDF475A.5080504@domain.hid>	<4DDFB30F.8000003@domain.hid>	<4DDFB780.4010009@domain.hid>
	<4DDFBDCD.4040809@domain.hid>	<4DDFEDA2.40206@domain.hid>
	<4DDFF74E.2000400@domain.hid> <4DE1078D.3090503@domain.hid>
In-Reply-To: <4DE1078D.3090503@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Huge clock drift
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On 05/28/2011 04:32 PM, Jan Kiszka wrote:
> On 2011-05-27 21:11, Gilles Chanteperdrix wrote:
>> On 05/27/2011 08:29 PM, Jonas Witt wrote:
>>> Sorry, I missed the NTP-part. I am not using NTP. Just plain timer 
>>> queries on a single system.
>>>
>>> My clock source is tsc which is the same for Xenomai I suppose.
>>>
>>> I wonder how a Xenomai task, even if it occupies 50% or even 90% of a 4 
>>> milliseconds time slice can interfere with the tsc. The tsc is not 
>>> incremented via an interrupt, is it? But I do not know much about the 
>>> inner workings of these functions.
>>
>> The problem is not the clocksource, the problem is the timer interrupt.
>> The kernel expects 1 timer tick every millisecond.
> 
> Not on archs that are CONFIG_NO_HZ capable.

Last time I looked at CONFIG_NO_HZ, it did not look as Xenomai one-shot
timer at all. The system still had a periodic timer ticking HZ times by
second, in order to handle the non-high resolution timers. And this
timing was entirely disabled only when the system was idle. So, in other
word, the Linux kernel still needed a periodic timer interrupt.

> 
>> When you run a
>> real-time task during 2 milliseconds and prevent the kernel from
>> receiving the timer interrupts, you certainly disrupt its timekeeping.
>> If you want to do this, switch the Linux kernel frequency (CONFIG_HZ) to
>> 100.
> 
> Time keeping can perfectly bridge a lot of missing ticks as far as the
> underlying clocksource allows. And that's quite a bit with the x86 TSC.

Here, we are asking it to only receive one interrupt over two. I have to
admit that I talked without testing, but as long as we do not test the
kernel behaviour in order to test whether it allows such disruption, I
find it safer to advise people not to disrupt it.


-- 
                                                                Gilles.

