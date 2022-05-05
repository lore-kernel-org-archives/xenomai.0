Message-ID: <f50fa498-d958-6d08-7404-cf127104fd84@tin.it>
Date: Thu, 5 May 2022 17:04:01 +0200
MIME-Version: 1.0
Subject: Re: RTNet: sendto(): EAGAIN error
Content-Language: it-IT
References: <7e8bd6a5-dce4-04a6-f8b1-b9172f28b208@tin.it>
 <cf925dbe-afe8-470b-5130-16d062c890c9@siemens.com>
From: "Mauro S." <mau.salvi@tin.it>
In-Reply-To: <cf925dbe-afe8-470b-5130-16d062c890c9@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Il 05/05/22 15:05, Jan Kiszka ha scritto:
> On 03.05.22 17:18, Mauro S. via Xenomai wrote:
>> Hi all,
>>
>> I'm trying to use RTNet with TDMA.
>>
>> I succesfully set up my bus:
>>
>> - 1GBps speed
>> - 3 devices
>> - cycle time 1ms
>> - timeslots with 200us offset
>>
>> I wrote a simple application that in parallel receives and sends UDP
>> packets on TDMA bus.
>>
>> - sendto() is done to the broadcast address, port 1111
>> - recvfrom() is done on the port 1111
>>
>> Application sends a small packet (5 bytes) in a periodic task with 1ms
>> period and prio 51. Receive is done in a non-periodic task with prio 50.
>>
>> Application is running on all the three devices, and I can see packets
>> are sent and received correctly by all the devices.
>>
>> But after a while, all send() calls on all devices fails with error EAGAIN.
>>
>> Could this error be related to some internal buffer/queue that becomes
>> full? Or am I missing something?
> 
> When you get EAGAIN on sender side, cleanup of TX buffers likely failed,
> and the socket ran out of buffers to send further frames. That may be
> related to TX IRQs not making it. Check the TX IRQ counter on the
> sender, if it increases at the same pace as you send packets.
> 
> Jan
> 

Thanks Jan for your fast answer.

I forgot to mention that I'm using the rt_igb driver.

I have only one IRQ field in /proc/xenomai/irq, counting both TX and RX

  cat /proc/xenomai/irq | grep rteth0 

   125:         0           0     2312152         0       rteth0-TxRx-0

I did this test:

* on the master I send a packet every 1ms in a periodic RT task (period 
1ms, prio 51) with my test app.

* on the master I see an increment of about 2000 IRQs per second: I 
guess 1000 are for my sent packets (1 packet every ms), and 1000 for the 
TDMA sync packet. In fact I see the "rtifconfig" RX counter almost 
stationary (only 8 packets every 2-3 seconds, refresh requests from 
slaves?), TX counter incrementing in about 2000 packets per second.

* on the two slaves (thet are running nothing) I observe the same rate 
(about 2000 IRQs per second). I see the "rtifconfig" TX counter almost 
stationary (only 4 packets every 2-3 seconds), RX counter incrementing 
in about 2000 packets per second.

* if I stop sending packets with my app, I can see all the rates at 
about 1000 per second

If I start send-receive on all the three devices, I can see a IRQ rate 
around 4000 IRQs per second on all devices (1000 sync, 1000 send and 
1000 + 1000 receive).

I observed that if I only send from master and receive on slaves the 
problem does not appear. Or if I send/receive from all, but with a 
packet every 2ms, the problem does not appear.

Could be a CPU performance problem (4k IRQs per second are too much for 
an Intel Atom x5-E8000 CPU @ 1.04GHz)?


Thanks in advance, regards

-- 
Mauro S.

