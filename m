MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17379.33558.298551.326552@domain.hid>
Date: Fri, 3 Feb 2006 17:21:42 +0100
Subject: Re: [Xenomai-core] [PATCH] fix pthread cancellation in native skin
In-Reply-To: <43E10708.3030109@domain.hid>
References: <43DB3AB1.5090004@domain.hid>
	<17373.63969.941760.677529@domain.hid>
	<17376.43570.396834.405041@domain.hid>
	<43E0FCB8.1050902@domain.hid> <43E10708.3030109@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Philippe Gerum wrote:
 > Philippe Gerum wrote:
 > > Gilles Chanteperdrix wrote:
 > > 
 > >> Gilles Chanteperdrix wrote:
 > >>  > This is not the only situation where a thread with a nucleus 
 > >> suspension
 > >>  > bit need to run shortly in secondary mode: it also occurs when
 > >>  > suspending with xnpod_suspend_thread() a thread running in secondary
 > >>  > mode; the thread receives the SIGCHLD signal and need to execute 
 > >> shortly
 > >>  > with the suspension bit set in order to cause a migration to primary
 > >>  > mode.
 > >>  >  > So, the only case when we are sure that a user-space thread can 
 > >> not be
 > >>  > scheduled by Linux seems to be when this thread does not have the
 > >>  > XNRELAX bit.
 > >>
 > >> From all the bits in XNTHREAD_BLOCK_BITS, only when the XNPEND bit is
 > >> set, a thread can not be running in secondary mode. Hence the proposed
 > >> patch.
 > >>
 > > 
 > > Almost ok, but XNDELAY might also be set alone, indicating a purely 
 > > timed wait state (i.e. without sync object to pend on, so XNPEND is off).
 > > 
 > 
 > Forget about this: XNDELAY might also be a transient bit like XNSUSP, so you are 
 > right, we cannot test it there.

Ok. The patch is applied to svn trunk.

-- 


					    Gilles Chanteperdrix.

