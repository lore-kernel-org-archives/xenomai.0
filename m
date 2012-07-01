Message-ID: <4FF0A07E.9000209@xenomai.org>
Date: Sun, 01 Jul 2012 21:09:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdte1Yg5fEUN=jqVgyTkRTHwY62WrMdw99ZgqOZZdAnAm+w@mail.gmail.com>	<4FEED882.9070307@xenomai.org>	<4FEF2EB1.3050600@logilin.fr>
	<4FEF31AC.2000403@xenomai.org> <4FF09E30.5050400@logilin.fr>
In-Reply-To: <4FF09E30.5050400@logilin.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] question: XENO_OPT_TIMING_SCHEDLAT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Christophe Blaess <mailist@logilin.fr>
Cc: xenomai@xenomai.org

On 07/01/2012 09:00 PM, Christophe Blaess wrote:
> On 30/06/2012 19:04, Gilles Chanteperdrix wrote:
>> On 06/30/2012 06:52 PM, Christophe Blaess wrote:
>>> On 30/06/2012 12:44, Gilles Chanteperdrix wrote:
>>>>
>>>>> /proc/xenomai/latency is an estimation of the minimum scheduling latency
>>>>> on your system. In order to know what to put there you should do:
>>>>>
>>>>> echo 0 > /proc/xenomai/latency
>>>>>
>>>>> Run latency under load for several hour
>>> Is it necessary to run the test under heavy load?
>>> We're looking for the minimal latency, not the worst.
>>>
>>> I thought that in this case a normal, even light load would be sufficient.
>> It is not obvious which path is the shortest. For instance, having to
>> wake up from a "wait for interrupt" state to handle the timer interrupt
>> may induce a certain latency, and so may not be the shortest path. So,
>> running the test for a long time, and with a lot of different activities
>> is an empiric way to try many paths so that extreme paths have more
>> chances to be closest to the extrema paths.
>>
>> And anyway, you usually want to know the worst case latency for your
>> system as well.
>>
> 
> I ran two 6-hours latency tests on a Pandaboard. After echoing 0 in 
> /proc/xenomai/latency
> 
> For the first one the system load was very weak. I ran the test on the 
> second core because most of the interrupts are processed on the first 
> core. So the latency process was almost alone.
> 
> #*/usr/xenomai/bin/latency -p 100 -c 1 -T 21600*
> [...]
> RTS|      2.388|      3.134|     18.706|       0|     0|    06:00:00/06:00:00
> 
> 
> For the second test, the system was under a very high load. I used a 
> shell script very close to dohell and sent a lot of external interrupts 
> (ping flood, GPIO interrupt...). This time latency ran on the first 
> core, and was subject to a lot of preemptions from interrupt requests.
> 
> #*/usr/xenomai/bin/latency -p 100 -c 0 -T 21600*
> [...]
> RTS|      2.908|      7.797|     51.579|       0|     0|    06:00:00/06:00:00
> 
> I would recommend, as you said, for long time tests to alternate high 
> and low pressure stages to get the min and max values.
> 
> 
> Apart from that, on my board (Panda with Xenomai 2.6.0), I note that 
> writing in /proc/xenomai/latency such as
> 
> # echo 2388 > /proc/xenomai/latency
> 
> 
> gives a segmentation fault, even if the value is indeed written. Here is 
> the dmesg log :
> 
> [65108.190551] Unable to handle kernel paging request at virtual address 00004a5a
> [65108.190551] pgd = ef138000
> [65108.190551] [00004a5a] *pgd=af101831, *pte=00000000, *ppte=00000000
> [65108.190582] Internal error: Oops: 80000007 [#1] PREEMPT SMP
> [65108.190582] last sysfs file: /sys/devices/virtual/vc/vcs2/dev
> [65108.190612] CPU: 0    Not tainted  (2.6.38.8-xenomai-cpb #2)
> [65108.190612] PC is at 0x4a5a
> [65108.190643] LR is at simple_strtoul+0x8/0xc
> [65108.190643] pc : [<00004a5a>]    lr : [<c024ebf4>]    psr: 60000033
> [65108.190643] sp : ef06df08  ip : 00000002  fp : 00000100
> [65108.190673] r10: 401ae600  r9 : efbffe48  r8 : 00000fff
> [65108.190673] r7 : 00000fff  r6 : 1b207478  r5 : 742e4a5b  r4 : 1b262074
> [65108.190673] r3 : 00000002  r2 : c0456918  r1 : 00000000  r0 : ffffffea
> [65108.190704] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment user
> [65108.190704] Control: 10c53c7d  Table: af13804a  DAC: 00000015
> [65108.190704] Process sh (pid: 86, stack limit = 0xef06c2f8)
> [65108.190734] Stack: (0xef06df08 to 0xef06e000)
> [65108.190734] df00:                   00000000 00000000 00000000 00000000 00000000 00000000
> [65108.190734] df20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [65108.190765] df40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [65108.190765] df60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [65108.190795] df80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [65108.190795] dfa0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [65108.190795] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [65108.190826] dfe0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [65108.190826] [<c024ebf4>] (simple_strtoul+0x8/0xc) from [<00000000>] (  (null))
> [65108.190856] Code: bad PC value
> [65108.190979] ---[ end trace 29e0859033dc848c ]---
> 

I can not reproduce that. Could you try again with the current head of
xenomai-2.6 git? If you can reproduce it, can you tell us which I-pipe
patch you are using, and send your kernel configuration?

-- 
                                                                Gilles.

