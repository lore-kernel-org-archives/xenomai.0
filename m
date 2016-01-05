MIME-Version: 1.0
Date: Tue, 5 Jan 2016 21:22:32 +0100
Message-ID: <CACzbJrLu9YxAme9JdY-SzTeLQKrAiyk15b_bQCbufpsri4yNyA@mail.gmail.com>
From: Denis Matteazzi <d.matteazzi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Problem compiling kernel with Cobalt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi to all.
I am new in Xenomai and RT in general. I have some problems in compiling
kernel with
patches for Xenoami and I-Pipe.

Host computer:
I'm trying on a notebook with an x86 32bit CPU.
The Linux Release is Ubuntu Trusty (14.04.3 LTS).
The Kernel version is 4.1.15.
I'm trying to use Xenomai 3.0.1.
I have downloaded ipipe-core-4.1-x86-1.patch.

I have downloaded version 4.1 of the Kernel source from kernel.org
I have executed the command script/prepare-kernel.sh
--linux=3D<path_of_the_kernel_source>
    --ipipe=3D<complete_path_of_ipipe_patch> --arch=3Dx86
After that I have run
   make menuconfig
and removed CPU scaling and IDLE feature, ACPI, APM and KGDB options.
Then I have run
make-kpkg --rootcmd fakeroot --initrd kernel_image kernel_headers
modules_image

These are the error that compare:

In file included from kernel/xenomai/bufd.c:20:0:
include/xenomai/cobalt/kernel/sched.h: In function =E2=80=98xnsched_set_res=
ched=E2=80=99:
include/xenomai/cobalt/kernel/sched.h:224:3: error: implicit declaration of
function =E2=80=98cpu_set=E2=80=99 [-Werror=3Dimplicit-function-declaration=
]
   cpu_set(xnsched_cpu(sched), current_sched->resched);
   ^
include/xenomai/cobalt/kernel/sched.h: In function =E2=80=98xnsched_support=
ed_cpu=E2=80=99:
include/xenomai/cobalt/kernel/sched.h:234:2: error: implicit declaration of
function =E2=80=98cpu_isset=E2=80=99 [-Werror=3Dimplicit-function-declarati=
on]
  return cpu_isset(cpu, xnsched_realtime_cpus);
  ^
cc1: some warnings being treated as errors

Any Idea?
Thanks.
Denis.
