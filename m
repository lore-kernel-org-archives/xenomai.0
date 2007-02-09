Message-ID: <45CC8A19.6080109@domain.hid>
Date: Fri, 09 Feb 2007 14:50:01 +0000
From: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] system() question
References: <45C9F9CD.6000101@domain.hid>	<45C9F2F9.3020204@domain.hid>	<45CAE1C2.5040207@domain.hid>
	<17866.56537.695811.3523@domain.hid>
In-Reply-To: <17866.56537.695811.3523@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

I tried it, but did not help, I manged to do the trick using=20
start-stop-daemon

Gilles Chanteperdrix wrote:
> St=E9phane ANCELOT wrote:
>  > my linux user task uses a system() call in order to call a bash script=
=20
>  > to restart the realtime task as follow :
>  >=20
>  > user interface C call :
>  > system("restart_task.sh");
>  > give back hand to user interface
>  > ....
>  >=20
>  >=20
>  >=20
>  >=20
>  > bash script restart_task.sh :
>  > killall -15 mytask
>  > sleep 2
>  > mytask &
>  >=20
>  >=20
>  > system call dies because sh script has been launched
>=20
> Try calling daemon(0,0) in mytask instead of using "&" to make it run in
> the background.
>=20


