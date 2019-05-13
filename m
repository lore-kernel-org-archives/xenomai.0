MIME-Version: 1.0
References: <CAAjAsiy=cp_nZsSpfcsE=0YDWppHuT1ZTpFgW4F-b1f6ovbQ+w@mail.gmail.com>
 <d759381b-04de-574e-b3fc-a18873dbb1dc@xenomai.org>
In-Reply-To: <d759381b-04de-574e-b3fc-a18873dbb1dc@xenomai.org>
From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Date: Mon, 13 May 2019 10:49:21 +0200
Message-ID: <CAAjAsixehairsj4U0k2AhS7rvRRPs=gmfpT4VNbuyFC613mXfA@mail.gmail.com>
Subject: Re: [Xenomai] kernel crash when debugging userspace realtime task
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: xenomai@xenomai.org

Il giorno gio 13 set 2018 alle ore 15:57 Philippe Gerum <rpm@xenomai.org>
ha scritto:

> On 09/04/2018 05:59 PM, Matteo Facchinetti wrote:
> > Hi,
> >
> > I'm using the xenomai cobalt kernel with ipipe-core-4.9.51-arm-4.patch
> over
> > a Sitara AM335x custom board.
> > Occur a strange problem  when debugging an userspace task with
> > gdb/gdbserver.
> > In detail, sometimes into a debugging session, kernel crash at the moment
> > that I add a breakpoint in a realtime task.
> >
> >   Unhandled fault: page domain fault (0x01b) at 0x001412dc
> >   (see below for the complete kernel panic)
> >
> > This problem is not easily reproducible because occurs only with the
> > Windows toolchain (gdb in windows environment).
> > With the linux toolcahin never occur but I don't exclude that problem
> exist
> > and it's shadow for any timing reason...
> > With boot toolchain program works correctly if running unless debugging.
> >
> > So, using FTRACE, I take a snapshot of the kernel internals at the moment
> > when problem occurs:
> >
> >   killer-0-510   [000]   152.421095: function:
> >  preempt_count_sub <-- finish_task_switch
> >   killer-0-510   [000]   152.421100: function:             do_DataAbort
> <--
> > __dabt_svc
> >   (see below for the complete FTRACE snapshot)
> >
>
> Please make sure to have the following fix in:
>
>
> https://gitlab.denx.de/Xenomai/ipipe/commit/54ae43b8a64c0bc86b7a34dbb481221f12e75751
>
> Yes, this commit is missing in ipipe-core-4.9.51-arm-4.patch and fix the
problem.

This is an old thread but I'm seeing that this reply never going out to
mailing list...
Thank you very much and apologise for delay in feedback.

Regards,

Matteo
