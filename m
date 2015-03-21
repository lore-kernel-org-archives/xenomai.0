MIME-Version: 1.0
In-Reply-To: <550D3291.7030100@grandegger.com>
References: <CADvZd9Z8LSPRMAJWb1Tp91i4i9N5wLGMxb3_suaDyFRwRiJd-w@mail.gmail.com>
 <550D3291.7030100@grandegger.com>
Date: Sat, 21 Mar 2015 15:56:53 +0100
Message-ID: <CADvZd9YsJjhjf4pPWdtbK=MGCORyAJ8++0Un44x4ygeFbueEuw@mail.gmail.com>
From: Michael Haberler <haberlerm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] RT-CAN question (was: CAN bus on beaglebone black)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: xenomai <xenomai@xenomai.org>

I'll try the bind/unbind approach and see if I can both stacks to coexist,
that sounds like the most elegant way

thanks!

- Michael

2015-03-21 9:57 GMT+01:00 Wolfgang Grandegger <wg@grandegger.com>:

> On 03/19/2015 10:57 AM, Michael Haberler wrote:
> > status:
> >
> > I have Steve Batazzo's driver running on the beaglebone, using a stock
> > Xenomai kernel from Robert Nelson's repo (linux-image-3.8.13-xenomai-r71
> > from http://repos.rcn-ee.net/debian/), current driver out of tree at
> > https://github.com/mhaberler/rtcan-bb branch mah
> >
> > I also have a preliminary HAL driver for machinekit which talks to a
> > Trinamic motor over RT-CAN just fine (beaglebone for now, x86 once I get
> a
> > CAN PCI card).
> >
> > I'm working with Steve to get the driver polished and hope we can inject
> it
> > into the Xenomai foodchain eventually, after which it will be eventually
> > picked up by Robert's periodic builds, and the whole thing becomes an
> > 'apt-get install' - affair. But we're not there yet.
> >
> >
> > I have a few questions on RT-CAN (I guess really RTDM):
> >
> > - can the RTDM API (
> > https://xenomai.org/documentation/trunk/html/api/group__userapi.html) be
> > used from a normal Posix thread (non-RT) just alike? from the rtcansend*
> > utilities src it looks like at least for setup, even if the send/receive
> > ops are done in an RT thread.
> >
> > - socket-CAN and RT-CAN interworking: I assume this is an either-or
> affair,
> > right? (background: for some jobs the RT-CAN features are overkill, and
> in
> > that case something like the python-can binding would be convenient to
> use)
>
> If the resources (irq, mem, etc.) used by the device are clearly
> separated, it might be possible to use one device (of the same type) for
> Linux and the other for RTCAN. It will work for sure for devices using
> different drivers (belonging to different controllers).
>
> Wolfgang.
>
>
