MIME-Version: 1.0
In-Reply-To: <20141111161744.GB24110@csclub.uwaterloo.ca>
References: <CAJt3u5nf_epaPjW=dAjqGMq85dgRYqwn-MKcRGFWby+MXtvong@mail.gmail.com>
 <20141111110937.GY17476@sisyphus.hd.free.fr>
 <20141111153745.GX24110@csclub.uwaterloo.ca>
 <20141111154611.GD17476@sisyphus.hd.free.fr>
 <20141111155212.GZ24110@csclub.uwaterloo.ca>
 <20141111155447.GE17476@sisyphus.hd.free.fr>
 <20141111155642.GA24110@csclub.uwaterloo.ca>
 <20141111160236.GF17476@sisyphus.hd.free.fr>
 <20141111161744.GB24110@csclub.uwaterloo.ca>
Date: Tue, 11 Nov 2014 22:29:37 +0530
Message-ID: <CAJt3u5=nBbiqOZ6kFsXujHtbGyz6GhQO10F-=rpc0WpXFj+zZw@mail.gmail.com>
From: Madan Sondur <sondur.madan23@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] USB3.0 drivers for xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: lsorense@csclub.uwaterloo.ca
Cc: xenomai@xenomai.org

Hi,

Yes, I am looking for full bandwidth speeds offered by USB3.0 which is upto
5Gbps. However the HDD portable device is recognising as only as USB 2.0
and the data speed is only upto 45MBps.

I have heard there are some in consisitencies in USB3.0 driver
implementation in linux. The USB3.0 driver uses xHCI where as the USB2.0
uses eHCI.

Can Anyone give some insight into this?
Thanks

MADAN
On 11 Nov 2014 21:47, "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
wrote:

> On Tue, Nov 11, 2014 at 05:02:36PM +0100, Gilles Chanteperdrix wrote:
> > Is the 1kHz limit imposed by the USB protocol, or by the OS? Because
> > if that is an OS timer, Xenomai can do 10kHz on most platforms (ok,
> > not on armv4, armv5, maybe not on armv6 either, but definitely on
> > cortex a8 or better)
>
> The USB standard says you may poll up to 8000Hz for High speed devices,
> 1000HZ on Full speed devices, and up to 100Hz on Low speed devices.
> Not quite sure if that is only for interrupt transfers, or if it is
> any quick status update you want.  Bulk transfers have no promise of
> timely handling.  I suppose 8000Hz ought to be pretty decent for most
> things.
>
> My understanding is that there is no such thing on USB3 since it is full
> duplex and has interrupts directly when needed.
>
> It might be possible to just do a request to the device whenever you
> want to get your data though.  Not quite sure if that works or if it is
> still limited to the polling rate of the bus.
>
> --
> Len Sorensen
>
