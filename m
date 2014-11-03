MIME-Version: 1.0
In-Reply-To: <5457B9DA.5020407@siemens.com>
References: <CADLCHMKk6-tiB=_6T85Z60Vf3ToURF6WRqYMBO46xyTLsuuFUg@mail.gmail.com>
 <CAPRPZsAjU+9NboMvmbafY62hBEw4Sm=wA1Pf-BHP2989E1Dy1g@mail.gmail.com>
 <5457B76B.9040609@siemens.com> <20141103171457.GJ9327@sisyphus.hd.free.fr>
 <5457B9DA.5020407@siemens.com>
From: =?UTF-8?Q?Hasret_Sar=C4=B1yer?= <hsrtsryr@gmail.com>
Date: Mon, 3 Nov 2014 21:30:07 +0200
Message-ID: <CABVE6k2AzFNxyf0oYWuROBf-4c+kaj4g_sEEGgQYZYkksmAxAw@mail.gmail.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks your help.

2014-11-03 19:22 GMT+02:00 Jan Kiszka <jan.kiszka@siemens.com>:

> On 2014-11-03 18:14, Gilles Chanteperdrix wrote:
> > On Mon, Nov 03, 2014 at 06:12:11PM +0100, Jan Kiszka wrote:
> >> On 2014-11-03 09:03, Jeroen Van den Keybus wrote:
> >>>> I try to write a hard real time usb driver. I communicate my device
> using
> >>>> open(), read() etc. My device is a gpio module.
> >>>
> >>>
> >>> I assume you want to control an USB host controller using a GPIO
> interface ?
> >>>
> >>>
> >>>> I am coding a kernel module
> >>>> to communicate the device using xenomai on real time. But I am not
> sure
> >>>> that this way is reasonable. If I should going on this way, what
> should I
> >>>> implement? Could you give me some example or link to write hard real
> time
> >>>> usb driver for* physical* device?
> >>>
> >>>
> >>> I cannot help you with that, but one important issue to consider is
> that
> >>> the USB protocol itself operates with small, hardware controlled time
> slots
> >>> of 1 ms (USB1.x) or 125 usec (USB2.0). You may therefore need a
> significant
> >>> amount of software to properly distribute real-time traffic in these -
> >>> essentially asynchronous - slots. The latency of a real-time process
> >>> waiting for USB data can therefore also be as large as the time slot
> >>> duration. If your real-time requirements are modest, you may be able to
> >>> live with that. Still, count on a major software effort: just have a
> look
> >>> at the Linux USB driver framework.
> >>>
> >>> Alternatively, you could check if you can synchronize your real-time
> >>> process with the USB controller frame rate.
> >>>
> >>
> >> FWIW, we still don't have USB 2.0 support (though I vaguely remember
> >> previous efforts in that direction),
> >
> > There is one here:
> > http://sourceforge.net/projects/usb20rt.berlios/
> >
> > Have not looked at the code though.
>
> Yeah, that's the one I recalled. Seems dead, unfortunately.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RTC ITP SES-DE
> Corporate Competence Center Embedded Linux
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>
