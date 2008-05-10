MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18470.9287.958484.497706@domain.hid>
Date: Sun, 11 May 2008 00:40:07 +0200
In-Reply-To: <4826058B.4090103@domain.hid>
References: <4e888e043f64dd610bf15a02a955a84b@domain.hid>
	<4826058B.4090103@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] VxWorks skin problem concerning
	WIND_TCB	structure
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > Matthieu wrote:
 > > Im currently porting a VxWorks Application in SuSE Linux patched with
 > > Xenomai. I encounter some problems with the taskLib.h emulation. Indeed,
 > > Ive got an error concerning WIND_TCB structure. I think that not the
 > > whole structure is implemented or maybe its implemented by Xenomai
 > > Native API and not VxWorks skin.
 > >
 > 
 > Implementing the whole WIND_TCB structure is out of scope. Most of the fields
 > you attempt to access in your app are dependent on the VxWorks innards, which is
 > meaningless in an emulation environment. You can emulate the others (or their
 > meaning) fairly easily (e.g. pStackBase and status).
 > 
 > > Here are extracts of Code.c:
 > >  #include <vxworks/vxworks.h>
 > >  WIND_TCB * pTcb;
 > >  pTcb->entry
 > >  pTcb->lockCnt
 > >  pTcb->pSignalInfo->sigt_blocked

... And you may access signal mask with the posix pthread_sigmask
service (if the first sigset_t pointer is NULL, the "how" argument is
ignored, and the only effect of the service is to copy the current
signal mask).

-- 


					    Gilles.

