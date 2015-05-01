Message-ID: <55433623.3000401@web.de>
Date: Fri, 01 May 2015 10:15:31 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <3382708.2jmfqTEg5F@eltrolinux48.eltroad.eltropuls>
 <2238179.hbnctTCPtY@eltrolinux48.eltroad.eltropuls>
 <20150430151442.GW1993@hermes.click-hack.org>
 <3872595.UY9zmVq9KM@eltrolinux48.eltroad.eltropuls>
In-Reply-To: <3872595.UY9zmVq9KM@eltrolinux48.eltroad.eltropuls>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Hang/Reboot when using
	CONFIG_CC_STACKPROTECTOR_REGULAR
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?windows-1252?Q?Marc_Str=E4mke?= <marc.straemke@eltropuls.de>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 2015-04-30 17:17, Marc Str=E4mke wrote:
> Am Donnerstag, 30. April 2015, 17:14:42 schrieb Gilles Chanteperdrix:
>>> I compared the disassembly of xnarch_switch_to with and without  the
>>> option
>>> set. That does like fine to me (even though i do not fully understand e=
ach
>>> line..). The CANARY_SWITCH gets inserted correctly in to the
>>> do_switch_threads inline function.
>>
>> I guess the next step is to look at what this *_REGULAR option adds
>> to CONFIG_CC_STACKPROTECTOR in the kernel code, and see if it does
>> not add something more to switch_to that we should add to
>> xnarch_switch_to.
> =

> This will probably take a bit of time on my side... =

> =

> Thank you for your help Gilles, I might have something more to say or ask=
 next =

> week...

Reproduced and quickly debugged in KVM: The switch code was just broken
regarding argument numbering when the protector is on. This fixes it
(will push a patch soon):

diff --git a/kernel/cobalt/arch/x86/thread.c b/kernel/cobalt/arch/x86/threa=
d.c
index 1b73b0d..2c2574a 100644
--- a/kernel/cobalt/arch/x86/thread.c
+++ b/kernel/cobalt/arch/x86/thread.c
@@ -57,12 +57,12 @@ static inline void do_switch_threads(struct xnarchtcb *=
out_tcb,
 =

 	__asm__ __volatile__("pushfl\n\t"
 			     "pushl %%ebp\n\t"
-			     "movl %6,%%ecx\n\t"
+			     "movl %[spp_out_ptr],%%ecx\n\t"
 			     "movl %%esp,(%%ecx)\n\t"
-			     "movl %7,%%ecx\n\t"
+			     "movl %[ipp_out_ptr],%%ecx\n\t"
 			     "movl $1f,(%%ecx)\n\t"
-			     "movl %8,%%ecx\n\t"
-			     "movl %9,%%edi\n\t"
+			     "movl %[spp_in_ptr],%%ecx\n\t"
+			     "movl %[ipp_in_ptr],%%edi\n\t"
 			     "movl (%%ecx),%%esp\n\t"
 			     "pushl (%%edi)\n\t"
 			     __CANARY_SWITCH
@@ -76,10 +76,10 @@ static inline void do_switch_threads(struct xnarchtcb *=
out_tcb,
 			       "+a"(outproc),
 			       "+d"(inproc)
 			       __CANARY_OUTPUT
-			     : "m"(out_tcb->spp),
-			       "m"(out_tcb->ipp),
-			       "m"(in_tcb->spp),
-			       "m"(in_tcb->ipp)
+			     : [spp_out_ptr] "m"(out_tcb->spp),
+			       [ipp_out_ptr] "m"(out_tcb->ipp),
+			       [spp_in_ptr] "m"(in_tcb->spp),
+			       [ipp_in_ptr] "m"(in_tcb->ipp)
 			       __CANARY_INPUT
 			     : "memory");
 }

Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150501/64ff752=
0/attachment.sig>
