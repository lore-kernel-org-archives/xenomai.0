MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18351.3120.113165.148859@domain.hid>
Date: Sun, 10 Feb 2008 15:37:36 +0100
In-Reply-To: <47AF057A.3070305@domain.hid>
References: <18350.7135.108901.491437@domain.hid>
	<18350.7315.555644.171720@domain.hid>
	<47AF057A.3070305@domain.hid>
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
 > > stats:
 > >  include/rtdm/rtdm.h        |    4 ++
 > >  include/rtdm/rtdm_driver.h |   30 +++++++++++++++-
 > >  ksrc/skins/rtdm/core.c     |   84 +++++++++++++++++++++++++++++++--------------
 > >  ksrc/skins/rtdm/device.c   |   10 +++++
 > >  ksrc/skins/rtdm/drvlib.c   |   76 ++++++++++++++++++++++++++++++++++++----
 > >  5 files changed, 170 insertions(+), 34 deletions(-)
 > > 
 > 
 > /me thinks that going for inline patches on this list is overdue...
 > 
 > > @@ -1148,8 +1208,8 @@ int rtdm_sem_timeddown(rtdm_sem_t *sem, 
 > >  
 > >  	if (testbits(sem->synch_base.status, RTDM_SYNCH_DELETED))
 > >  		err = -EIDRM;
 > > -	else if (sem->value > 0)
 > > -		sem->value--;
 > > +	else if (sem->value > 0 && !--sem->value)
 > > +			xnselect_signal(&sem->select_block, 0);
 > >  	else if (timeout < 0) /* non-blocking mode */
 > >  		err = -EWOULDBLOCK;
 > >  	else {
 > 
 > Uuuh, this doesn't look equivalent (for --sem->value < 0).
 > 
 > Otherwise it's OK with me.

Yes, of course, what we need is:

if (sem->value > 0) {
     if (!--sem->value)
        xnselect_signal
} else 

...

-- 


					    Gilles Chanteperdrix.

