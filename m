Message-ID: <4CD14DBC.3060505@domain.hid>
Date: Wed, 03 Nov 2010 12:55:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid>
	<4CC84327.9070202@domain.hid>	<4CC92786.3030509@domain.hid>
	<4CC92902.4040904@domain.hid>	<4CC943A2.9020806@domain.hid>
	<4CC94E0B.9070106@domain.hid>	<4CCEF104.7050409@domain.hid>
	<4CD11AB1.8090407@domain.hid> <4CD13A70.8040702@domain.hid>
	<4CD14B1E.4000707@domain.hid> <4CD14C92.90901@domain.hid>
In-Reply-To: <4CD14C92.90901@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Potential problem with rt_eepro100
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai@xenomai.org

Am 03.11.2010 12:50, Jan Kiszka wrote:
> Am 03.11.2010 12:44, Anders Blomdell wrote:
>> Anders Blomdell wrote:
>>> Jan Kiszka wrote:
>>>> Am 01.11.2010 17:55, Anders Blomdell wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Am 28.10.2010 11:34, Anders Blomdell wrote:
>>>>>>> Jan Kiszka wrote:
>>>>>>>> Am 28.10.2010 09:34, Anders Blomdell wrote:
>>>>>>>>> Anders Blomdell wrote:
>>>>>>>>>> Anders Blomdell wrote:
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> I'm trying to use rt_eepro100, for sending raw ethernet packets,
>>>>>>>>>>> but I'm
>>>>>>>>>>> experincing occasionally weird behaviour.
>>>>>>>>>>>
>>>>>>>>>>> Versions of things:
>>>>>>>>>>>
>>>>>>>>>>>   linux-2.6.34.5
>>>>>>>>>>>   xenomai-2.5.5.2
>>>>>>>>>>>   rtnet-39f7fcf
>>>>>>>>>>>
>>>>>>>>>>> The testprogram runs on two computers with "Intel Corporation
>>>>>>>>>>> 82557/8/9/0/1 Ethernet Pro 100 (rev 08)" controller, where one
>>>>>>>>>>> computer
>>>>>>>>>>> acts as a mirror sending back packets received from the ethernet
>>>>>>>>>>> (only
>>>>>>>>>>> those two computers on the network), and the other sends
>>>>>>>>>>> packets and
>>>>>>>>>>> measures roundtrip time. Most packets comes back in approximately
>>>>>>>>>>> 100
>>>>>>>>>>> us, but occasionally the reception times out (once in about
>>>>>>>>>>> 100000
>>>>>>>>>>> packets or more), but the packets gets immediately received when
>>>>>>>>>>> reception is retried, which might indicate a race between
>>>>>>>>>>> rt_dev_recvmsg
>>>>>>>>>>> and interrupt, but I might miss something obvious.
>>>>>>>>>> Changing one of the ethernet cards to a "Intel Corporation 82541PI
>>>>>>>>>> Gigabit Ethernet Controller (rev 05)", while keeping everything
>>>>>>>>>> else
>>>>>>>>>> constant, changes behavior somewhat; after receiving a few 100000
>>>>>>>>>> packets, reception stops entirely (-EAGAIN is returned), while
>>>>>>>>>> transmission proceeds as it should (and mirror returns packets).
>>>>>>>>>>
>>>>>>>>>> Any suggestions on what to try?
>>>>>>>>> Since the problem disappears with 'maxcpus=1', I suspect I have
>>>>>>>>> a SMP
>>>>>>>>> issue (machine is a Core2 Quad), so I'll move to xenomai-core.
>>>>>>>>> (original message can be found at
>>>>>>>>> http://sourceforge.net/mailarchive/message.php?msg_name=4CC82C8D.3080808%40control.lth.se
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> )
>>>>>>>>>
>>>>>>>>> Xenomai-core gurus: which is the corrrect way to debug SMP issues?
>>>>>>>>> Can I run I-pipe-tracer and expect to be able save at least 150
>>>>>>>>> us of
>>>>>>>>> traces for all cpus? Any hints/suggestions/insigths are welcome...
>>>>>>>> The i-pipe tracer unfortunately only saves traces for a the CPU that
>>>>>>>> triggered the freeze. To have a full pictures, you may want to
>>>>>>>> try my
>>>>>>>> ftrace port I posted recently for 2.6.35.
>>>>>>> 2.6.35.7 ?
>>>>>>>
>>>>>> Exactly.
>>>>> Finally managed to get the ftrace to work
>>>>> (one possible bug: had to manually copy
>>>>> include/xenomai/trace/xn_nucleus.h to
>>>>> include/xenomai/trace/events/xn_nucleus.h), and it looks like it can be
>>>>> very useful...
>>>>>
>>>>> But I don't think it will give much info at the moment, since no
>>>>> xenomai/ipipe interrupt activity shows up, and adding that is far above
>>>>> my league :-(
>>>>
>>>> You could use the function tracer, provided you are able to stop the
>>>> trace quickly enough on error.
>>>>
>>>>> My current theory is that the problem occurs when something like this
>>>>> takes place:
>>>>>
>>>>>   CPU-i        CPU-j        CPU-k        CPU-l
>>>>>
>>>>> rt_dev_sendmsg
>>>>>         xmit_irq
>>>>> rt_dev_recvmsg            recv_irq
>>>>
>>>> Can't follow. When races here, and what will go wrong then?
>>> Thats the good question. Find attached:
>>>
>>> 1. .config (so you can check for stupid mistakes)
>>> 2. console log
>>> 3. latest version of test program
>>> 4. tail of ftrace dump
>>>
>>> These are the xenomai tasks running when the test program is active:
>>>
>>> CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
>>>   0  0      idle    -1      -         master     R          ROOT/0
>>>   1  0      idle    -1      -         master     R          ROOT/1
>>>   2  0      idle    -1      -         master     R          ROOT/2
>>>   3  0      idle    -1      -         master     R          ROOT/3
>>>   0  0      rt      98      -         master     W          rtnet-stack
>>>   0  0      rt       0      -         master     W          rtnet-rtpc
>>>   0  29901  rt      50      -         master                raw_test
>>>   0  29906  rt       0      -         master     X          reporter
>>>
>>>
>>>
>>> The lines of interest from the trace are probably:
>>>
>>> [003]  2061.347855: xn_nucleus_thread_resume: thread=f9bf7b00   
>>>                   thread_name=rtnet-stack mask=2
>>> [003]  2061.347862: xn_nucleus_sched: status=2000000
>>> [000]  2061.347866: xn_nucleus_sched_remote: status=0
>>>
>>> since this is the only place where a packet gets delayed, and the only
>>> place in the trace where sched_remote reports a status=0
>> Since the cpu that has rtnet-stack and hence should be resumed is doing
>> heavy I/O at the time of fault; could it be that
>> send_ipi/schedule_handler needs barriers to make sure taht decisions are
>> made on the right status?
> 
> That was my first idea as well - but we should run all relevant code
> under nklock here. But please correct me if I miss something.

Mmmh -- not everything. The inlined XNRESCHED entry test in
xnpod_schedule runs outside nklock. But doesn't releasing nklock imply a
memory write barrier? Let me meditate...

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

