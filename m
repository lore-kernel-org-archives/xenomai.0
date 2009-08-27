Message-ID: <4A9676A0.8010706@domain.hid>
Date: Thu, 27 Aug 2009 14:05:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4A96692B.6070704@domain.hid> <4A966AA5.1050406@domain.hid>	
	<4A966CDB.7060800@domain.hid> <4A966DB2.8030202@domain.hid>
	<1251373843.4321.30.camel@domain.hid>
In-Reply-To: <1251373843.4321.30.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Negative Latency results
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Christoph Permes <christoph.permes@domain.hid>
Cc: xenomai@xenomai.org

Christoph Permes wrote:
> Hi,
> 
> I'm working together with Peter on the latency problem.
> 
> I have attached our kernel configuration and the boot log to this mail.
> 
> We have tried out configuring a latency between 0 and 10000 but this
> didn't help.

Ok. Could you try the following patch:

diff --git a/include/asm-generic/bits/timeconv.h
b/include/asm-generic/bits/timeconv.h
index 9a89fe9..654f17f 100644
--- a/include/asm-generic/bits/timeconv.h
+++ b/include/asm-generic/bits/timeconv.h
@@ -37,6 +37,11 @@ long long xnarch_tsc_to_ns_rounded(long long ticks)
        unsigned int shift = tsc_shift - 1;
        return (xnarch_llmulshft(ticks, tsc_scale, shift) + 1) / 2;
 }
+
+long long xnarch_ns_to_tsc(long long ns)
+{
+       return xnarch_llimd(ns, 1 << tsc_shift, tsc_scale);
+}
 #else  /* !XNARCH_HAVE_LLMULSHFT */
 long long xnarch_tsc_to_ns(long long ticks)
 {
@@ -46,12 +51,12 @@ long long xnarch_tsc_to_ns_rounded(long long ticks)
 {
        return (xnarch_llimd(ticks, 1000000000, cpufreq/2) + 1) / 2;
 }
-#endif /* !XNARCH_HAVE_LLMULSHFT */

 long long xnarch_ns_to_tsc(long long ns)
 {
        return xnarch_llimd(ns, cpufreq, 1000000000);
 }
+#endif /* !XNARCH_HAVE_LLMULSHFT */

 static inline void xnarch_init_timeconv(unsigned long long freq)
 {


-- 
                                          Gilles


