Date: Sat, 4 Oct 2014 00:48:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141003224829.GA6850@sisyphus.hd.free.fr>
References: <542D87AA.6000607@xenomai.org>
 <CACreCVK=dt7Cj87FohsCLxpmGRXcUvuKS6Ki_=-yyxUW3L1oqQ@mail.gmail.com>
 <20141003072059.GA2450@sisyphus.hd.free.fr>
 <CACreCVLij_wUhe3pkpd7fjHKQV0=+NZf3a_EXoWzJu5v9Oon-Q@mail.gmail.com>
 <20141003085757.GI2450@sisyphus.hd.free.fr>
 <CACreCV+0uY+j2ZSGP7xUpQQ7_J=3tgtC+5UXxfqxd852719xXg@mail.gmail.com>
 <542EA6A2.306@xenomai.org>
 <CACreCVKe_nw=6p1xQkbziPne4cW74kx0EtUWG0kC4roS7+w+yw@mail.gmail.com>
 <20141003191454.GF9452@sisyphus.hd.free.fr>
 <CACreCVLi=QT72p0pca76_7tsJn+TazdQjyy7NHW_NwfxCYbuKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACreCVLi=QT72p0pca76_7tsJn+TazdQjyy7NHW_NwfxCYbuKA@mail.gmail.com>
Subject: Re: [Xenomai] Switchtest failures on ODROIDU3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: GP Orcullo <kinsamanka@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On Sat, Oct 04, 2014 at 06:45:08AM +0800, GP Orcullo wrote:
> On Sat, Oct 4, 2014 at 3:14 AM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> > On Fri, Oct 03, 2014 at 11:28:52PM +0800, GP Orcullo wrote:
> >> I've added BUG_ON(!hard_irqs_disabled()) to the code and got the
> >> kernel to oops at startup.
> >>
> >> Where shall I start looking for the offending code?
> >
> > The thing is, all the tracepoints you have are late after the
> > fault. A better strategy is to replace BUG_ON(!hard_irqs_disabled)
> > with:
> >
> > if (!hard_irqs_disabled()) {
> >    ipipe_trace_panic_freeze();
> >    ipipe_trace_panic_dump();
> >    BUG();
> > }
> >
>
> The results are almost similar.
>

> [   15.550769] Unable to handle kernel NULL pointer dereference at virtual address 0000000c

This is not caused by the code above. This is another bug.

With the code above, you should see a line
"BUG" or something.

--
					    Gilles.

