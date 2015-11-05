From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 5 Nov 2015 11:57:50 -0500
Message-ID: <20151105165750.GP21923@csclub.uwaterloo.ca>
References: <20151105015114.GJ21923@csclub.uwaterloo.ca>
 <20151105110141.GC16314@hermes.click-hack.org>
 <20151105145159.GK21923@csclub.uwaterloo.ca>
 <20151105145725.GL21923@csclub.uwaterloo.ca>
 <20151105150226.GM21923@csclub.uwaterloo.ca>
 <20151105151544.GD16314@hermes.click-hack.org>
 <20151105152427.GN21923@csclub.uwaterloo.ca>
 <20151105155549.GE16314@hermes.click-hack.org>
 <20151105161902.GO21923@csclub.uwaterloo.ca>
 <20151105162514.GF16314@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151105162514.GF16314@hermes.click-hack.org>
Subject: Re: [Xenomai] ARM bus error due to alignment
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Nov 05, 2015 at 05:25:14PM +0100, Gilles Chanteperdrix wrote:
> I am sure. Xenomai does not use H_DMA on armv7, so, it is not used
> if your code, it is not used at all.

Well we are using it for one allocation for talking to a network port.

If I remove it, I get a NULL pointer dereference, so it clearly matters
to something in our code.

> > It does appear that when LPAE is enabled H_DMA does do something on arm,
> > but only when LPAE is enabled since that enables ZONE_DMA.
> 
> I never said that H_DMA did nothing.

OK I misunderstood then.

Setting /proc/cpu/alignment to 0 gives the kernel message:
alignment: ignoring faults is unsafe on this CPU.  Defaulting to fixup mode.

Apparently armv6+ with CR_U set is not allowed to turn off fixups.

The fixups don't work for the xenomai code though it would seem.

I get:
Alignment trap: not handling instruction f8d03002 at [<00020be0>]
Unhandled fault: alignment exception (0x221) at 0xb56ba006

Code looks like this:
   20bd8:       6802            ldr     r2, [r0, #0]
   20bda:       680b            ldr     r3, [r1, #0]
   20bdc:       429a            cmp     r2, r3
   20bde:       d107            bne.n   20bf0 <_ZNK11rc_mac_addreqERKS_+0x18>
-> 20be0:       f8d0 3002       ldr.w   r3, [r0, #2]
   20be4:       f8d1 0002       ldr.w   r0, [r1, #2]
   20be8:       1a1b            subs    r3, r3, r0
   20bea:       4258            negs    r0, r3
   20bec:       4158            adcs    r0, r3
   20bee:       4770            bx      lr
   20bf0:       2000            movs    r0, #0
   20bf2:       4770            bx      lr

As far as I understand it, ldr.w should work for unaligned reads as long
as the page if flagged normal.  Still trying to determine what the page
is marked as in this case.

And looking at the code compiled with gcc-4.6 it is obviously different
and would not have alignment issues (but is much less efficient):
   49a46:       b5f0            push    {r4, r5, r6, r7, lr}
   49a48:       7847            ldrb    r7, [r0, #1]
   49a4a:       7803            ldrb    r3, [r0, #0]
   49a4c:       784e            ldrb    r6, [r1, #1]
   49a4e:       ea43 2707       orr.w   r7, r3, r7, lsl #8
   49a52:       780b            ldrb    r3, [r1, #0]
   49a54:       7884            ldrb    r4, [r0, #2]
   49a56:       ea43 2606       orr.w   r6, r3, r6, lsl #8
   49a5a:       788b            ldrb    r3, [r1, #2]
   49a5c:       78c5            ldrb    r5, [r0, #3]
   49a5e:       78ca            ldrb    r2, [r1, #3]
   49a60:       ea47 4704       orr.w   r7, r7, r4, lsl #16
   49a64:       ea46 4603       orr.w   r6, r6, r3, lsl #16
   49a68:       ea47 6705       orr.w   r7, r7, r5, lsl #24
   49a6c:       ea46 6602       orr.w   r6, r6, r2, lsl #24
   49a70:       42b7            cmp     r7, r6
   49a72:       d114            bne.n   49a9e <_ZNK11rc_mac_addreqERKS_+0x58>
   49a74:       ea43 2302       orr.w   r3, r3, r2, lsl #8
   49a78:       790a            ldrb    r2, [r1, #4]
   49a7a:       ea44 2405       orr.w   r4, r4, r5, lsl #8
   49a7e:       7905            ldrb    r5, [r0, #4]
   49a80:       7940            ldrb    r0, [r0, #5]
   49a82:       ea43 4302       orr.w   r3, r3, r2, lsl #16
   49a86:       794a            ldrb    r2, [r1, #5]
   49a88:       ea44 4405       orr.w   r4, r4, r5, lsl #16
   49a8c:       ea44 6000       orr.w   r0, r4, r0, lsl #24
   49a90:       ea43 6302       orr.w   r3, r3, r2, lsl #24
   49a94:       1ac1            subs    r1, r0, r3
   49a96:       4248            negs    r0, r1
   49a98:       eb40 0001       adc.w   r0, r0, r1
   49a9c:       bdf0            pop     {r4, r5, r6, r7, pc}
   49a9e:       2000            movs    r0, #0
   49aa0:       bdf0            pop     {r4, r5, r6, r7, pc}

Stupid alignment problems. :)

I tried booting with 'noalign' kernel argument which appears in the code
to clear the CR_A flag, but that didn't make any difference.

-- 
Len Sorensen

