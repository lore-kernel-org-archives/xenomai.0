Message-ID: <47F4D87F.7080204@domain.hid>
Date: Thu, 03 Apr 2008 15:15:43 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <20080402012645.506e53ef.Cornelius.Koepp@domain.hid>	
	<47F34C0D.6090809@domain.hid> <47F37579.7080601@domain.hid>	
	<47F37BF8.6000401@domain.hid> <47F3AD14.4090306@domain.hid>
	<2ff1a98a0804020905v7019574ai927f213ab6603e41@domain.hid>
	<47F3B348.1090102@domain.hid> <47F4CAD1.3090002@domain.hid>
In-Reply-To: <47F4CAD1.3090002@domain.hid>
Content-Type: multipart/mixed; boundary="------------060305050709020306030502"
Subject: Re: [Xenomai-core] latencys drifting into negative (Xenomai
	2.4.2/2.4.3)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>, =?ISO-8859-1?Q?Cornelius_K=F6pp?= <Cornelius.Koepp@domain.hid>

This is a multi-part message in MIME format.
--------------060305050709020306030502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by authsmtp.rrzn.uni-hannover.de id m33DFfIV001596

Jan Kiszka wrote:
> Sebastian Smolorz wrote:
>> Gilles Chanteperdrix wrote:
>>> On Wed, Apr 2, 2008 at 5:58 PM, Sebastian Smolorz
>>> <smolorz@domain.hid> wrote:
>>>> Jan Kiszka wrote:
>>>>  > Sebastian Smolorz wrote:
>>>>  >> Jan Kiszka wrote:
>>>>  >>> Cornelius K=F6pp wrote:
>>>>  >>>> I talked with Sebastian Smolorz about this and he builds his o=
wn
>>>>  >>>> independent kernel-config to check. He got the same=20
>>>> drifting-effect
>>>>  >>>> with Xenomai 2.4.2 and Xenomai 2.4.3 running latency over seve=
ral
>>>>  >>>> hours. His kernel-config ist attached as
>>>>  >>>> 'config-2.6.24-xenomai-2.4.3__ssm'.
>>>>  >>>>
>>>>  >>>> Our kernel-configs are both based on a config used with=20
>>>> Xenomai 2.3.4
>>>>  >>>> and Linux 2.6.20.15 without any drifting effects.
>>>>  >>> 2.3.x did not incorporate the new TSC-to-ns conversion. Maybe=20
>>>> it is
>>>>  >>> not a PIC vs. APIC thing, but rather a rounding problem of=20
>>>> larger TSC
>>>>  >>> values (that naturally show up when the system runs for a=20
>>>> longer time).
>>>>  >> This hint seems to point into the right direction. I tried out a
>>>>  >> modified pod_32.h (xnarch_tsc_to_ns() commented out) so that the=
=20
>>>> old
>>>>  >> implementation in include/asm-generic/bits/pod.h was used. The=20
>>>> drifting
>>>>  >> bug disappeared. So there seems so be a buggy x86-specific
>>>>  >> implementation of this routine.
>>>>  >
>>>>  > Hmm, maybe even a conceptional issue: the multiply-shift-based
>>>>  > xnarch_tsc_to_ns is not as precise as the still=20
>>>> multiply-divide-based
>>>>  > xnarch_ns_to_tsc. So when converting from tsc over ns back to=20
>>>> tsc, we
>>>>  > may loose some bits, maybe too many bits...
>>>>  >
>>>>  > It looks like this bites us in the kernel latency tests (-t2 shou=
ld
>>>>  > suffer as well). Those recalculate their timeouts each round=20
>>>> based on
>>>>  > absolute nanoseconds. In contrast, the periodic user mode task of=
=20
>>>> -t0
>>>>  > uses a periodic timer that is forwarded via a tsc-based interval.
>>>>  >
>>>>  > You (or Cornelius) could try to analyse the calculation path of t=
he
>>>>  > involved timeouts, specifically to understand why the scheduled=20
>>>> timeout
>>>>  > of the underlying task timer (which is tsc-based) tend to diverge=
=20
>>>> from
>>>>  > the calculated one (ns-based).
>>>>
>>>>  So here comes the explanation. The error is inside the function
>>>>  rthal_llmulshft(). It returns wrong values which are too small - th=
e
>>>>  higher the given TSC value the bigger the error. The function
>>>>  rtdm_clock_read_monotonic() calls rthal_llmulshft(). As
>>>>  rtdm_clock_read_monotonic() is called every time the latency kernel
>>>>  thread runs [1] the values reported by latency become smaller over=20
>>>> time.
>>>>
>>>>  In contrast, the latency task in user space only uses the conversio=
n
>>>>  from TSC to ns only once when calling rt_timer_inquire [2].
>>>>  timer_info.date is too small, timer_info.tsc is right. So all=20
>>>> calculated
>>>>   deltas in [3] are shifted to a smaller value. This value is consta=
nt
>>>>  during the runtime of lateny in user space because no more conversi=
on
>>>>  from TSC to ns occurs.
>>>
>>> latency does conversions from tsc to ns, but it converts time
>>> differences, so the error is small relative to the results.
>>
>> Of course. I wasn't precise with my last statement. It should be: No=20
>> more conversions from *absolute* TSC values to ns occur.
>>
>=20
> This patch may do the trick: it uses the inverted tsc-to-ns function=20
> instead of the frequency-based one. Be warned, it is totally untested=20
> inside Xenomai, I just ran it in a user space test program. But it may=20
> give an idea.

Your patch needed two minor corrections (ns instead of ts in functions=20
xnarch_ns_to_tsc()) in order to compile. A short run (30 minutes) of=20
latency -t1 seems to prove your bug-fix: There seems to be no drift.

If I got your patch correctly, it doesn't make xnarch_tsc_to_ns more=20
precise but introduces a new function xnarch_ns_to_tsc() which is also=20
less precise than the generic xnarch_ns_to_tsc(), right? So isn't there=20
still the danger of getting wrong values when calling xnarch_tsc_to_ns()=20
  not in combination with xnarch_ns_to_tsc()?

--=20
Sebastian

--------------060305050709020306030502
Content-Type: text/plain;
 name="fixup-scaled-ns2tsc-conversion.patch"
Content-Disposition: inline;
 filename="fixup-scaled-ns2tsc-conversion.patch"
Content-Transfer-Encoding: 7bit

---
 include/asm-x86/bits/init_32.h |    3 ++-
 include/asm-x86/bits/init_64.h |    3 ++-
 include/asm-x86/bits/pod_32.h  |    7 +++++++
 include/asm-x86/bits/pod_64.h  |    7 +++++++
 4 files changed, 18 insertions(+), 2 deletions(-)

Index: b/include/asm-x86/bits/init_32.h
===================================================================
--- a/include/asm-x86/bits/init_32.h
+++ b/include/asm-x86/bits/init_32.h
@@ -73,7 +73,7 @@ int xnarch_calibrate_sched(void)
 
 static inline int xnarch_init(void)
 {
-	extern unsigned xnarch_tsc_scale, xnarch_tsc_shift;
+	extern unsigned xnarch_tsc_scale, xnarch_tsc_shift, xnarch_tsc_divide;
 	int err;
 
 	err = rthal_init();
@@ -89,6 +89,7 @@ static inline int xnarch_init(void)
 
 	xnarch_init_llmulshft(1000000000, RTHAL_CPU_FREQ,
 			      &xnarch_tsc_scale, &xnarch_tsc_shift);
+	xnarch_tsc_divide = 1 << xnarch_tsc_shift;
 
 	err = xnarch_calibrate_sched();
 
Index: b/include/asm-x86/bits/init_64.h
===================================================================
--- a/include/asm-x86/bits/init_64.h
+++ b/include/asm-x86/bits/init_64.h
@@ -70,7 +70,7 @@ int xnarch_calibrate_sched(void)
 
 static inline int xnarch_init(void)
 {
-	extern unsigned xnarch_tsc_scale, xnarch_tsc_shift;
+	extern unsigned xnarch_tsc_scale, xnarch_tsc_shift, xnarch_tsc_divide;
 	int err;
 
 	err = rthal_init();
@@ -86,6 +86,7 @@ static inline int xnarch_init(void)
 
 	xnarch_init_llmulshft(1000000000, RTHAL_CPU_FREQ,
 			      &xnarch_tsc_scale, &xnarch_tsc_shift);
+	xnarch_tsc_divide = 1 << xnarch_tsc_shift;
 
 	err = xnarch_calibrate_sched();
 
Index: b/include/asm-x86/bits/pod_32.h
===================================================================
--- a/include/asm-x86/bits/pod_32.h
+++ b/include/asm-x86/bits/pod_32.h
@@ -25,6 +25,7 @@
 
 unsigned xnarch_tsc_scale;
 unsigned xnarch_tsc_shift;
+unsigned xnarch_tsc_divide;
 
 long long xnarch_tsc_to_ns(long long ts)
 {
@@ -32,6 +33,12 @@ long long xnarch_tsc_to_ns(long long ts)
 }
 #define XNARCH_TSC_TO_NS
 
+long long xnarch_ns_to_tsc(long long ns)
+{
+	return xnarch_llimd(ns, xnarch_tsc_divide, xnarch_tsc_scale);
+}
+#define XNARCH_NS_TO_TSC
+
 #include <asm-generic/xenomai/bits/pod.h>
 #include <asm/xenomai/switch.h>
 
Index: b/include/asm-x86/bits/pod_64.h
===================================================================
--- a/include/asm-x86/bits/pod_64.h
+++ b/include/asm-x86/bits/pod_64.h
@@ -24,6 +24,7 @@
 
 unsigned xnarch_tsc_scale;
 unsigned xnarch_tsc_shift;
+unsigned xnarch_tsc_divide;
 
 long long xnarch_tsc_to_ns(long long ts)
 {
@@ -31,6 +32,12 @@ long long xnarch_tsc_to_ns(long long ts)
 }
 #define XNARCH_TSC_TO_NS
 
+long long xnarch_ns_to_tsc(long long ns)
+{
+	return xnarch_llimd(ns, xnarch_tsc_divide, xnarch_tsc_scale);
+}
+#define XNARCH_NS_TO_TSC
+
 #include <asm-generic/xenomai/bits/pod.h>
 #include <asm/xenomai/switch.h>
 

--------------060305050709020306030502--

