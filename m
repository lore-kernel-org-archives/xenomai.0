Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jul 2010 16:56:18 -0500
Message-ID: <181804936ABC2349BE503168465576460F48EB21@domain.hid>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: [Xenomai-help] Timed waits with POSIX skin using CLOCK_REALTIME
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is probably more of a general POSIX programming question.  Some of
the timed wait routines in POSIX (pthread_mutex_timedlock, etc) take an
absolute timeout value in terms of CLOCK_REALTIME.  How then are these
routines not subject to timing error when the CLOCK_REALTIME is changed,
e.g. with clock_settime?

