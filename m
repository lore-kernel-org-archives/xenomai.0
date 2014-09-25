Message-ID: <54243C40.7060209@xenomai.org>
Date: Thu, 25 Sep 2014 18:01:04 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <d5e7531ec6454715adde3750c412a062@CVEX13.valentin-carl.de>
 <5424316B.3040002@xenomai.org> <542437D3.4080605@xenomai.org>
 <54243915.3020808@xenomai.org>
In-Reply-To: <54243915.3020808@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] bad syscall <167772715>/ Segmentation fault during
 xeno-test
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Reitinger, Peter" <preitinger@carl-valentin.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/25/2014 05:47 PM, Philippe Gerum wrote:
> On 09/25/2014 05:42 PM, Philippe Gerum wrote:
>> On 09/25/2014 05:14 PM, Philippe Gerum wrote:
>>> On 09/25/2014 04:52 PM, Reitinger, Peter wrote:
>>>> Dear Xenomai people,
>>>>
>>>> I have recently tried to migrate from 2.x to 3.x, but when I tried to run xeno-test, I get the following output:
>>>>
>>>>
>>>
>>> [snip]
>>>
>>>> [   94.434282] [Xenomai] bad syscall <167772715>
>>>> Segmentation fault
>>>> root@dimm-am335x:/usr/xenomai/bin#
>>>>
>>>>
>>>>
>>>> Probably I just forgot one or another little thing to adapt...?
>>>>
>>>
>>> This is not a Xenomai 3 syscall signature, but a Xenomai 2.x's. Could
>>> you provide the output of /usr/xenomai/bin/version -a?
>>>
>>
>> Never mind, I can reproduce on igep, this looks like arm-specific. I'll
>> follow up on this. Thanks.
>>
> 
> Ok, the watchdog fired while running the quata scheduling test, which is
> legitimate with the default 4s threshold. What went wrong is that some
> of the watchdog bits were not updated to the new syscall format.
> Raising CONFIG_XENO_OPT_WATCHDOG_TIMEOUT to a larger value will prevent
> the trigger (or disabling CONFIG_XENO_OPT_WATCHDOG as well), while I'm
> fixing this.
> 

Nope, disabling the watchdog won't be enough, as the Cobalt core uses a
mayday trap internally for other purpose. However, this patch should fix
the issue:

diff --git a/kernel/cobalt/arch/arm/mayday.c
b/kernel/cobalt/arch/arm/mayday.c
index d6b7924..724200b 100644
--- a/kernel/cobalt/arch/arm/mayday.c
+++ b/kernel/cobalt/arch/arm/mayday.c
@@ -35,7 +35,7 @@ void xnarch_setup_mayday_page(void *page)
 	 * ef000000 	svc	0x00000000
 	 * e3a00000 	mov	r0, #0
 	 * e5800000 	str	r0, [r0]	; <bug>
-	 * 0a00022b     .word   0x0a00022b	; __xn_sys_mayday << 24
+	 * 1000005e     .word   0x1000005e	; sc_cobalt_mayday |
__COBALT_SYSCALL_BIT
 	 * 000f0042     .word   0x000f0042
 	 *
 	 * elif ARM_OABI
@@ -44,7 +44,7 @@ void xnarch_setup_mayday_page(void *page)
 	 * ef9f0042 	swi	0x009f0042
 	 * e3a00000 	mov	r0, #0
 	 * e5800000 	str	r0, [r0]	; <bug>
-	 * 0a00022b     .word   0x0a00022b	; __xn_sys_mayday << 24
+	 * 1000005e     .word   0x1000005e	; sc_cobalt_mayday |
__COBALT_SYSCALL_BIT
 	 *
 	 * endif
 	 *
@@ -69,7 +69,7 @@ void xnarch_setup_mayday_page(void *page)
 		.swi_0 = 0xef000000,
 		.mov_r0 = 0xe3a00000,
 		.str_r0 = 0xe5800000,
-		.cst_r0 = 0x0a00022b,
+		.cst_r0 =  sc_cobalt_mayday | __COBALT_SYSCALL_BIT,
 		.cst_r7 = 0x000f0042,
 	};
 #else /* OABI */
@@ -84,7 +84,7 @@ void xnarch_setup_mayday_page(void *page)
 		.swi_syscall = 0xef9f0042,
 		.mov_r0 = 0xe3a00000,
 		.str_r0 = 0xe5800000,
-		.cst_r0 = 0x0a00022b,
+		.cst_r0 =  sc_cobalt_mayday | __COBALT_SYSCALL_BIT,
 	};
 #endif /* OABI */



-- 
Philippe.

