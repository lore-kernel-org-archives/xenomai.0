Message-ID: <4DECF994.2030604@domain.hid>
Date: Mon, 06 Jun 2011 18:00:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTi=gonDhctX-5w=L1f_rQP-JVNSDYQ@mail.gmail.com>
In-Reply-To: <BANLkTi=gonDhctX-5w=L1f_rQP-JVNSDYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] pandaboard -deconfig
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: suresh reddy <sureshreddy.balijepalli@domain.hid>
Cc: xenomai@xenomai.org

On 06/06/2011 05:46 PM, suresh reddy wrote:
> Dear Xenomai Team,
>=20
> $xenomai_root/scripts/prepare-kernel.sh --arch=3Darm \
>   --adeos=3D$xenomai_root/ksrc/arch/arm/patches/adeos-ipipe-2.6.20-arm-=
* \
>   --linux=3D$linux_tree$ cd $linux_tree
> $ make ARCH=3Darm CROSS_COMPILE=3Darm-linux- O=3D$build_root csb637_def=
config
>=20
>=20
> I  have doubts in above highlighted issues .
>=20
> 1. CD $linux_tree
>=20
> i have taken snapshot of ipipe-gch from xenomai git repository. (It is
> patched kernel)
>=20
> *On my host pc (intel )*
>=20
> i changed to  CD =C2=A7 ipipe-gch   (since this is the ipipe patched li=
nux kernel
> tree). Is this the correct way ?

$linux_tree is the value of a shell variable, used as a place holder,
which you can replace with whatever you want.

>=20
>=20
> 2. if i make menu config im entering into host pc (i mean i386
> configuration) but not the arm . how can i configure for pandaboard .

This is a question about cross-compiling linux. As such, it has nothing
to do with Xenomai and is off-topic on this mailing list. There are many
places on the web where you can find documentation on compiling the
Linux kernel. As I already advised you privately, you will find this
documentation, for instance, on the panda board wiki.

--=20
					    Gilles.


