MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18351.33025.627723.573639@domain.hid>
Date: Sun, 10 Feb 2008 23:56:01 +0100
In-Reply-To: <47AF7F3C.6080805@domain.hid>
References: <18350.7135.108901.491437@domain.hid>
	<18350.7315.555644.171720@domain.hid>
	<47AF057A.3070305@domain.hid>
	<18351.28960.164520.295075@domain.hid>
	<47AF781E.4070102@domain.hid>
	<18351.31369.697255.825404@domain.hid>
	<47AF7F3C.6080805@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [patch 2/4] RTDM support for select-like service.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Jan Kiszka wrote:
 > >  > Gilles Chanteperdrix wrote:
 > >  > > Jan Kiszka wrote:
 > >  > >  > Gilles Chanteperdrix wrote:
 > >  > >  > > stats:
 > >  > >  > >  include/rtdm/rtdm.h        |    4 ++
 > >  > >  > >  include/rtdm/rtdm_driver.h |   30 +++++++++++++++-
 > >  > >  > >  ksrc/skins/rtdm/core.c     |   84 +++++++++++++++++++++++++++++++--------------
 > >  > >  > >  ksrc/skins/rtdm/device.c   |   10 +++++
 > >  > >  > >  ksrc/skins/rtdm/drvlib.c   |   76 ++++++++++++++++++++++++++++++++++++----
 > >  > >  > >  5 files changed, 170 insertions(+), 34 deletions(-)
 > >  > >  > > 
 > >  > >  > 
 > >  > >  > /me thinks that going for inline patches on this list is overdue...
 > >  > >  > 
 > >  > >  > > @@ -1148,8 +1208,8 @@ int rtdm_sem_timeddown(rtdm_sem_t *sem, 
 > >  > >  > >  
 > >  > >  > >  	if (testbits(sem->synch_base.status, RTDM_SYNCH_DELETED))
 > >  > >  > >  		err = -EIDRM;
 > >  > >  > > -	else if (sem->value > 0)
 > >  > >  > > -		sem->value--;
 > >  > >  > > +	else if (sem->value > 0 && !--sem->value)
 > >  > >  > > +			xnselect_signal(&sem->select_block, 0);
 > >  > >  > >  	else if (timeout < 0) /* non-blocking mode */
 > >  > >  > >  		err = -EWOULDBLOCK;
 > >  > >  > >  	else {
 > >  > >  > 
 > >  > >  > Uuuh, this doesn't look equivalent (for --sem->value < 0).
 > >  > >  > 
 > >  > >  > Otherwise it's OK with me.
 > >  > > 
 > >  > > After testing, it appears that the "owner" of a file descriptor changed from 
 > >  > > current->mm 
 > >  > > to
 > >  > > container_of(xnshadow_ppd_get(__rtdm_muxid), struct rtdm_process, ppd)
 > >  > 
 > >  > Yes, indeed, forgot about it. We have a full-blown owner structure now
 > >  > to track comm and pid.
 > >  > 
 > >  > > 
 > >  > > So, I now need a ppd hash lookup in __rtdm_context_get.
 > >  > > 
 > >  > 
 > >  > You could add mm to rtdm_process. This means another indirection and
 > >  > makes things worse (more cache misses in the worst case...).
 > > 
 > > Would not it be simpler to put a pointer to the task_struct ? After all,
 > > it already has a pid, comm and mm, and a file descriptor will not
 > > survive a task_struct thanks to automatic closing of file descriptors.
 > 
 > Hmm, hmm, hmmmm... Sounds reasonable, should be safe.
 > 
 > > 
 > >  Could you
 > >  > live without the check until we have per-process fd tabled, or was it
 > >  > essential for the select thing?
 > > 
 > > An application which I ported to Xenomai (and which uses the select
 > > call) closes all file descriptors in a for loop. The purpose of this
 > > loop is, I guess, to avoid leaving a file descriptor opened that was
 > > passed through exec.
 > 
 > OK.
 > 
 > So, will you change rtdm_process too? Thanks.

Ok, but I will send the new patch tomorrow.

-- 


					    Gilles Chanteperdrix.

