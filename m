Message-ID: <45F05EC7.6070907@domain.hid>
Date: Thu, 08 Mar 2007 20:06:47 +0100
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTCAN and tsc
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid><E1HOs43-0008OG-Ki@domain.hid>
	<45EFFE22.9060401@domain.hid> <E1HPJMF-0008IL-F2@domain.hid>
	<!&!AAAAAAAAAAAYAAAAAAAAAOtQApUEfglBvKTF3jr1t1bigwAAEAAAALx+DKgbdNVEi6wAAVh/Ga4BAAAAAA==@ac6.fr>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAOtQApUEfglBvKTF3jr1t1bigwAAEAAAALx+DKgbdNVEi6wAAVh/Ga4BAAAAAA==@ac6.fr>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bernard Dautrevaux <bernard.dautrevaux@domain.hid>
Cc: xenomai@xenomai.org

Hi,

Thanks for the input. Much appreciated from my side. I cannot comment on 
your question

 > The net result was that we had to add quite a lot of udelay() calls 
to >slow down the driver to the senator's pace of the SJA1000... Are you 
 >sure you're not running in this kind of problem?

but if anyone has suggestions as to what I can do to validate it I would 
be happy to try.  (Sebastian your request to remove the inline statement 
is forthcoming)

For the record, I am developing on a laptop with 3 GHz Intel CPU, 2 GB 
of RAM, 800 Mhz FSB and that is about all the stats I have. This info is 
probably irrelevant but just to clear out of the way any ideas that I 
might be working on the oldest of PC hardware.

I do have a question which may be a bit early or out of context but if 
it turns out without question that the delay IS in the

rtcan_sja_interrupt

routine (is it a routine? A function call? ) would it be possible to 
split the function up into smaller parts (is this what they call 
granularity?) so that the RT tasks can return to themselves before 
running out of time while stuck in the rtcan_sja_interrupt call. ?

Or am I missing the point entirely?


Regards,

Roland.

Bernard Dautrevaux wrote:
> Hi everybody,
> 
> Maybe I'm making an error, but AFAIK, the SJA1000 on-chip registers are clocked by a rather slow clock, that is limited to about 24MHz. I remember a case where interrupts were handled by the CPU (a 600MHz thing) too fast for the SJA1000, resulting in the chip not yet aware that it generates the interrupt. 
> 
> To be more precise, the IRQ gets out, probably immediately through some sort of asynchronous logic, but the fact was only clocked in the interrupt status register at about 16MHz, thus the CPU was able to read the interrupt status register, thus clearing the coming interrupt state, before the interrut was latched, and thus the IRQ was lost...
> 
> The net result was that we had to add quite a lot of udelay() calls to slow down the driver to the senator's pace of the SJA1000... Are you sure you're not running in this kind of problem?
> 
> Just my .02€
> 
> Bernard
> 
> 
>> -----Message d'origine-----
>> De : xenomai-help-bounces@domain.hid 
>> [mailto:xenomai-help-bounces@domain.hid] De la part de Sebastian Smolorz
>> Envoyé : jeudi 8 mars 2007 15:13
>> À : rolandtollenaar@domain.hid
>> Cc : xenomai@xenomai.org
>> Objet : Re: [Xenomai-help] RTCAN and tsc
>>
>> Roland Tollenaar wrote:
>>> Hi
>>>
>>>>> What does this mean? This is as good as it gets?
>>>> Hm. To be more verbose on what happens between the beginning of 
>>>> rtcan_sja_interrupt and rtcan_rcv please remove the "inline" from 
>>>> the functions rtcan_sja_err_interrupt in the file 
>>>> ksrc/drivers/can/sja1000/rtcan_sja1000.c line 156 and from the 
>>>> function rtcan_sja_rx_interrupt in the same file in line 
>> 87. Compile 
>>>> your modules/kernel again and repeat the tracer/latency test.
>>>>
>>>> I assume that most of the time is spent in the latter 
>> function where 
>>>> several SJA HW regs are read out. A slow access to the 
>> regs could be 
>>>> the explanation for the long time the interrupt handler 
>> has to spend.
>>> Where are the registers located? On the dongle or are these 
>> in the PC?
>>
>> These are registers located in the SJA1000 CAN controller.
>>
>>> Just to know whether there might not be a problem with the 
>> PEAK device.
>>> Is there any way you could check what the access times are to 
>>> rtcan_sja_interrupt on your systems when performing the same 
>>> experiment and recieving messages (pref PDO with length 8) 
>> over the bus?
>>
>> Unfortunately, I do not have the opportunity to perform tests 
>> with the driver ATM.
>>
>>> I am developing on a pretty high-end machine here,
>> Didn't you speak of 486's in a previous mail?
>>
>>> in fact every aspect
>>> almost as fast as is on the market at the moment so its 
>> would surprise 
>>> me if there is a hardware shortcoming if the registers you speak of 
>>> are on the PC.
>>>
>>> In the mean time I will try doing as you suggest, I presume 
>> you want 
>>> me to send the frozen trace to you again after that.
>> Exactly.
>>
>>> Is it worth while removing the virtual driver from the kernel build 
>>> and running over rtcan0.
>> Turn it off although it is unlikely that it has something to 
>> do with the problem. But you never know.
>>
>>> Is there any chance that you have never encountered this problem
>> I never worked with the virtual device.
>>
>> --
>> Sebastian
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
> 
> 

