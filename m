MIME-Version: 1.0
Sender: justinhartubc@gmail.com
In-Reply-To: <53C8F3A2.1030208@xenomai.org>
References: <CAFgu5KVLOB46vh85KV47RT0b4YBsAW_KkLBGRbY_TWhRyrgGMw@mail.gmail.com>
 <53C8F3A2.1030208@xenomai.org>
Date: Fri, 18 Jul 2014 13:46:25 -0700
Message-ID: <CAFgu5KUSwYe-7Vv_-f0QRXvykF1XtK-maNaOvNta3DFiCLmm5A@mail.gmail.com>
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

Hey!  Thanks for helping me out!

It's Core i7.  I fiddled with my kernel a bit, and I'm not sure if I've
made the problem go away or not.  We haven't seen the issue, and I get
better output from xeno clocktest now.  Before I was running with the
generic x86_64 CPU setting.  I switched to the Core 2 setting.  I went
through a few guides and turned some other kernel switches.

Here's my xeno clocktest now.

== Tested clock: 0 (CLOCK_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0           -2659643.6          -62.539          0            0.00
  1           -2659643.4          -62.530          0            0.0
  2           -2659643.5          -62.537          0            0.0
  3           -2659643.3          -62.539          0            0.0
  4           -2659643.3          -62.522          0            0.0
  5           -2659643.6          -62.520          0            0.0
  6           -2659643.5          -62.510          0            0.0
  7           -2659643.4          -62.540          0            0.0

Here's the output of cat /proc/xenomai/timer

status=on+watchdog:setup=74:clock=127588759197708:timerdev=lapic:clockdev=tsc

Does this stuff look kind of correct?

Thanks again for helping me out here!

Justin


On Fri, Jul 18, 2014 at 3:14 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 07/18/2014 08:07 AM, Justin Hart wrote:
> > Hi everyone,
> >
> > I'm experiencing a problem with a kernel I recently patched with Xenomai.
> >  I'm a bit new to Xenomai, so I apologize if this is a silly question or
> > the wrong list.  Basically, the clock on the machine that we have xenomai
> > running on runs very fast.  Additionally, after using the system to
> control
> > our Barrett WAM, We have keyboard issues, wherein a single keystroke will
> > yield a long line of characters.  For example, typing "hello" would give
> > you "hellooooooooooooooooooooooooo."
> >
> > Here's my output from xeno clocktest
> >
> > == Tested clock: 0 (CLOCK_REALTIME)
> > CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> > --- -------------------- ---------------- ---------- --------------
> >   0          674175352.5      -498134.813          0            0.0
> >   1          674175353.8      -498133.887          0            0.0
> >   2          674175451.3      -498135.134          0            0.0
> >   3          674175466.0      -498135.222          0            0.0
> >
> > Is there anywhere that I should start my search, with regards to fixing
> > this?  This is especially important to my group, as our controller for
> the
> > WAM interpolates over time, meaning that the arm lurches and jumps with
> > respect to the clock running incorrectly.
>
> On what architecture do you get this? What does cat /proc/xenomai/timer
> say?
>
> --
>                                                                 Gilles.
>
