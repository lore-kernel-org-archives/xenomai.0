MIME-Version: 1.0
From: Norbert Lange <nolange79@gmail.com>
Date: Fri, 17 Feb 2017 11:18:53 +0100
Message-ID: <CADYdroOO14+FERqhAqFnnAutRXDxdAVDVD7rZ3Kj2LkpFE0cMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] RtNet and Interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I wonder if the Rtnet Stack is driven at packet level, ie. if after
every one received packet( or even buffer) an IRQ is received.
I worked on a Project where a similar Problem with Ethernet
communication had to be solved, and I just queued up enough receive
buffers and just picked up anything that arrived at the start of a
timeslot.

On 100Mbit and a 1ms timeslot, I calculated a max. of 150 received
pakets. Not that realtime communication can get anywhere close to
that, but you have to deal with worst cases and guarantee that your
system aint missing the cpu time spend in IRQs for other things - even
if you just decide to drop all those packets, the IRQ overhead would
be there.

So is Rtnet using "polling" at timeslots, or irqs?

Kind Regards,
Norbert

PS.
Complete unrelated, but are there any big companies using Xenomai /
Rtnet that can be named?

