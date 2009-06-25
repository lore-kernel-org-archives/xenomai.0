Message-ID: <4A435BB1.5050408@domain.hid>
Date: Thu, 25 Jun 2009 13:12:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7ed3bc8b0906231205o47c31453ja95bef2e8f6d3121@domain.hid>
In-Reply-To: <7ed3bc8b0906231205o47c31453ja95bef2e8f6d3121@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_sem_p: No such process
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stuart O Anderson <soa@domain.hid>
Cc: xenomai@xenomai.org

Stuart O Anderson wrote:
> Hello -
> 
> I'm seeing rt_sem_p and rt_sem_broadcast return a "No such process"
> error code, which isn't one of the listed possibilities in the
> documentation.  This must be happening because the call to
> xeno_h2obj_validate on line 495 in ksrc/skins/native/sem.c is
> returning NULL.
> 
> This happens, but not consistently, when I kill one of the two
> user-space realtime processes that are using the semaphore (the other
> one then gets this error every time it tries to touch the semaphore).
> Restarting the second process, and re-binding to the semaphore does
> not stop the error from occurring.

Hi.

the usual details are missing:
- platform,
- version of linux,
- version of xenomai,
- kernel logs,
- simplified but self-contained code which will allow us to reproduce
the problem.

-- 
                                          Gilles


