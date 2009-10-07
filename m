From: oliver.schlenker@domain.hid
Date: Wed, 7 Oct 2009 13:44:23 +0000
Message-ID: <DIIE.000001A60000AC7F@192.168.2.103>
MIME-Version: 1.0
Content-Type: text/plain;
 charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Re-6:  rt_printf with daemonized task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org




in the glibc documentation it's specified as a void function :

18.2.2 syslog, vsyslog

The symbols referred to in this section are declared in the file =
syslog.h.
=97 Function: void syslog (int facility_priority, char *format, ...)



There are also no references to errno in the documentation.

Did try already with explicit openlog() function call and setlogmask()
but result is the same.


Oliver


-------- Original Message --------
Subject: Re: Re-4: [Xenomai-help] rt_printf with daemonized task =
(07-Okt-2009 15:39)
From:    Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
To:      oliver.schlenker@domain.hid

> oliver.schlenker@domain.hid wrote:
> > syslogd/klogd daemon is running correctly, it's used on the same
> > system by a lot of other processes.
>=20
> Did you try to check the return value of the syslog() syscall?
>=20
> --=20
>                                           Gilles
>=20


To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org



