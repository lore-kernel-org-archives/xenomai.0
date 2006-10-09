Subject: Re: [Adeos-main] BUG: adeos-ipipe-2.6.15-arm-1.5-00.patch on
	2.6.15.7 -- syscalls
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1160383954.5015.17.camel@domain.hid>
References: <1160383954.5015.17.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 09 Oct 2006 12:15:13 +0200
Message-Id: <1160388914.5087.17.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: "=?ISO-8859-1?Q?Schl=E4gl?= Manfred jun." <manfred.schlaegl@domain.hid>
Cc: adeos-main@gna.org


Hi,

On Mon, 2006-10-09 at 10:52 +0200, Schl=E4gl Manfred jun. wrote:
> Hi!
>=20
> I'm trying to get running Adeos/Xenomai on a Netsilicon 9360
> (ARM926EJ-Sid(wb) rev 4 (v5l))-Board with linux-2.6.15.7 and found
> following bug in ipipe.root (__ipipe_syscall_root)
>=20

Indeed, I messed this up. You are likely running 1.5-00. A similar fix
was applied for 1.5-01, IIRC:
http://download.gna.org/adeos/patches/v2.6/arm/adeos-ipipe-2.6.15-arm-1.5=
-01.patch

Thanks,

--=20
Philippe.



