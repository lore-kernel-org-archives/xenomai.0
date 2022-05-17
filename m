From: Zqiang <qiang1.zhang@intel.com>
Subject: [linux-dovetail][PATCH 2/3] ptp: tgpio: PSE TGPIO crosststamp,
 counttstamp
Date: Tue, 17 May 2022 09:53:17 +0800
Message-Id: <20220517015318.697955-3-qiang1.zhang@intel.com>
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

From: "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>

Driver gets the art time from get_art() function for PSE TGPIO crosststamp.
Counttstamp implementation for PSE TGPIO.

Signed-off-by: D, Lakshmi Sowjanya <lakshmi.sowjanya.d@intel.com>
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 arch/x86/include/asm/tsc.h |  2 ++
 arch/x86/kernel/tsc.c      | 52 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 721caa09a14d..a480a76b47c3 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -32,6 +32,8 @@ extern struct system_counterval_t convert_art_to_tsc(u64 art);
 extern struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns);
 extern struct timespec64 get_tsc_ns_now(struct system_counterval_t
 					*system_counter);
+extern int convert_tsc_to_art(const struct system_counterval_t *tsc, u64 *art);
+extern u64 read_art(void);
 extern u64 convert_tsc_ns_to_art(struct timespec64 *tsc_ns);
 extern u64 convert_tsc_ns_to_art_duration(struct timespec64 *tsc_ns);
 extern struct timespec64 convert_art_to_tsc_ns(u64 art);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index c4b48323c4bf..0afbdbf5d394 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1257,6 +1257,58 @@ int unsynchronized_tsc(void)
 	return 0;
 }
 
+/**
+ * convert_tsc_to_art() - Returns ART value associated with system counter
+ *
+ * Converts input TSC to the corresponding ART value using conversion
+ * factors discovered by detect_art()
+ *
+ * Return:
+ * u64 ART value
+ */
+int convert_tsc_to_art(
+        const struct system_counterval_t *system_counter, u64 *art)
+{
+	u64 tmp, res, rem;
+
+	if (system_counter->cs != art_related_clocksource)
+		return -EINVAL;
+
+	res = system_counter->cycles - art_to_tsc_offset;
+	rem = do_div(res, art_to_tsc_numerator);
+
+	*art = res * art_to_tsc_denominator;
+	tmp = rem * art_to_tsc_denominator;
+
+	do_div(tmp, art_to_tsc_numerator);
+	*art += tmp;
+
+	return 0;
+}
+EXPORT_SYMBOL(convert_tsc_to_art);
+
+/**
+ * read_art() - Returns current ART value
+ *
+ * Converts the current TSC to the current ART value using conversion
+ * factors discovered by detect_art()
+ *
+ * Return:
+ * u64 ART value
+ */
+u64 read_art(void)
+{
+	struct system_counterval_t tsc;
+	u64 art = 0;
+
+	tsc.cs = art_related_clocksource;
+	tsc.cycles = read_tsc(NULL);
+	convert_tsc_to_art(&tsc, &art);
+
+	return art;
+}
+EXPORT_SYMBOL(read_art);
+
 /*
  * Convert ART to TSC given numerator/denominator found in detect_art()
  */
-- 
2.25.1


