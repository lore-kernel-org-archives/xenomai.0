From: "Ramakrishnan, Senthil" <senthil.ramakrishnan@hp.com>
Date: Wed, 23 Nov 2016 17:13:59 +0000
Message-ID: <DF4PR84MB0299ABE95D22EE2DF3E6F028F7B70@DF4PR84MB0299.NAMPRD84.PROD.OUTLOOK.COM>
References: <DF4PR84MB0299F84DFCDC76FD7D360B12F7B10@DF4PR84MB0299.NAMPRD84.PROD.OUTLOOK.COM>
 <a22149dd-141c-f148-113e-318f542095ae@xenomai.org>
In-Reply-To: <a22149dd-141c-f148-113e-318f542095ae@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Help needed regarding compiling/installing Xenomai
 patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Philippe,

Thanks much for the response and you answered all our questions. One more q=
uestion I have is if there is a Standalone RTDM patch available. Or, if it'=
s possible to apply RTDM changes alone from the Xenomai-Cobalt kernel patch=
.

Thanks and Regards,
Senthil

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org]=20
Sent: Tuesday, November 22, 2016 9:31 AM
To: Ramakrishnan, Senthil <senthil.ramakrishnan@hp.com>; xenomai@xenomai.or=
g
Subject: Re: [Xenomai] Help needed regarding compiling/installing Xenomai p=
atch

On 11/17/2016 08:14 PM, Ramakrishnan, Senthil wrote:
> Dear All,
>=20
> My name is Senthil Ramakrishnan and I work for Hewlett Packard Inc, Boise=
, Idaho.
>=20
> We are currently in the process of doing a feasibility study on enabling =
Xenomai on our ARM platform. We are using the patch "xenomai-3-3.0.3" which=
 I think is latest.
> The CPU we are targeting is AArch64 architecture(64-bit ARM). Based on th=
at I'm trying to build the "Mercury" core using the below command line.
>=20
> configure CFLAGS=3D"-march=3Darmv8-a" LDFLAGS=3D"-march=3Darmv8-a"=20
> --build=3D"i686-pc-linux-gnu" --host=3D"aarch64-linux-gnu" =20
> --with-core=3Dmercury  --enable-smp
>=20
> But I run into below error during the validation of toolchain when runnin=
g configure.
>=20
> checking for target architecture...
> *******************************************
> Still unsupported target: aarch64-linux-gnu -- Sorry.
> *******************************************
> My question is if "aarch64" is supported and if this error is expected. I=
f it's not supported it would be great if you can let us know if there are =
plans to enable 64-bit ARM(AArch64) and when it might be available.


Only the Cobalt core is actually requiring arch-specific support, Mercury c=
an run on whatever arch the host kernel runs. The fact that configuring for=
 Mercury is checking for arch-specific support is wrong.
Thanks for reporting this.

>=20
> As a hack, I currently modified Xenomai "configure" script to get around =
this error and I'm able to compile the Xenomai Mercury core for Arm64/AArch=
64 using Linaro AArch64 Gcc toolchain. Do you see any issues with this?

No.

>=20
> Other question I have is if RTDM User APIs are available under Mercury co=
re? I don't see User space RTDM library when compiling Mercury core, so I t=
hink it's not supported, but it would be great if you can confirm that or i=
f there are future plans to support this.

Since your application runs over a single kernel configuration, you can jus=
t use the regular POSIX interface from the glibc to interface with native L=
inux drivers, you don't need RTDM unless you want to create drivers which y=
ou could build and run over a single or dual kernel configuration seamlessl=
y. But Mercury is lacking an implementation of RTDM services in kernel spac=
e, so this would not be useful at the moment anyway.

In general, there is no such RTDM user API in 3.x. One should use the regul=
ar POSIX I/O or socket interfaces. The older rt_dev API from 2.x is obsolet=
e, and only provided as wrappers over the POSIX calls (see include/trank/rt=
dm).

> We would also like to know how/where we can find the info on kernel versi=
on against each Xenomai/I-pipe patch versions are tested.
>=20

There is no document gathering such information; you may assume that any ke=
rnel release for which a patch is available in kernel/cobalt/arch/*/patches=
 directories has been tested for the given architecture though.

Please note that the I-pipe is only required in dual kernel mode with Cobal=
t, you don't need that for a Mercury set up.

--
Philippe.

