Date: Mon, 3 Nov 2014 18:14:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141103171457.GJ9327@sisyphus.hd.free.fr>
References: <CADLCHMKk6-tiB=_6T85Z60Vf3ToURF6WRqYMBO46xyTLsuuFUg@mail.gmail.com>
 <CAPRPZsAjU+9NboMvmbafY62hBEw4Sm=wA1Pf-BHP2989E1Dy1g@mail.gmail.com>
 <5457B76B.9040609@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5457B76B.9040609@siemens.com>
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

On Mon, Nov 03, 2014 at 06:12:11PM +0100, Jan Kiszka wrote:
> On 2014-11-03 09:03, Jeroen Van den Keybus wrote:
> >> I try to write a hard real time usb driver. I communicate my device  using
> >> open(), read() etc. My device is a gpio module.
> > 
> > 
> > I assume you want to control an USB host controller using a GPIO interface ?
> > 
> > 
> >> I am coding a kernel module
> >> to communicate the device using xenomai on real time. But I am not sure
> >> that this way is reasonable. If I should going on this way, what should I
> >> implement? Could you give me some example or link to write hard real time
> >> usb driver for* physical* device?
> > 
> > 
> > I cannot help you with that, but one important issue to consider is that
> > the USB protocol itself operates with small, hardware controlled time slots
> > of 1 ms (USB1.x) or 125 usec (USB2.0). You may therefore need a significant
> > amount of software to properly distribute real-time traffic in these -
> > essentially asynchronous - slots. The latency of a real-time process
> > waiting for USB data can therefore also be as large as the time slot
> > duration. If your real-time requirements are modest, you may be able to
> > live with that. Still, count on a major software effort: just have a look
> > at the Linux USB driver framework.
> > 
> > Alternatively, you could check if you can synchronize your real-time
> > process with the USB controller frame rate.
> > 
> 
> FWIW, we still don't have USB 2.0 support (though I vaguely remember
> previous efforts in that direction),

There is one here:
http://sourceforge.net/projects/usb20rt.berlios/

Have not looked at the code though.

-- 
					    Gilles.

