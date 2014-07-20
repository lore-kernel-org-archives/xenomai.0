MIME-Version: 1.0
Sender: justinhartubc@gmail.com
In-Reply-To: <53CA5CBB.4050703@xenomai.org>
References: <CAFgu5KVLOB46vh85KV47RT0b4YBsAW_KkLBGRbY_TWhRyrgGMw@mail.gmail.com>
 <53C8F3A2.1030208@xenomai.org>
 <CAFgu5KUSwYe-7Vv_-f0QRXvykF1XtK-maNaOvNta3DFiCLmm5A@mail.gmail.com>
 <53CA5CBB.4050703@xenomai.org>
Date: Sat, 19 Jul 2014 21:51:37 -0700
Message-ID: <CAFgu5KWZKERZtxTOXvowEwMK_NLGZeg-EgdR7nzY6rDQAhgq6g@mail.gmail.com>
From: Justin Hart <justin.hart@mech.ubc.ca>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Large clock drift, keyboard issues
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Either way, this is way better than it was.  The way it was, we were *way
way way* off.


On Sat, Jul 19, 2014 at 4:55 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 07/18/2014 10:46 PM, Justin Hart wrote:
> > Hey!  Thanks for helping me out!
> >
> > It's Core i7.  I fiddled with my kernel a bit, and I'm not sure if I've
> > made the problem go away or not.  We haven't seen the issue, and I get
> > better output from xeno clocktest now.  Before I was running with the
> > generic x86_64 CPU setting.  I switched to the Core 2 setting.  I went
> > through a few guides and turned some other kernel switches.
> >
> > Here's my xeno clocktest now.
> >
> > == Tested clock: 0 (CLOCK_REALTIME)
> > CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> > --- -------------------- ---------------- ---------- --------------
> >   0           -2659643.6          -62.539          0            0.00
> >   1           -2659643.4          -62.530          0            0.0
> >   2           -2659643.5          -62.537          0            0.0
> >   3           -2659643.3          -62.539          0            0.0
> >   4           -2659643.3          -62.522          0            0.0
> >   5           -2659643.6          -62.520          0            0.0
> >   6           -2659643.5          -62.510          0            0.0
> >   7           -2659643.4          -62.540          0            0.0
> >
> > Here's the output of cat /proc/xenomai/timer
> >
> >
> status=on+watchdog:setup=74:clock=127588759197708:timerdev=lapic:clockdev=tsc
>
> Yes lapic + tsc is the best configuration on x86. A 62ppm drift seems a
> bit high, but I guess it is due to the fact that the kernel refines the
> tsc frequency, and xenomai uses the frequency before refinement.
>
> --
>                                                                 Gilles.
>
