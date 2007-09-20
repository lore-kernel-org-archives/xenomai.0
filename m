Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Sep 2007 08:16:56 +0200
Message-ID: <899865CA54E4444DAF2E3639C04C5F4805ED13@domain.hid>
From: "Richard Cochran" <richard.cochran@domain.hid>
Subject: [Xenomai-core] [RFC] Fast Context Switch Extension for ARM Linux
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

I know that this is a bit off topic, yet perhaps some on this list
have interest or knowledge in this area. I am also posting this idea
to the linux-arm-kernel list.

I would like to implement the ARM FCSE under Linux, using the Intel
IXP425 board. Before I start, I would like to ask:

1. Has any work already been done in this area?

2. Is there something about the current Linux MM that would make this
   impractical?

3. Does anyone else have interest in this?

I had once proposed this task as a student project, and so I append
the long project description, below.

Thanks,
Richard

ARM Fast Context Switch Extension for Linux

Motivation

 The ARM v5 CPUs are inexpensive, low power, 32 bit processors widely
 used in embedded systems. However, because of these processors' cache
 implementation, using memory protection on these systems may incur a
 performance penalty that is too great for real time applications. The
 aim of this study is to achieve both memory protection and good cache
 performance under the Linux 2.6 operating system, by implementing
 the Fast Context Switch Extension (FCSE).

Task

 ARM v5 processors access the cache by virtual addresses. As a result,
 the cache is invalidated after a context switch, since no two
 processes share the same address space. Reloading the cache from main
 memory is a very expensive operation.

 One approach to address this problem, used for example in vxWorks or
 uClinux, is to use one "flat" address space, shared by the operating
 system kernel and all user processes. This avoids the context switch
 penalty while sacrificing memory protection. The obvious drawback
 under this scenario is that any one misbehaving program can corrupt
 the kernel or other programs.

 Another solution, not yet implemented under Linux, is to use the
 "Process ID" register found on some ARM CPUs, for example the Intel
 IXP425. This register contains a 7 bit process identifier that can be
 combined with a 25 bit virtual address. Using this method allows 128
 distinct 32 MB address spaces, so that up to 128 processes may safely
 co-exist, without paying the context switch penalty. The resulting
 limitation of 128 processes and 32 MB address space is acceptable for
 many embedded systems.

 The tasks of this study would be:

 1. Research and summarize the existing work in this area.

 2. Benchmark the current implementations to demonstrate the problem,
    using "standard" Linux, Xenomai, and the PREEMPT_RT patch set.

 3. Illuminate the Linux memory management subsystem.

 4. Implement FCSE in the Linux memory management subsystem.

 5. Benchmark the result of the improved kernel.

Selected references:

o A short summary of the issue and the approach used by QNX:
  http://www.qnx.com/developers/docs/6.3.0/neutrino/prog/arm_memory.html

o Context Switching and IPC Performance Comparison between uClinux and
  Linux on the ARM9 based Processor
  http://opensrc.sec.samsung.com/document/uc-linux-04_sait.pdf

o Fast Address-Space Switching for ARM Linux Kernels
  http://www.ertos.nicta.com.au/software/fass/

o Context Switch Overheads for Linux on ARM Platforms
  http://choices.cs.uiuc.edu/contextswitching.pdf

