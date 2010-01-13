Message-ID: <4B4D11CF.7030007@domain.hid>
Date: Wed, 13 Jan 2010 01:20:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <001101ca930a$1052fa70$30f8ef50$@kalatchev@domain.hid>	<4B4BADDD.7070900@domain.hid>	<001f01ca9390$5fa20db0$1ee62910$@kalatchev@domain.hid>	<4B4C84AC.3020207@domain.hid>	<002001ca9399$99b07c40$cd1174c0$@kalatchev@domain.hid>	<4B4C96D5.7060902@domain.hid>	<002101ca93a1$a39d4050$ead7c0f0$@kalatchev@domain.hid>	<4B4CA076.1050205@domain.hid>	<002501ca93ae$2b168850$814398f0$@kalatchev@domain.hid>	<4B4CD5E8.7040904@domain.hid>
	<004301ca93d8$4f6ca660$ee45f320$@kalatchev@domain.hid>
	<4B4CFAF1.80204@domain.hid>
	<004401ca93d9$61d05530$2570ff90$@kalatchev@domain.hid>
In-Reply-To: <004401ca93d9$61d05530$2570ff90$@kalatchev@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Viper board (ARM XScale)
	problems	with	Xenomai-2.4.10
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ivan Kalatchev <ivan.kalatchev@domain.hid>
Cc: 'Xenomai help' <xenomai@xenomai.org>

Ivan Kalatchev wrote:
>> Could you show me the error messages? The assembly sequence is pretty
>> simple.
>>
> 
> {standard input}:142: Error: bad arguments to instruction -- `adds r0,lr'
> {standard input}:143: Error: bad arguments to instruction -- `adcs ip,r2'
> {standard input}:144: Error: register expected, not '#0' -- `adc r3,#0'
> {standard input}:148: Error: bad arguments to instruction -- `adds r0,r4'
> {standard input}:149: Error: bad arguments to instruction -- `adcs ip,r1'
> {standard input}:150: Error: register expected, not '#0' -- `adc r3,#0'
> {standard input}:152: Error: bad arguments to instruction -- `adds r0,r5'
> {standard input}:153: Error: bad arguments to instruction -- `adcs ip,r2'
> {standard input}:154: Error: register expected, not '#0' -- `adc r3,#0'
> {standard input}:224: Error: bad arguments to instruction -- `adds r4,r8'
> {standard input}:225: Error: bad arguments to instruction -- `adcs r5,ip'
> {standard input}:226: Error: register expected, not '#0' -- `adc r3,#0'
> {standard input}:228: Error: bad arguments to instruction -- `adds r4,r9'
> {standard input}:229: Error: bad arguments to instruction -- `adcs r5,lr'
> {standard input}:230: Error: register expected, not '#0' -- `adc r3,#0'
> {standard input}:237: Error: bad arguments to instruction -- `adds r4,fp'
> {standard input}:238: Error: bad arguments to instruction -- `adcs r5,ip'
> 
> I just checked ARM instructions and adds for instance should be  
> 	adds r0,r1,r2  # where r0 = r1 + r2
> 
> but in arith.h there are only 2 arguments ??

Ok. The attached patch seems to fix it. Note however that I could not 
finish a linux 2.6.30 kernel compilation with my old toolchain because 
of s some assembly error in mm/page_alloc.c, looks like a toolchain bug 
detected by the kernel (.err is invoked directly).

I ran the arith unit test on arm926ejs. the do_div based llimd 
implementation gives:
out of line llimd: 0x79364d9364d9362f: 9880.462 ns, rejected 11/10000
that is almost 10us
the C version of nodiv_llimd (with 3 lines of inline assembly) gives:
out of line nodiv_llimd: 0x79364d9364d9362f: 551.893 ns, rejected 26/10000
the arm assembly version of nodiv_llimd gives:
out of line nodiv_llimd: 0x79364d9364d9362f: 379.022 ns, rejected 29/10000

Here comes the patch:
diff --git a/include/asm-arm/arith.h b/include/asm-arm/arith.h
index eca69ba..6908681 100644
--- a/include/asm-arm/arith.h
+++ b/include/asm-arm/arith.h
@@ -14,9 +14,9 @@ rthal_arm_nodiv_ullimd(const unsigned long long op,
 #else /* arm <= v3 */
 #define __rthal_add96and64(l0, l1, l2, s0, s1)         \
        do {                                            \
-               __asm__ ("adds %2, %4\n\t"              \
-                        "adcs %1, %3\n\t"              \
-                        "adc %0, #0\n\t"               \
+               __asm__ ("adds %2, %2, %4\n\t"          \
+                        "adcs %1, %1, %3\n\t"          \
+                        "adc %0, %0, #0\n\t"           \
                         : "+r"(l0), "+r"(l1), "+r"(l2) \
                         : "r"(s0), "r"(s1): "cc");     \
        } while (0)
@@ -46,17 +46,17 @@ rthal_arm_nodiv_ullimd(const unsigned long long op,

        __asm__ ("umull %[tl], %[rl], %[opl], %[fracl]\n\t"
                 "umull %[rm], %[rh], %[oph], %[frach]\n\t"
-                "adds %[rl], %[tl], lsr #31\n\t"
-                "adcs %[rm], #0\n\t"
-                "adc %[rh], #0\n\t"
+                "adds %[rl], %[rl], %[tl], lsr #31\n\t"
+                "adcs %[rm], %[rm], #0\n\t"
+                "adc %[rh], %[rh], #0\n\t"
                 "umull %[tl], %[th], %[oph], %[fracl]\n\t"
-                "adds %[rl], %[tl]\n\t"
-                "adcs %[rm], %[th]\n\t"
-                "adc %[rh], #0\n\t"
+                "adds %[rl], %[rl], %[tl]\n\t"
+                "adcs %[rm], %[rm], %[th]\n\t"
+                "adc %[rh], %[rh], #0\n\t"
                 "umull %[tl], %[th], %[opl], %[frach]\n\t"
-                "adds %[rl], %[tl]\n\t"
-                "adcs %[rm], %[th]\n\t"
-                "adc %[rh], #0\n\t"
+                "adds %[rl], %[rl], %[tl]\n\t"
+                "adcs %[rm], %[rm], %[th]\n\t"
+                "adc %[rh], %[rh], #0\n\t"
                 "umlal %[rm], %[rh], %[opl], %[integ]\n\t"
                 "mla %[rh], %[oph], %[integ], %[rh]\n\t"
                 : [rl]"=r"(rl), [rm]"=r"(rm), [rh]"=r"(rh),

Regards.

-- 
					    Gilles.

