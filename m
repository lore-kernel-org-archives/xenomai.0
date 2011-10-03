MIME-Version: 1.0
In-Reply-To: <20111003103914.8A2B636C@centrum.cz>
References: <20110926090226.9C75AD68@domain.hid>
	<20111003103914.8A2B636C@centrum.cz>
Date: Mon, 3 Oct 2011 10:47:22 +0200
Message-ID: <CAPASGLohhztGb0h97QAReSS1z3p++iPOEhNfEGXew3A9P5VmZw@domain.hid>
From: Eric Noulard <eric.noulard@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Frequency downscaling of new intel CPU
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

2011/10/3 Petr Cervenka <grugh@domain.hid>:
>
> Hello again.
> I know, that my problem is not so close related with the xenomai. But I t=
hink many of xenomai users with new intel CPUs have similar problem.
> I tried it it with two different main boards and none of the BIOS setting=
s helped. (C-states: disabled, Speedstep: disabled, CPU idle: high performa=
nce, TurboBoost: disabled, ...). My theory is that the linux kernel overrid=
es BIOS settings, but I don't know how to prove it.
> Any ideas that could help me?

Did you verify that you don't have any cpufred related module loaded?

What does

$ lsmod | grep cpu

indicate?

You can try that one too:

$ find /sys/devices/system -name "cpufreq"


--=20
Erk
Membre de l'April - =AB promouvoir et d=E9fendre le logiciel libre =BB -
http://www.april.org

