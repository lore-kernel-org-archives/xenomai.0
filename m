Date: Mon, 6 Oct 2014 00:30:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141005223051.GN14975@sisyphus.hd.free.fr>
References: <542EA6A2.306@xenomai.org>
 <CACreCVKe_nw=6p1xQkbziPne4cW74kx0EtUWG0kC4roS7+w+yw@mail.gmail.com>
 <20141003191454.GF9452@sisyphus.hd.free.fr>
 <CACreCVLi=QT72p0pca76_7tsJn+TazdQjyy7NHW_NwfxCYbuKA@mail.gmail.com>
 <20141003224829.GA6850@sisyphus.hd.free.fr>
 <CACreCV+TDzXxX=e7MpscYcGn1sTTye9N-mED0iPfqVB9Zm4xdQ@mail.gmail.com>
 <20141004113116.GC7596@sisyphus.hd.free.fr>
 <CACreCV+ok_Ogd3iFPGNS3n640hdLQC3C_Pyzz=w80St-7buXWQ@mail.gmail.com>
 <20141005220404.GL14975@sisyphus.hd.free.fr>
 <CACreCVJFa6FB=3WR_OuMvACeYOWaA035T4KK7dFg8vHhyqkz8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACreCVJFa6FB=3WR_OuMvACeYOWaA035T4KK7dFg8vHhyqkz8w@mail.gmail.com>
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

On Mon, Oct 06, 2014 at 06:24:53AM +0800, GP Orcullo wrote:
> On Mon, Oct 6, 2014 at 6:04 AM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> > On Mon, Oct 06, 2014 at 06:00:23AM +0800, GP Orcullo wrote:
> >> The cause of the lockups is due to CONFIG_PREEMPT. The board is
> >> running for more than 6 hrs now after disabling it.
> >>
> >> Thanks for all your help!
> >
> > Xenomai runs fine with CONFIG_PREEMPT. The reason why CONFIG_PREEMPT
> > may be an issue is if you are using "preempt_disable" or
> > "preempt_enable", which use current, in a place where you
> > should not (on the context of a kernel-space thread for
> > instance). This happens for instance when using a plain Linux
> > spinlock in real-time code.
> >
> > But this should not happen.
> >
>
> Before disabling CONFIG_PREEMPT, I've been seeing this line:
>
> [  123.982550] hrtimer: interrupt took 280933 ns
>
> Is this normal?
>

It means that Linux was interrupted by Xenomai during its timer
interrupt, and that Xenomai interrupted it for 280us. This may
happens with switchtest if it has a really long chain of context
switches. If you want to check what happened, enable the I-pipe
tracer, and trigger a trace freeze right before this message.

--
					    Gilles.

