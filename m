Message-ID: <4CCEF104.7050409@domain.hid>
Date: Mon, 01 Nov 2010 17:55:32 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <4CC82C8D.3080808@domain.hid> <4CC84327.9070202@domain.hid>
	<4CC92786.3030509@domain.hid> <4CC92902.4040904@domain.hid>
	<4CC943A2.9020806@domain.hid> <4CC94E0B.9070106@domain.hid>
In-Reply-To: <4CC94E0B.9070106@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Am 28.10.2010 11:34, Anders Blomdell wrote:
>> Jan Kiszka wrote:
>>> Am 28.10.2010 09:34, Anders Blomdell wrote:
>>>> Anders Blomdell wrote:
>>>>> Anders Blomdell wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I'm trying to use rt_eepro100, for sending raw ethernet packets,
>>>>>> but I'm
>>>>>> experincing occasionally weird behaviour.
>>>>>>
>>>>>> Versions of things:
>>>>>>
>>>>>>   linux-2.6.34.5
>>>>>>   xenomai-2.5.5.2
>>>>>>   rtnet-39f7fcf
>>>>>>
>>>>>> The testprogram runs on two computers with "Intel Corporation
>>>>>> 82557/8/9/0/1 Ethernet Pro 100 (rev 08)" controller, where one
>>>>>> computer
>>>>>> acts as a mirror sending back packets received from the ethernet (only
>>>>>> those two computers on the network), and the other sends packets and
>>>>>> measures roundtrip time. Most packets comes back in approximately 100
>>>>>> us, but occasionally the reception times out (once in about 100000
>>>>>> packets or more), but the packets gets immediately received when
>>>>>> reception is retried, which might indicate a race between
>>>>>> rt_dev_recvmsg
>>>>>> and interrupt, but I might miss something obvious.
>>>>> Changing one of the ethernet cards to a "Intel Corporation 82541PI
>>>>> Gigabit Ethernet Controller (rev 05)", while keeping everything else
>>>>> constant, changes behavior somewhat; after receiving a few 100000
>>>>> packets, reception stops entirely (-EAGAIN is returned), while
>>>>> transmission proceeds as it should (and mirror returns packets).
>>>>>
>>>>> Any suggestions on what to try?
>>>> Since the problem disappears with 'maxcpus=1', I suspect I have a SMP
>>>> issue (machine is a Core2 Quad), so I'll move to xenomai-core.
>>>> (original message can be found at
>>>> http://sourceforge.net/mailarchive/message.php?msg_name=4CC82C8D.3080808%40control.lth.se
>>>> )
>>>>
>>>> Xenomai-core gurus: which is the corrrect way to debug SMP issues?
>>>> Can I run I-pipe-tracer and expect to be able save at least 150 us of
>>>> traces for all cpus? Any hints/suggestions/insigths are welcome...
>>> The i-pipe tracer unfortunately only saves traces for a the CPU that
>>> triggered the freeze. To have a full pictures, you may want to try my
>>> ftrace port I posted recently for 2.6.35.
>> 2.6.35.7 ?
>>
> 
> Exactly.
Finally managed to get the ftrace to work
(one possible bug: had to manually copy 
include/xenomai/trace/xn_nucleus.h to 
include/xenomai/trace/events/xn_nucleus.h), and it looks like it can be 
very useful...

But I don't think it will give much info at the moment, since no 
xenomai/ipipe interrupt activity shows up, and adding that is far above 
my league :-(

My current theory is that the problem occurs when something like this 
takes place:

   CPU-i		CPU-j		CPU-k		CPU-l

rt_dev_sendmsg
		xmit_irq
rt_dev_recvmsg			recv_irq

So now I'll try to instrument the code to see if the assumtion holds. 
Stay tuned...

Regards

Anders



