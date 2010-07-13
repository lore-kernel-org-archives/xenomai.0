Message-ID: <4C3CE5C3.30403@domain.hid>
Date: Wed, 14 Jul 2010 00:16:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <181804936ABC2349BE503168465576460F48EB21@domain.hid>
In-Reply-To: <181804936ABC2349BE503168465576460F48EB21@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Timed waits with POSIX skin using CLOCK_REALTIME
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

Steve Deiters wrote:
> This is probably more of a general POSIX programming question.  Some of
> the timed wait routines in POSIX (pthread_mutex_timedlock, etc) take an
> absolute timeout value in terms of CLOCK_REALTIME.  How then are these
> routines not subject to timing error when the CLOCK_REALTIME is changed,
> e.g. with clock_settime?

I am not sure I understand the question. We tried and implement what is
described for instance here:

http://www.opengroup.org/onlinepubs/009695399/functions/clock_settime.html

-- 
					    Gilles.

