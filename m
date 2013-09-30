Message-ID: <524924CE.2050907@web.de>
Date: Mon, 30 Sep 2013 09:14:22 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <E1VPeW6-00026B-Hu@xenomai.org> <5246931B.3060503@xenomai.org>
	<52469507.3070101@xenomai.org> <5246A6D3.7070502@xenomai.org>
	<5246B982.6030209@xenomai.org> <5247041A.8090102@xenomai.org>
	<5247FD02.3050605@web.de> <52483F85.10508@xenomai.org>
	<52484951.5050508@web.de> <52484B0D.3040309@xenomai.org>
	<52484B4C.8050004@web.de> <52484EB0.6020807@xenomai.org>
	<524850DA.7050407@web.de> <52485AD7.5020203@xenomai.org>
In-Reply-To: <52485AD7.5020203@xenomai.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [Xenomai-git] Gilles Chanteperdrix : hal/x86: fix smi
	message
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 2013-09-29 18:52, Philippe Gerum wrote:
> Merging your proposal and mine, this would give the change below. I
> don't have any preference between "xeno", "xenomai", whatever fits.
> However, we should keep something in the name that clearly gives a hint
> about the machine/arch-dependent nature of the parameter (i.e.
> not merging those bits to xenomai-y).
> =

> e.g.
> =

> diff --git a/kernel/cobalt/arch/arm/Makefile
> b/kernel/cobalt/arch/arm/Makefile
> index 25d33a5..d62976c 100644
> --- a/kernel/cobalt/arch/arm/Makefile
> +++ b/kernel/cobalt/arch/arm/Makefile
> @@ -1,5 +1,5 @@
> -obj-$(CONFIG_XENOMAI) +=3D arm_hal.o
> +obj-$(CONFIG_XENOMAI) +=3D xeno_machine.o
> =

> -arm_hal-y :=3D machine.o mayday.o thread.o switch.o syscall.o
> +xeno_machine-y :=3D machine.o mayday.o thread.o switch.o syscall.o
> =

>  ccflags-y :=3D -Iarch/arm/xenomai/include -Iinclude/xenomai
> =


Looks good to me.

Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130930/c8dd21e=
6/attachment.pgp>
