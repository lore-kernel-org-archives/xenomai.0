MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18145.40512.345477.578858@domain.hid>
Date: Fri, 7 Sep 2007 20:53:52 +0200
In-Reply-To: <1189169200.26986.52.camel@domain.hid>
References: <200709071127.17913.peter.soetens@domain.hid>
	<1189169200.26986.52.camel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Summary: Xenomai 2.3.2 and 2.4
	lock-ups	and	OOPSes
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
 > On Fri, 2007-09-07 at 11:27 +0200, Peter Soetens wrote:
 > > Just in case you hooked off the long discussion about the issues we found from
 > > Xenomai 2.3.2 on:
 > > 
 > >   o We are using the xeno_native skin, create Xeno tasks and semaphores, but 
 > > have strong indications that the crashes are caused by the memory allocation 
 > > scheme of Xenomai in combination with task creation/deletion
 > >   o We found two ways to break Xenomai, causing a 'Killed' (rt_task_delete) 
 > > and causing an OOPS (rt_task_join).
 > >   o They happen on 2.6.20 and 2.6.22 kernels
 > >   o On the 2.3 branch, r2429 works, r2433 causes the faults. The patch is 
 > > small, and in the ChangLog: 
 > > 
 > > 2007-05-11  Philippe Gerum  <rpm@xenomai.org>
 > > 
 > >     * include/nucleus/heap.h (xnfreesafe): Use xnpod_current_p() when
 > >     checking for deferral.
 > > 
 > >     * include/nucleus/pod.h (xnpod_current_p): Give exec mode
 > >     awareness to this predicate, checking for primary/secondary mode
 > >     of shadows.
 > > 
 > > 2007-05-11  Gilles Chanteperdrix  <gilles.chanteperdrix@xenomai.org>
 > > 
 > >     * ksrc/skins: Always defer thread memory release in deletion hook
 > >     by calling xnheap_schedule_free() instead of xnfreesafe().
 > > 
 > >   o We reverted this patch on HEAD of the 2.3 branch, but got -ENOMEM errors 
 > > during Xenomai resource allocations, indicating that later changes depend on 
 > > this patch. So we use clean HEAD again further on to find the causes:
 > >  o A first test (in Orocos) creates one thread, two semaphores, lets it wait 
 > > on them and cleans up the thread.
 > 
 > Please point me at the actual Orocos test code that breaks, with the
 > hope to get a fairly standalone test case from it; if you do have a
 > standalone test case already, this would be even better. I intend to
 > address this issue asap.

Before you have a piece of code that causes the crash, I gave a look at
the code involved. The only suspicious thing I see is that the correct
working of native skins thread termination depends on the execution
order of the two deletion hooks, the one in task.c and the one in
syscall.c. As a matter of fact, if the one in task.c is executed before
the one in syscall.c, the task magic is changed and xnshadow_unmap will
never be called. I suspect this is true for all skins, but I do not know
if this could cause a crash.

-- 


					    Gilles Chanteperdrix.

