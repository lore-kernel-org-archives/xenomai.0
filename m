From: BREGARDIS Cedric <cedric.bregardis@transport.alstom.com>
Date: Wed, 31 Aug 2016 16:44:07 +0000
Message-ID: <b3a6f4c97449444a9f315329b4b7faf1@AM3PR48MB0130.041d.mgd.msft.net>
Content-Language: fr-FR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] [ARM64] Context saving problem with floating point
	registers?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I am trying to port Xenomai 3 on a SoC based on ARM64 and I have
encountered a problem when running clocktest (provided with
xenomai). It seems that floating point registers are not always
correctly restored after a linux syscall. I have created a small
program (inspired by clocktest.c) which reproduces the problem
with qemu and vanilla ipipe/xenomai.

Here is the software which produces the problem:

#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <boilerplate/atomic.h>

int main(void)
{
struct sched_param param =3D { .sched_priority =3D 1 };
int i;
float a;
struct timeval tv;

pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);

for (i =3D 1; i < 20; i++)
{
a =3D i + 0.1;
printf("%d %f\n", i, a);
syscall(SYS_gettimeofday, &tv, NULL);
}

return 0;
}

The output is:
1 1.100000
2 2.000000
3 3.000000
[...]

Instead of:
1 1.100000
2 2.100000
3 3.100000
[...]

However, if the line pthread_setschedparam or syscall is removed, all
is working fine.

I am using the following ipipe and xenomai versions:
- ipipe: git://git.xenomai.org/ipipe.git (branch ipipe-4.1.y)
- xenomai: git://git.xenomai.org/xenomai-3.git  (branch next)

The linux kernel is compiled with the defconfig of arm64 and
ipipe/xenomai activated.

Xenomai libraries are compiled with the following options:
./configure CFLAGS=3D-march=3Darmv8-a+fp --enable-smp --with-core=3Dcobalt
--enable-debug --disable-doc-install --host=3Daarch64-linux-gnu
--build=3Dx86_64

The test software is compiled such as indicated here:
https://xenomai.org//building-applications-with-xenomai-3-x/
With the following options:
CFLAGS :=3D $(shell $(XENO_CONFIG) --posix --cflags) -O2 -Wall
LDFLAGS :=3D $(shell $(XENO_CONFIG) --posix --ldflags)

(-O2 is needed in order to not load the value 0.1 in a floating point
register at each iteration which would hide the problem)

I am launching qemu with the following command line:

qemu-system-aarch64 -machine virt -cpu cortex-a53 -smp 4 -nographic
-kernel ../linux-sim-build/arch/arm64/boot/Image
-drive if=3Dnone,file=3Drootfs.img,id=3Dhd0 -device
virtio-blk-device,drive=3Dhd0 -append "root=3D/dev/vda"

Do you see any problem in my configuration, or is it a bug? Please, do
not hesitate to ask me more information if needed. I am trying to
understand the problem, but with no success for now.

Best regards,
Cedric.

________________________________
CONFIDENTIALITY : This e-mail and any attachments are confidential and may =
be privileged. If you are not a named recipient, please notify the sender i=
mmediately and do not disclose the contents to another person, use it for a=
ny purpose or store or copy the information in any medium.

