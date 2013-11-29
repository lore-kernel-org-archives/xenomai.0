Date: Fri, 29 Nov 2013 08:59:14 +0100
From: Bukuli Norbert <norbert.bukuli@mediso.hu>
Message-ID: <20131129085914.4b3c225e.norbert.bukuli@mediso.hu>
In-Reply-To: <5297A7E0.9030207@xenomai.org>
References: <20131128143152.04ac3eab.norbert.bukuli@mediso.hu>
 <5297A4E3.50807@xenomai.org> <5297A7E0.9030207@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] test suite programs crash with Illegal instruction on
 MPC5200
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

I have turned off the Xenomai FPU support:

$ cat src/Kernel/build/.config | grep FPU
CONFIG_PPC_FPU=y
# CONFIG_XENO_HW_FPU is not set

I have got the following results:
 - No regression in latency test.
 - Trivial posix skin test still does not work.
 - Switchtest does not work. It crash with the following messages:
~ # /usr/xenomai/bin/switchtest 
== Testing FPU check routines...
r0: 1 != 2
r1: 1 != 2
r2: 1 != 2
r3: 1 != 2
r4: 1 != 2
r5: 1 != 2
r6: 1 != 2
r7: 1 != 2
r8: 1 != 2
r9: 1 != 2
r10: 1 != 2
r11: 1 != 2
r12: 1 != 2
r13: 1 != 2
r14: 1 != 2
r15: 1 != 2
r16: 1 != 2
r17: 1 != 2
r18: 1 != 2
r19: 1 != 2
r20: 1 != 2
r21: 1 != 2
r22: 1 != 2
r23: 1 != 2
r24: 1 != 2
r25: 1 != 2
r26: 1 != 2
r27: 1 != 2
r28: 1 != 2
r29: 1 != 2
r30: 1 != 2
r31: 1 != 2
== FPU check routines: OK.
sem_wait FAILED (38)
pthread_create: Resource temporarily unavailable
== Threads: sleeper_ufps-0 rtk-1 rtk-2 rtk_fp-3 rtk_fp-4 rtk_fp_ufpp-5 rtk_fp_ufpp-6RTT|  00:06:54
RTH|ctx switches|-------total
Illegal instruction

 - Clocktest does not work. It crash with the following messages:
~ # /usr/xenomai/bin/clocktest 
== Tested clock: 0 (CLOCK_REALTIME)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0                  0.0            0.000          0            0.0
Illegal instruction



On Thu, 28 Nov 2013 21:30:24 +0100
Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> On 11/28/2013 09:17 PM, Gilles Chanteperdrix wrote:
> > On 11/28/2013 02:31 PM, Bukuli Norbert wrote:
> >> Hello!
> >>
> >> I am having a little problem with some programs from the Xenomai
> >> test suite. The clocktest, cyclictest and switchtest crashes with
> >> "Illegal instruction":
> > 
> > What about the latency test? If it fails with the same error, you
> > could try the following patch for powerpc SPE:
> > 
> > https://git.xenomai.org/xenomai-2.6.git/commit/?id=d09932cfd0ca422989b3c3a9d736236d74590ade
> > 
> 
> The patch is needed to get switchtest working, but otherwise, you
> simply need to disable CONFIG_XENO_HW_FPU and the other tests should
> work without the patch.
> 



-- 
Norbert Bukuli
software engineer
embedded development

Mediso Ltd.
Tel.: +36 1 3993 030 Fax.: +36 1 3993 040
Mailing address: Hungary, H-1047 Budapest, Baross utca 91-95.
Billing address: Hungary, H-1022 Budapest, Alsotorokvesz 14.
norbert.bukuli@mediso.com
www.mediso.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131129/df1f9f3d/attachment.sig>
