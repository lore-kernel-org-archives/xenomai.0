Message-ID: <5269583F.4080701@siemens.com>
Date: Thu, 24 Oct 2013 18:26:23 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <5268DCEA.7000202@basystemes.fr> <5268F13E.4020402@siemens.com>
 <5269414F.6020806@xenomai.org> <52694D61.7090902@siemens.com>
In-Reply-To: <52694D61.7090902@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] xsave/xrstor compilation error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Jean-Baptiste Tredez <jean-baptiste.tredez@basystemes.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2013-10-24 17:40, Jan Kiszka wrote:
> On 2013-10-24 16:48, Gilles Chanteperdrix wrote:
>> On 10/24/2013 12:06 PM, Jan Kiszka wrote:
>>> We
>>> can, of course, replace the instructions with their obcodes (like the
>>> kernel does), just makes the code more ugly.
>>
>> Jan, please do this, even if it makes the code more ugly, it makes sense
>> for the 2.6.3 release to continue working with the tools it already
>> supported. No question for -forge, but we try hard to keep ABI
>> compatibility so that users can upgrade xenomai without even recompiling
>> their application, it does not make sense to suddenly stop working with
>> a toolchain which always worked before.
> 
> In fact, we already have legacy gas support: all these new instructions
> are wrapped with CONFIG_AS_AVX, and only if that is set we use the new
> assembler instructions. Given that this CONFIG has to be set based on
> some test, something seems to go wrong in the kernel build over there.
> But that's outside of the Xenomai scope. I'm currently trying to find
> out if there was some related kernel issue back then.

OK, something likely went wrong in my brain back then while I tried to
make this build for all the combinations. I can't recall what those
CONFIG_X86_64 tests were for. This should build and in theory also work:

diff --git a/include/asm-x86/bits/pod.h b/include/asm-x86/bits/pod.h
index a32575f..c6fbcee 100644
--- a/include/asm-x86/bits/pod.h
+++ b/include/asm-x86/bits/pod.h
@@ -241,7 +241,7 @@ static inline void __save_i387(x86_fpustate *fpup)
 {
 #ifdef cpu_has_xsave
 	if (cpu_has_xsave) {
-#if defined(CONFIG_AS_AVX) || !defined CONFIG_X86_64
+#if defined(CONFIG_AS_AVX)
 		asm volatile("xsave" XSAVE_SUFFIX " %0"
 			     : "=m" (fpup->xsave) : "a" (-1), "d" (-1)
 			     : "memory");
@@ -301,7 +301,7 @@ static inline void __restore_i387(x86_fpustate *fpup)
 {
 #ifdef cpu_has_xsave
 	if (cpu_has_xsave) {
-#if defined(CONFIG_AS_AVX) || !defined(CONFIG_X86_64)
+#if defined(CONFIG_AS_AVX)
 		asm volatile("xrstor" XSAVE_SUFFIX " %0"
 			     : : "m" (fpup->xsave), "a" (-1), "d" (-1)
 			     : "memory");

Jean-Baptiste, do you happen to have an xsave-capable box at hand to
test this (/proc/cpuinfo shows the available features)? Xenomai's
switchtest will stress the code.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

