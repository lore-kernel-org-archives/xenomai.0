Date: Mon, 6 Oct 2014 00:27:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141005222751.GM14975@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] AVX/SSE2 routines
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

Hi Jan,

I noticed two problems with the fp_regs_set routine. First, in
kernel-space, it does not set all the values of the "vec" array,
it only sets the first one, before running the series of vmovupd
instructions. I believe this issue can be avoided with the following
patch:

diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/fptest.h b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/fptest.h
index d6a9a68..d406cc3 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/fptest.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/fptest.h
@@ -39,7 +39,7 @@ static inline void fp_regs_set(int features, unsigned int val)
			"vmovupd %0,%%ymm5;"
			"vmovupd %0,%%ymm6;"
			"vmovupd %0,%%ymm7;"
-			: : "m" (vec[0]));
+			: : "m"(vec[0]), "m"(vec[1]), "m"(vec[2]), "m"(vec[3]));
	} else if (features & __COBALT_HAVE_SSE2) {
		__asm__ __volatile__(
			"movupd %0,%%xmm0;"
@@ -50,7 +50,7 @@ static inline void fp_regs_set(int features, unsigned int val)
			"movupd %0,%%xmm5;"
			"movupd %0,%%xmm6;"
			"movupd %0,%%xmm7;"
-			: : "m" (vec[0]));
+			: : "m"(vec[0]), "m"(vec[1]), "m"(vec[2]), "m"(vec[3]));
	}
 }

The other issue is that in user-space, when compiling with -Os, the
following code is generated for fp_regs_set:

0000000000000000 <fp_regs_set>:
       0:       89 74 24 dc             mov    %esi,-0x24(%rsp)
       4:       89 f6                   mov    %esi,%esi
       6:       48 c7 44 24 e8 00 00    movq   $0x0,-0x18(%rsp)
       d:       00 00
       f:       48 89 74 24 e0          mov    %rsi,-0x20(%rsp)
      14:       48 89 74 24 f0          mov    %rsi,-0x10(%rsp)
      19:       48 c7 44 24 f8 00 00    movq   $0x0,-0x8(%rsp)
      20:       00 00
      22:       db 44 24 dc             fildl  -0x24(%rsp)
      26:       db 44 24 dc             fildl  -0x24(%rsp)
      2a:       db 44 24 dc             fildl  -0x24(%rsp)
      2e:       db 44 24 dc             fildl  -0x24(%rsp)
      32:       db 44 24 dc             fildl  -0x24(%rsp)
      36:       db 44 24 dc             fildl  -0x24(%rsp)
      3a:       db 44 24 dc             fildl  -0x24(%rsp)
      3e:       db 44 24 dc             fildl  -0x24(%rsp)
      42:       40 f6 c7 02             test   $0x2,%dil
      46:       74 31                   je     79 <fp_regs_set+0x79>
      48:       c5 fd 10 44 24 e0       vmovupd -0x20(%rsp),%ymm0
      4e:       c5 fd 10 4c 24 e0       vmovupd -0x20(%rsp),%ymm1
      54:       c5 fd 10 54 24 e0       vmovupd -0x20(%rsp),%ymm2
      5a:       c5 fd 10 5c 24 e0       vmovupd -0x20(%rsp),%ymm3
      60:       c5 fd 10 64 24 e0       vmovupd -0x20(%rsp),%ymm4
      66:       c5 fd 10 6c 24 e0       vmovupd -0x20(%rsp),%ymm5
      6c:       c5 fd 10 74 24 e0       vmovupd -0x20(%rsp),%ymm6
      72:       c5 fd 10 7c 24 e0       vmovupd -0x20(%rsp),%ymm7
      78:       c3                      retq
      79:       40 80 e7 01             and    $0x1,%dil
      7d:       74 30                   je     af <fp_regs_set+0xaf>
      7f:       66 0f 10 44 24 e0       movupd -0x20(%rsp),%xmm0
      85:       66 0f 10 4c 24 e0       movupd -0x20(%rsp),%xmm1
      8b:       66 0f 10 54 24 e0       movupd -0x20(%rsp),%xmm2
      91:       66 0f 10 5c 24 e0       movupd -0x20(%rsp),%xmm3
      97:       66 0f 10 64 24 e0       movupd -0x20(%rsp),%xmm4
      9d:       66 0f 10 6c 24 e0       movupd -0x20(%rsp),%xmm5
      a3:       66 0f 10 74 24 e0       movupd -0x20(%rsp),%xmm6
      a9:       66 0f 10 7c 24 e0       movupd -0x20(%rsp),%xmm7
      af:       c3                      retq

Unless I missed some details, a negative offset of the rsp does not
make sense. I have not found a workaround for this issue (other than
not using the -Os option), however I believe, somehow, something is
missing to the assembly to tell gcc that it should allocate this
space on stack, because we are using it.

Any ideas?

Regards.

--
					    Gilles.

