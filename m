MIME-Version: 1.0
In-Reply-To: <CADLCHMKk6-tiB=_6T85Z60Vf3ToURF6WRqYMBO46xyTLsuuFUg@mail.gmail.com>
References: <CADLCHMKk6-tiB=_6T85Z60Vf3ToURF6WRqYMBO46xyTLsuuFUg@mail.gmail.com>
Date: Mon, 3 Nov 2014 09:03:15 +0100
Message-ID: <CAPRPZsAjU+9NboMvmbafY62hBEw4Sm=wA1Pf-BHP2989E1Dy1g@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Write a hard real time usb driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Seda Seda <seda9seda9@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> I try to write a hard real time usb driver. I communicate my device  using
> open(), read() etc. My device is a gpio module.


I assume you want to control an USB host controller using a GPIO interface ?


> I am coding a kernel module
> to communicate the device using xenomai on real time. But I am not sure
> that this way is reasonable. If I should going on this way, what should I
> implement? Could you give me some example or link to write hard real time
> usb driver for* physical* device?


I cannot help you with that, but one important issue to consider is that
the USB protocol itself operates with small, hardware controlled time slots
of 1 ms (USB1.x) or 125 usec (USB2.0). You may therefore need a significant
amount of software to properly distribute real-time traffic in these -
essentially asynchronous - slots. The latency of a real-time process
waiting for USB data can therefore also be as large as the time slot
duration. If your real-time requirements are modest, you may be able to
live with that. Still, count on a major software effort: just have a look
at the Linux USB driver framework.

Alternatively, you could check if you can synchronize your real-time
process with the USB controller frame rate.


Jeroen.
