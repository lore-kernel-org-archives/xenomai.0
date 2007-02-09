Message-ID: <45CC7E33.3020707@domain.hid>
Date: Fri, 09 Feb 2007 14:59:15 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] system() question
References: <45C9F9CD.6000101@domain.hid>	<45C9F2F9.3020204@domain.hid>	<45CAE1C2.5040207@domain.hid>
	<17866.56537.695811.3523@domain.hid>
	<45CC8A19.6080109@domain.hid>
In-Reply-To: <45CC8A19.6080109@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: Quoted-Printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

St=E9phane ANCELOT wrote:
> I tried it, but did not help, I manged to do the trick using=20
> start-stop-daemon

If I understand correctly the problem you have, it is not related at all
with Xenomai. What you want is to make your application a real daemon.
The easy way to do this is to call the glibc function named "daemon" the
hard way is to call fork twice, call setsid and setpgrp.
start-stop-daemon will not do the trick.

--=20
                                                 Gilles Chanteperdrix

