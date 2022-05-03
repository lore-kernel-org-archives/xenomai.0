Message-ID: <7e8bd6a5-dce4-04a6-f8b1-b9172f28b208@tin.it>
Date: Tue, 3 May 2022 17:18:22 +0200
MIME-Version: 1.0
Content-Language: it-IT
From: "Mauro S." <mau.salvi@tin.it>
Subject: RTNet: sendto(): EAGAIN error
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
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all,

I'm trying to use RTNet with TDMA.

I succesfully set up my bus:

- 1GBps speed
- 3 devices
- cycle time 1ms
- timeslots with 200us offset

I wrote a simple application that in parallel receives and sends UDP 
packets on TDMA bus.

- sendto() is done to the broadcast address, port 1111
- recvfrom() is done on the port 1111

Application sends a small packet (5 bytes) in a periodic task with 1ms 
period and prio 51. Receive is done in a non-periodic task with prio 50.

Application is running on all the three devices, and I can see packets 
are sent and received correctly by all the devices.

But after a while, all send() calls on all devices fails with error EAGAIN.

Could this error be related to some internal buffer/queue that becomes 
full? Or am I missing something?

Thanks in advance, regards


-- 
Mauro S.

