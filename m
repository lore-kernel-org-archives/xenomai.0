MIME-Version: 1.0
Date: Mon, 3 Nov 2014 02:10:46 +0200
Message-ID: <CADLCHMKk6-tiB=_6T85Z60Vf3ToURF6WRqYMBO46xyTLsuuFUg@mail.gmail.com>
From: Seda Seda <seda9seda9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Write a hard real time usb driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello everyone,

I try to write a hard real time usb driver. I communicate my device  using
open(), read() etc. My device is a gpio module.I am coding a kernel module
to communicate the device using xenomai on real time. But I am not sure
that this way is reasonable. If I should going on this way, what should I
implement? Could you give me some example or link to write hard real time
usb driver for* physical* device? I wrote a driver for virtual device, it
was ok.
