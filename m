Date: Tue, 5 Jan 2016 21:34:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160105203427.GA26963@hermes.click-hack.org>
References: <CACzbJrLu9YxAme9JdY-SzTeLQKrAiyk15b_bQCbufpsri4yNyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CACzbJrLu9YxAme9JdY-SzTeLQKrAiyk15b_bQCbufpsri4yNyA@mail.gmail.com>
Subject: Re: [Xenomai] Problem compiling kernel with Cobalt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Denis Matteazzi <d.matteazzi@gmail.com>
Cc: xenomai@xenomai.org

On Tue, Jan 05, 2016 at 09:22:32PM +0100, Denis Matteazzi wrote:
> Hi to all.
> I am new in Xenomai and RT in general. I have some problems in compiling
> kernel with
> patches for Xenoami and I-Pipe.
>=20
> Host computer:
> I'm trying on a notebook with an x86 32bit CPU.
> The Linux Release is Ubuntu Trusty (14.04.3 LTS).
> The Kernel version is 4.1.15.
> I'm trying to use Xenomai 3.0.1.
> I have downloaded ipipe-core-4.1-x86-1.patch.
>=20
> I have downloaded version 4.1 of the Kernel source from kernel.org
> I have executed the command script/prepare-kernel.sh
> --linux=3D<path_of_the_kernel_source>
>     --ipipe=3D<complete_path_of_ipipe_patch> --arch=3Dx86
> After that I have run
>    make menuconfig
> and removed CPU scaling and IDLE feature, ACPI, APM and KGDB options.
> Then I have run
> make-kpkg --rootcmd fakeroot --initrd kernel_image kernel_headers
> modules_image
>=20
> These are the error that compare:
>=20
> In file included from kernel/xenomai/bufd.c:20:0:
> include/xenomai/cobalt/kernel/sched.h: In function =91xnsched_set_resched=
=92:
> include/xenomai/cobalt/kernel/sched.h:224:3: error: implicit declaration =
of
> function =91cpu_set=92 [-Werror=3Dimplicit-function-declaration]
>    cpu_set(xnsched_cpu(sched), current_sched->resched);
>    ^
> include/xenomai/cobalt/kernel/sched.h: In function =91xnsched_supported_c=
pu=92:
> include/xenomai/cobalt/kernel/sched.h:234:2: error: implicit declaration =
of
> function =91cpu_isset=92 [-Werror=3Dimplicit-function-declaration]
>   return cpu_isset(cpu, xnsched_realtime_cpus);
>   ^
> cc1: some warnings being treated as errors
>=20
> Any Idea?

Yes, this is starting to become an FAQ actually.

A release of Xenomai generally only supports kernel versions up to
the latest version for which it contains an I-pipe patch. The latest
I-pipe patch Xenomai contains is for Linux 3.18, so Xenomai 3.0.1
only supports kernels up to 3.18. It supports later patches for the
3.18 stable releases, but not patches for later kernels such as
Linux 4.1.

Note that if you want a quick test of Xenomai 3.0 on Linux 4.1.15 on
x86 64 bits, you may try the experimental live CD iso here:
http://xenomai.org/~gch/xeno-live.iso

This iso image imitates Debian installation isos: it can be burned
onto a CD, or copied (with dd) to an USB key. It supports booting on
systems with EFI too. The rootfs is entirely in RAM, so it requires
something like 250 MB of RAM for the rootfs.

I will try to release such an iso image with every future release of
Xenomai.

--=20
					    Gilles.
https://click-hack.org

