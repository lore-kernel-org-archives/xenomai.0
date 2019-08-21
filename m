MIME-Version: 1.0
References: <CAD5jUk-fwG0SDyn+bDxxgR0=+wTEW7BWi0UDSS5SUy6fcK-Q8Q@mail.gmail.com>
 <19948996-aaf3-694f-0b7e-f37968ee8c8b@siemens.com>
In-Reply-To: <19948996-aaf3-694f-0b7e-f37968ee8c8b@siemens.com>
From: Radu Rendec <radu.rendec@gmail.com>
Date: Wed, 21 Aug 2019 17:43:12 -0400
Message-ID: <CAD5jUk_BdYLs4MNUFtr5oc+1orrHVMmEA7_ZBt_M6H5X=dZN1Q@mail.gmail.com>
Subject: Re: Freeze using Linux function tracer on Xenomai 2.6
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Wed, Aug 21, 2019 at 1:03 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 21.08.19 17:43, Radu Rendec via Xenomai wrote:
> >
> > Having said that, I enabled the Linux function tracer in the kernel
> > configuration and I experience a complete system freeze when I try to
> > activate it. Basically I'm doing this:
> >
> >    mount debugfs /sys/kernel/debug/ -t debugfs
> >    echo function > /sys/kernel/debug/tracing/current_tracer
> >
> > At that point I get a freeze. The system eventually reboots, but after
> > 10 minutes or so - even though no hardware watchdog is enabled.
> >
> > I'm running Xenomai 2.6.5 on Linux 3.2.102, on a PowerPC e300 (Freescale
> > MPC8378). Only Busybox init, sshd and a Busybox shell are running at the
> > time this happens.
>
> I never hacked on ppc, but I would bet that ftrace & Co. was never hardened
> there for use under Xenomai. Then, it may work for some time by luck and later
> crash randomly.
>
> Maybe the ipipe tracer worked there.

That makes sense, thanks for the hint!

Is there any (old) documentation that describes how to use the ipipe
tracer? I found this:
https://gitlab.denx.de/Xenomai/xenomai/wikis/Using_The_I_Pipe_Tracer
but it doesn't say how to start or read the traces.

I'm calling ipipe_trace_begin()/ipipe_trace_end() and trying to read
traces from /sys/kernel/debug/tracing/trace, but nothing seems to get
written to the kernel trace buffer. I'm obviously doing something wrong.

FWIW, I did enable the CONFIG_IPIPE_TRACE option.

Thanks,
Radu

