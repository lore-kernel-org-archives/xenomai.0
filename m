Message-ID: <4BF192A6.6080508@domain.hid>
Date: Mon, 17 May 2010 21:01:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTil1N6ULXXuv4nx5n_amHqE61tZNuSaw6ndLPdPL@mail.gmail.com>	
	<4BF18A00.706@domain.hid>
	<AANLkTinkr4vDIHFMJigC7i9dCXjoG2d_gNG11txXrjpd@domain.hid>
In-Reply-To: <AANLkTinkr4vDIHFMJigC7i9dCXjoG2d_gNG11txXrjpd@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Error building userspace: "selected processor
 does not support `rsc r7, r7, #0'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeremy Brown <jhbrown@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Jeremy Brown wrote:
> On Mon, May 17, 2010 at 11:25 AM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> Jeremy Brown wrote:
>>> {standard input}: Assembler messages:
>>> {standard input}:140: Error: selected processor does not support `rsc
>>> r7,r7,#0'
>>> {standard input}:159: Error: selected processor does not support `rsc
>>> r1,r1,#0'
>>> make: *** [libxenomai_la-timeconv.lo] Error 1
>> Ok. Could you try and compile the following piece of code with your
>> toolchain and show me the disassembly ?
>>
>> long long foo(long long x)
>> {
>>        return -x;
>> }
>>
>> --
>>                                            Gilles.
> 
> Thanks for the quick reply!  Here's the complete contents of foo.s:
> 
>         .syntax unified

That is the key: I presume this means your compiler generates syntax
which works both with ARM and thumb2, and rsc does not exist with
thumb2. Note that from a performance point of view, this may not be a win.

So be it. Try the following patch:
diff --git a/include/asm-arm/arith.h b/include/asm-arm/arith.h
index e86975c..72c0ab7 100644
--- a/include/asm-arm/arith.h
+++ b/include/asm-arm/arith.h
@@ -103,13 +103,13 @@ rthal_arm_nodiv_llimd(const long long op,
 	__asm__ ("movs %[s], %[oph], lsr #30\n\t"
 		 "beq 1f\n\t"
 		 "rsbs  %[opl], %[opl], #0\n\t"
-		 "rsc  %[oph], %[oph], #0\n"
+		 "sbc  %[oph], %[oph], %[oph], lsl #1\n"
 		 "1:\t"
 		 rthal_arm_nodiv_ullimd_str
 		 "teq %[s], #0\n\t"
 		 "beq 2f\n\t"
 		 "rsbs  %[rm], %[rm], #0\n\t"
-		 "rsc  %[rh], %[rh], #0\n"
+		 "sbc  %[rh], %[rh], %[rh], lsl #1\n"
 		 "2:\t"
 		 : [rl]"=r"(rl), [rm]"=r"(rm), [rh]"=r"(rh),
 		   [tl]"=r"(tl), [th]"=r"(th), [s]"=r"(s)



-- 
					    Gilles.

