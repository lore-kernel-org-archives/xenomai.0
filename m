MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17241.59867.844871.19639@domain.hid>
Date: Sat, 22 Oct 2005 09:27:23 +0200
Subject: Re: [Xenomai-help] Strangeness in named Semaphores(xenomai posix skin)
In-Reply-To: <435967A7.6060903@domain.hid>
References: <43590FD1.5030503@domain.hid>
	<17241.24548.920222.440189@domain.hid>
	<435967A7.6060903@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Luotao Fu <devtty0@domain.hid>
Cc: xenomai@xenomai.org

Luotao Fu wrote:
 > Thanx Gilles, I've just sent out another mail to this thread before I
 > noticed your mail. Well sorry for the delay than. I found the
 > sem_timedwait in posix_overrides.h
 >  #define sem_timedwait pse51_sem_timedwait
 > so I thought it'll be handled by the posix skin.

posix_overrides.h is used for compilation of the POSIX skin for the
simulator, not for the userspace POSIX skin library.

 > > When calling sem_open with the O_CREAT flag, you have to pass a "mode"
 > > and most importantly a "value" argument which is the initial value of
 > > the semaphore. Your also make the assumption that 0 is a valid numeric
 > > value for the enum O_RDONLY/O_WRONLY/O_RDWR.
 > >
 > 
 > oh, hell yeah, forgot it.

Actually, you do not have to pass O_RDONLY/O_WRONLY/O_RDWR flags to
sem_open. I was mixing sem_open and mq_open. Sorry.

-- 


					    Gilles Chanteperdrix.

