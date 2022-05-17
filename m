From: Zqiang <qiang1.zhang@intel.com>
Subject: [linux-dovetail][PATCH 1/3] x86/tsc: Add TSC support functions to
 support ART driven Time-Aware GPIO
Date: Tue, 17 May 2022 09:53:16 +0800
Message-Id: <20220517015318.697955-2-qiang1.zhang@intel.com>
In-Reply-To: <20220517015318.697955-1-qiang1.zhang@intel.com>
References: <20220517015318.697955-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: rpm@xenomai.org, jan.kiszka@siemens.com
Cc: hongzhan.chen@intel.com, xenomai@xenomai.org

From: Christopher Hall <christopher.s.hall@intel.com>

The PMC Time-Aware GPIO (TGPIO) logic is driven by ART. Several support
functions are required to translate ART to/from nanoseconds units which
is required by the PHC clock interface. A function is also added to get
the current value of ART/TSC using get_cycles() (RDTSC). This avoids
multiple MMIO reads required to retrieve ART.

Note that rather than ART nanoseconds, TSC nanoseconds are used. These are
related by TSC = ART * CPUID[15H].EBX/CPUID[15H].EAX + K. The value of
K is the distinction between between the ART and TSC nanoseconds.

The advantage of using TSC nanoseconds to represent the device clock
because it can easily be calculated in user-space using only CPUID[15H].
The value of ART in general can't be since K isn't necessarily known to
the application.

Signed-off-by: Christopher Hall <christopher.s.hall@intel.com>
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 arch/x86/include/asm/tsc.h |   6 ++
 arch/x86/kernel/tsc.c      | 116 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 01a300a9700b..721caa09a14d 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -30,6 +30,12 @@ static inline cycles_t get_cycles(void)
 
 extern struct system_counterval_t convert_art_to_tsc(u64 art);
 extern struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns);
+extern struct timespec64 get_tsc_ns_now(struct system_counterval_t
+					*system_counter);
+extern u64 convert_tsc_ns_to_art(struct timespec64 *tsc_ns);
+extern u64 convert_tsc_ns_to_art_duration(struct timespec64 *tsc_ns);
+extern struct timespec64 convert_art_to_tsc_ns(u64 art);
+extern struct timespec64 convert_art_to_tsc_ns_duration(u64 art);
 
 extern void tsc_early_init(void);
 extern void tsc_init(void);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 9eae730d8b44..c4b48323c4bf 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1260,7 +1260,7 @@ int unsynchronized_tsc(void)
 /*
  * Convert ART to TSC given numerator/denominator found in detect_art()
  */
-struct system_counterval_t convert_art_to_tsc(u64 art)
+static struct system_counterval_t _convert_art_to_tsc(u64 art, bool dur)
 {
 	u64 tmp, res, rem;
 
@@ -1270,13 +1270,125 @@ struct system_counterval_t convert_art_to_tsc(u64 art)
 	tmp = rem * art_to_tsc_numerator;
 
 	do_div(tmp, art_to_tsc_denominator);
-	res += tmp + art_to_tsc_offset;
+	res += tmp;
+	if (!dur)
+		res += art_to_tsc_offset;
 
 	return (struct system_counterval_t) {.cs = art_related_clocksource,
 			.cycles = res};
 }
+
+struct system_counterval_t convert_art_to_tsc(u64 art)
+{
+	return _convert_art_to_tsc(art, false);
+}
 EXPORT_SYMBOL(convert_art_to_tsc);
 
+static
+struct timespec64 get_tsc_ns(struct system_counterval_t *system_counter)
+{
+	u64 tmp, res, rem;
+	u64 cycles;
+
+	cycles = system_counter->cycles;
+	rem = do_div(cycles, tsc_khz);
+
+	res = cycles * USEC_PER_SEC;
+	tmp = rem * USEC_PER_SEC;
+
+	rem = do_div(tmp, tsc_khz);
+	tmp += rem > tsc_khz >> 2 ? 1 : 0;
+	res += tmp;
+
+	rem = do_div(res, NSEC_PER_SEC);
+
+	return (struct timespec64) {.tv_sec = res, .tv_nsec = rem};
+}
+
+struct timespec64 get_tsc_ns_now(struct system_counterval_t *system_counter)
+{
+	struct system_counterval_t counterval;
+
+	if (system_counter == NULL)
+		system_counter = &counterval;
+
+	system_counter->cycles = clocksource_tsc.read(NULL);
+	system_counter->cs = art_related_clocksource;
+
+	return get_tsc_ns(system_counter);
+}
+EXPORT_SYMBOL(get_tsc_ns_now);
+
+struct timespec64 convert_art_to_tsc_ns(u64 art)
+{
+	struct system_counterval_t counterval;
+
+	counterval = _convert_art_to_tsc(art, false);
+
+	return get_tsc_ns(&counterval);
+}
+EXPORT_SYMBOL(convert_art_to_tsc_ns);
+
+struct timespec64 convert_art_to_tsc_ns_duration(u64 art)
+{
+	struct system_counterval_t counterval;
+
+	counterval = _convert_art_to_tsc(art, true);
+
+	return get_tsc_ns(&counterval);
+}
+EXPORT_SYMBOL(convert_art_to_tsc_ns_duration);
+
+static u64 convert_tsc_ns_to_tsc(struct timespec64 *tsc_ns)
+{
+	u64 tmp, res, rem;
+	u64 cycles;
+
+	cycles = timespec64_to_ns(tsc_ns);
+
+	rem = do_div(cycles, USEC_PER_SEC);
+
+	res = cycles * tsc_khz;
+	tmp = rem * tsc_khz;
+
+	do_div(tmp, USEC_PER_SEC);
+
+	return res + tmp;
+}
+
+
+static u64 _convert_tsc_ns_to_art(struct timespec64 *tsc_ns, bool dur)
+{
+	u64 tmp, res, rem;
+	u64 cycles;
+
+	cycles = convert_tsc_ns_to_tsc(tsc_ns);
+	if (!dur)
+		cycles -= art_to_tsc_offset;
+
+	rem = do_div(cycles, art_to_tsc_numerator);
+
+	res = cycles * art_to_tsc_denominator;
+	tmp = rem * art_to_tsc_denominator;
+
+	rem = do_div(tmp, art_to_tsc_numerator);
+	tmp += rem > art_to_tsc_numerator >> 2 ? 1 : 0;
+
+	return res + tmp;
+}
+
+u64 convert_tsc_ns_to_art(struct timespec64 *tsc_ns)
+{
+	return _convert_tsc_ns_to_art(tsc_ns, false);
+}
+EXPORT_SYMBOL(convert_tsc_ns_to_art);
+
+u64 convert_tsc_ns_to_art_duration(struct timespec64 *tsc_ns)
+{
+	return _convert_tsc_ns_to_art(tsc_ns, true);
+}
+EXPORT_SYMBOL(convert_tsc_ns_to_art_duration);
+
 /**
  * convert_art_ns_to_tsc() - Convert ART in nanoseconds to TSC.
  * @art_ns: ART (Always Running Timer) in unit of nanoseconds
-- 
2.25.1


