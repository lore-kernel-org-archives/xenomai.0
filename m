Message-ID: <790091D8B6A84455A1DA8F3E5353087C@itd206>
From: "Sureshvs" <sureshvs@datapatterns.co.in>
Date: Tue, 23 Jun 2015 20:25:47 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Reg: Linux 3.8.13 64bit xenomai-2.6.4 compilation problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: "karunakaran.krishnan" <karunakaran.krishnan@industeqsite.com>

Hi,

I am using freescale T2080 PowerPC based processor board. we are patched =
the linux kernel 3.8.13 with xenomai 2.6.4.
After patched, The following kernel configuration are selected before =
compiling.

1) 64 bit Kernel.
2) Processor Type --> Embedded Processor
3) CPU Selection --> POWER7
4) Symmetric Multiprocessing support
5) Max No of CPU 8
6) Disabled the CPU Frequency Scaling

compiling the above configuration with fsl-64 bit freescale cross =
compiler. It gives the following error.

  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CC      arch/powerpc/kernel/asm-offsets.s
In file included from include/linux/ipipe_debug.h:25:0,
                 from include/linux/ipipe.h:31,
                 from include/linux/sched.h:25,
                 from arch/powerpc/kernel/asm-offsets.c:17:
include/linux/ipipe_domain.h: In function 'ipipe_current_context':
include/linux/ipipe_domain.h:252:2: error: implicit declaration of =
function '__mtmsrd' [-Werror=3Dimplicit-function-declaration]
cc1: some warnings being treated as errors
make[1]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2

Kindly suggest us to resolve this issue.RegardsSuresh=20
