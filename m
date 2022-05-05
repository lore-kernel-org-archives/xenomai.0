Message-ID: <cf925dbe-afe8-470b-5130-16d062c890c9@siemens.com>
Date: Thu, 5 May 2022 15:05:45 +0200
MIME-Version: 1.0
Subject: Re: RTNet: sendto(): EAGAIN error
Content-Language: en-US
References: <7e8bd6a5-dce4-04a6-f8b1-b9172f28b208@tin.it>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <7e8bd6a5-dce4-04a6-f8b1-b9172f28b208@tin.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Mauro S." <mau.salvi@tin.it>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03.05.22 17:18, Mauro S. via Xenomai wrote:
> Hi all,
> 
> I'm trying to use RTNet with TDMA.
> 
> I succesfully set up my bus:
> 
> - 1GBps speed
> - 3 devices
> - cycle time 1ms
> - timeslots with 200us offset
> 
> I wrote a simple application that in parallel receives and sends UDP
> packets on TDMA bus.
> 
> - sendto() is done to the broadcast address, port 1111
> - recvfrom() is done on the port 1111
> 
> Application sends a small packet (5 bytes) in a periodic task with 1ms
> period and prio 51. Receive is done in a non-periodic task with prio 50.
> 
> Application is running on all the three devices, and I can see packets
> are sent and received correctly by all the devices.
> 
> But after a while, all send() calls on all devices fails with error EAGAIN.
> 
> Could this error be related to some internal buffer/queue that becomes
> full? Or am I missing something?

When you get EAGAIN on sender side, cleanup of TX buffers likely failed,
and the socket ran out of buffers to send further frames. That may be
related to TX IRQs not making it. Check the TX IRQ counter on the
sender, if it increases at the same pace as you send packets.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

