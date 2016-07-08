Date: Fri, 8 Jul 2016 13:03:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160708110314.GP9465@hermes.click-hack.org>
References: <1569300380.1342469.1467973783459.JavaMail.yahoo.ref@mail.yahoo.com>
 <1569300380.1342469.1467973783459.JavaMail.yahoo@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1569300380.1342469.1467973783459.JavaMail.yahoo@mail.yahoo.com>
Subject: Re: [Xenomai] unable to patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: praneeth.y@yahoo.com
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Jul 08, 2016 at 10:29:43AM +0000, praneeth.y@yahoo.com wrote:
> Hi,=20
> Having failed to patch the kernel for arm,I tried with Linux kernel 3.0.4=
3,3.14,3.18 4.20 with xenomai 2.6.4's adeos ipipe as well as ipipe-core. Un=
fortunately most of them ended with the following last
> messages.=A0unable to patch the kernel 3.0.43 with adeos -ipipe-3.0.43=A0=
=20

I guess you do not get a message about kernel 3.0.43 when trying to
apply a patch on 3.14. Anyway, this message means that you are
trying to apply a patch to a kernel which is not the kernel it was
made for.=20

Basically, this is explained in the file ksrc/arch/arm/patches/README
in the source tree:

- the patches directly in this directory apply to mainline kernels,
the ones from kernel.org, with the exact same version as the version
in the I-pipe patch name (so for instance,
ipipe-core-3.14.17-arm-4.patch applies to the vanilla kernel
3.14.17, probably not to 3.14.0 or 3.14.73)

- for the case of patches to the mainline kernel you are encouraged to
use more recent versions from https://xenomai.org//downloads/ipipe
area, but only for versions of the kernel supported by Xenomai, so
for instance  ipipe-core-3.14.44-arm-17.patch is a better choice
than ipipe-core-3.14.17-arm-4.patch (which ships with Xenomai
2.6.4), but you can not use ipipe-core-3.18.20-arm-10.patch or=20
ipipe-core-4.1.18-arm-5.patch, because Xenomai does not support
Linux versions after Linux 3.14. But any version in the stable
branch (3.14.44 for instance) should be OK.

- the patches in the sub-directories (beaglebone, mxc, raspberry,
zynq) apply to specific vendor forks, which exactly should be
documented in the README file. Sometimes they are pre or post
patches meaning that you have to apply them before or after a patch
for a mainline kernel, the details are given in the README file.

--=20
					    Gilles.
https://click-hack.org

