Message-ID: <4D1FB03E.10801@domain.hid>
Date: Sat, 01 Jan 2011 23:52:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinON5_8sj8o6NYBJ1ukyB41eRSP-tQa4kxG_qPm@domain.hid>
In-Reply-To: <AANLkTinON5_8sj8o6NYBJ1ukyB41eRSP-tQa4kxG_qPm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] I-pipe support to 2.6.35.7-x86-2.8-00
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gianni Perugini <gperugini@domain.hid>
Cc: xenomai@xenomai.org

Gianni Perugini wrote:
> Hello to everyone,
>=20
> I=E2=80=99ve seen on the Adeos website that there is a new patch for li=
nux
> 2.6.35.7 x86 arch: adeos-ipipe-2.6.35.7-x86-2.8-00.patch.
> Does anyone knows where I can find documentation explaining the
> differences between adeos-ipipe-2.6.35.7-x86-2.7-04.patch and the
> above patch?

This information may be found in the git logs:
http://git.denx.de/?p=3Dipipe-2.6.git;a=3Dshortlog;h=3D50001867b31b51e9ee=
f0ecb5207dc273d0097c79


> Is it safe to use the new patch with xenomai 2.5.5.2?

As explained in ksrc/arch/x86/patches/README in Xenomai sources, and
repeated many times on this list, yes, it should be safe.

--=20
                                                                Gilles.


