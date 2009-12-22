Message-ID: <4B30E2EE.6000308@domain.hid>
Date: Tue, 22 Dec 2009 16:17:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <17562953.1358371261493595174.JavaMail.coremail@domain.hid>
In-Reply-To: <17562953.1358371261493595174.JavaMail.coremail@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xeno-test can not run
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: robert165 <robert165@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

robert165 wrote:
> Hi all=EF=BC=8C
> I installed xenomai-2.4.4 on AT91RM9200DK, all have done OK. But the
> board halted when running xeno-test.
> would anyone help me, thanks a lot.
> Besides, which version of xenomai is a good choice for real application=

> with arm?

Any version is as good as we can make it, but if you want to be able to
report a bug, and not to stumble upon bugs which have been fixed, you
should be using the latest versoin.

There is also the recent discovery of a very old bug of basically all
the I-pipe patches on arm, so, you should be using Xenomai 2.4.10 and
the patches it provides. Add to that the integration of the FCSE patch
into the I-pipe patch which will give you much better real-time
performances.

> I used linux-2.6.20.21 + 2.6.20-at91.patch +
> adeos-ipipe-2.6.20-arm-1.8-03.patch + xenomai-2.4.4
> The run info is as follows, and the full log is attached.
> =20
> Thu Jan  1 00:07:57 UTC 1998
> running: top
> [H[JMem: 5692K used, 24184K free, 0K shrd, 0K buff, 1884K cached
> Load average: 0.71, 0.17, 0.06    (State: S=3Dsleeping R=3Drunning, W=3D=
waiting)
> [7m  PID USER     STATUS   RSS  PPID %CPU %MEM COMMAND[0m
>  1025 0        R        376     1 98.0  1.2 dd
>  1212 0        R        676  1211  2.9  2.2 top
>   738 0        S        760     1  0.0  2.5 sh
>   743 0        S        612   738  0.0  2.0 xeno-test
>     1 0        S        568     0  0.0  1.9 init
>   798 0        S        472   743  0.0  1.5 xeno-test
> Thu Jan  1 00:07:58 UTC 1998
> running: ./run -- -sh -T 120 -t0 # latency
> *
> *
> * Type ^C to stop this application.
> *
> *

That is a bug which has been around for too long due to my lazyness, but
which Philippe has finally fixed in 2.4.10. The default period of the
latency test is 100us, which is too short for an ARM. Run latency with
-p 1000 to ask for a 1ms period.

--=20
					    Gilles.


