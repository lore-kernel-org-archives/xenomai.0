From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17587.39959.680285.380122@domain.hid>
Date: Tue, 11 Jul 2006 14:39:51 +0200
Subject: Re: AW: AW: [Xenomai-help] memset of heap crashes Xenomai-Task
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A3F9283@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2A3F9283@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik_Wildenburg@domain.hid wrote:
 > > > 
 > > > The are some long delays (approx. 40 secs) around __alloc_pages. 
 > > > Finally it crashes in memset. With the attached xenomai 
 > > patch, which 
 > > > touches the reserved page once, memset works fine. Let's wait what 
 > > > Philippe says. I remember that the "touch" was needed for 
 > > RTAI shared memory as well.
 > > 
 > > What is the difference between touching the page in kernel 
 > > space and in user space? Is there no risk that the kernel 
 > > will oops then at some point? Do we get the same result when 
 > > touching the heap pages in user space immediately after 
 > > rt_help_alloc'ing them? Roderik's demo allocates first and 
 > > then touches/memsets. [I have no problem with the patch, I'm 
 > > just trying to understand the mechanism.]
 > > 
 > 
 > Presumed that touch means "use it" (=memset) I tried to allocate a block
 > 
 > and immediatelly use it (use memset before new heap is created).
 > But this causes a segmentation fault too.
 > Inspired by Gilles I set /proc/sys/vm/overcommit_memory to 2, which
 > worsens
 > the task behaviour (it crashes every time, not just some times).
 > Do you have any further suggestions ?

Maybe the task is in fact killed by the OOM killer ? It would prove that
this function is working correctly, since the killed task is the one
that allocates all the memory. Is there no trace in the logs ?

-- 


					    Gilles Chanteperdrix.

