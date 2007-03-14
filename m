Message-ID: <45F88C71.2070804@domain.hid>
Date: Thu, 15 Mar 2007 01:59:45 +0200
From: Maksym Veremeyenko <verem@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] mem usage and other application
References: <45F86426.9000309@domain.hid>	<17912.26777.313494.393466@domain.hid>	<45F87970.5060506@domain.hid>	<17912.31765.786905.929691@domain.hid>	<45F87F03.9090202@domain.hid>	<17912.32723.685853.878873@domain.hid>	<45F884EC.3060006@domain.hid>
	<17912.34386.408353.651285@domain.hid>
In-Reply-To: <17912.34386.408353.651285@domain.hid>
Content-Type: text/plain; charset=KOI8-U; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-help@domain.hid

Gilles Chanteperdrix =D0=C9=DB=C5=D4:

>  > My problem with non-RT application happens only if RT application=20
>  > (running in the same time) uses native skin. Perl and Eclipse=20
>  > application fails when switchbench is running, but not problems duri=
ng=20
>  > switchtest.
>=20
> Ok. If you can run switchtest at the same time as your application and
> switchtest does not fail, it does not look like an FPU bug. What is
> the error message when perl or eclipse fail to start ?
>=20

Perl scripts fails with various compilation errors - approximately 6=20
types (seems it could be much more if more modules were used).

Eclipse fails with Java VM init error:
[verem@domain.hid ~]$ /usr/local//eclipse/eclipse
Error occurred during initialization of VM
java.lang.IllegalArgumentException: Illegal Load: NaN

During runned 'latency' i even have ssh fail:
Mar 15 01:47:18 dev-3 sshd[2908]: fatal: Couldn't obtain random bytes=20
(error 604389476)
Mar 15 01:52:11 dev-3 sshd[3006]: Received signal 15; terminating.



--=20
________________________________________
Maksym Veremeyenko


