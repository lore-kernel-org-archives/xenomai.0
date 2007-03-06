Message-ID: <45ED4351.2020905@domain.hid>
Date: Tue, 06 Mar 2007 11:32:49 +0100
From: Theo Veenker <Theo.Veenker@domain.hid>
MIME-Version: 1.0
References: <45E4646A.10205@domain.hid> <45E46D67.9030600@domain.hid>
	<45E48543.8030800@domain.hid> <45E48E50.1030502@domain.hid>
In-Reply-To: <45E48E50.1030502@domain.hid>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Re: high latency every 8 seconds
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Theo Veenker wrote:
> 
>>Jan Kiszka wrote:
>>
>>>Theo Veenker wrote:
>>>
>>>>Hi all,
>>>>
>>>>I'm installing xenomai 2.2.5 (kernel 2.6.17.14) on a number of
>>>
>>>When starting new, pick something new, i.e. 2.3 right now. Only if
> 
> you
> 
>>>have good reasons, staying at older versions is recommended.
>>
>>I would love to, but I couldn't get my software running with 2.3.
>>I had to convert (a month ago) my software from RTLinux to Xenomai
>>having only a few days for it. I have a kernel module and an app
>>that talks to it. I use the posix skin. But with 2.3 apparently
>>I had to load posixio and something (forgot) manually, but I just
>>couldn't get these loaded. Since time was running out I decided
>>to stay with 2.2.5 for the time being (unfortunately).
> 
> 
> I do understand. But once your time constraints relaxed a bit, please
> don't forget to post remaining issues here. Maybe they reveal some real
> bug.
> 
> 
>>>>systems (MSI 945P, Intel P4 3Ghz). My kernel runs fine on several
>>>>other/older systems, but on the new systems there is something going
>>>>on every 8 seconds. See output of latency test below. What could
>>>>this be? Is this an SMI effect?
>>>
>>>Is CONFIG_XENO_HW_SMI_WORKAROUND selected? What does the kernel output
>>>tell you about if it's working? Do you have an ICH7 chipset on your
>>>board? Would be another reason to update Xenomai (2.3 takes care of
>>>it, 2.2.x doesn't)... :)

OK. I finally installed my clients. It took a while because although all
systems are identical they didn't all behave the same. Apparently some
MSI 945P boards have problems when installing an ubuntu 686 kernel image.
Taking a 386 image as a starting point worked.

Recompiled my kernel 2.6.17.14 with xenomai 2.2.5 and SMI WORKAROUND
selected, but it didn't have any effect. I don't see any xenomai
output in the kernel logs. Same thing without the workaround. So it
doesn't even detect SMI. The mobo has a ICH7 chipset. I understand
from your message I would have to upgrade to xenomai 2.3 to have
support for this. Does this mean that with 2.3 my SMI problems will
magically go away, or does it mean I can use the SMI workaround then?

BTW, can turning off SMI (completely or partly) cause any damage to
the system? I mean can it effect cpu cooling or voltages?

>>>
>>>If this all doesn't help, have a look at this tool:
>>>
>>>http://www.xenomai.org/index.php/I-pipe:Tracer
>>>
>>>In any case, please give a feedback on the outcome.
>>
>>Thanks. I will.
>>
>>Theo
>>
> 
> 
> Jan
> 

I will now try with 2.3 again to find out what is was that troubled me
a while ago.

Theo



