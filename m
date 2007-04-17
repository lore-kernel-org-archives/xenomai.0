From: Stelian Pop <stelian@domain.hid>
In-Reply-To: <17955.64120.90606.670609@domain.hid>
References: <1176585372.15994.14.camel@domain.hid>
	<17955.64120.90606.670609@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 17 Apr 2007 10:01:40 +0200
Message-Id: <1176796900.4485.2.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PATCH] Support EABI enabled kernels on ARM
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
Cc: xenomai@xenomai.org

Le mardi 17 avril 2007 =E0 00:36 +0200, Gilles Chanteperdrix a =E9crit :
> Stelian Pop wrote:
>  > Hi,
>  >=20
>  > The attached patch adds an option to make Xenomai userspace issue EA=
BI
>  > syscalls. This is needed to make Xenomai work with kernels compiled =
with
>  > CONFIG_EABI.
>  >
> Applied, thanks.

Thanks.

>  And by the way, I am running Debian Etch, and its
> version of autotools seems to complain that we do not use datarootdir i=
n
> xeno-config.in...=20

Hmm, things are going well on an Ubuntu Egdy here, but I suppose the
next Ubuntu version (7.04 or Feisty Fawn, due in 3 days) will have
almost the same package versions as Debian Etch...

--=20
Stelian Pop <stelian@domain.hid>


