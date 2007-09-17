From: Peter Soetens <peter.soetens@domain.hid>
Date: Mon, 17 Sep 2007 15:59:44 +0200
References: <200709071127.17913.peter.soetens@domain.hid>
	<1189882379.25006.181.camel@domain.hid>
In-Reply-To: <1189882379.25006.181.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709171559.44742.peter.soetens@domain.hid>
Subject: Re: [Xenomai-core] [FIX] Summary: Xenomai 2.3.2 and 2.4 lock-ups
	and OOPSes
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

On Saturday 15 September 2007 20:52:59 Philippe Gerum wrote:
> On Fri, 2007-09-07 at 11:27 +0200, Peter Soetens wrote:
> > Just in case you hooked off the long discussion about the issues we found
> > from Xenomai 2.3.2 on:
> >
> >   o We are using the xeno_native skin, create Xeno tasks and semaphores,
> > but have strong indications that the crashes are caused by the memory
> > allocation scheme of Xenomai in combination with task creation/deletion
> >   o We found two ways to break Xenomai, causing a 'Killed'
> > (rt_task_delete) and causing an OOPS (rt_task_join).
> >   o They happen on 2.6.20 and 2.6.22 kernels
> >   o On the 2.3 branch, r2429 works, r2433 causes the faults. The patch is
> > small, and in the ChangLog:
>
> Please try this patch against v2.3.x. A double free issue on a task TCB
> already scheduled for memory release was causing all sorts of troubles,
> basically trashing the system heap afterwards:

Andy just confirmed that this patch fixes his issues !

Thanks a lot,
Peter

-- 
Peter Soetens -- FMTC -- <http://www.fmtc.be>

