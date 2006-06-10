Message-ID: <448AF791.8080707@domain.hid>
Date: Sat, 10 Jun 2006 19:47:13 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030309030606070404010307"
Subject: [Xenomai-core] [PATCH] Add fptest for powerpc
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------030309030606070404010307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This adds powerpc version of fptest.h. It just stores and loads the raw 
integer into/from FPU registers without converting to proper IEEE form. 
Converting would have added unneccessary complexity. As a side note, the 
ppc barfs on the test with "1000 != 10". :I

-- hl

--------------030309030606070404010307
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
	name="xenomai-060610-ppc-fptest.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-060610-ppc-fptest.patch"

diff -Nru xenomai.orig/include/asm-powerpc/fptest.h xenomai/include/asm-powerpc/fptest.h
--- xenomai.orig/include/asm-powerpc/fptest.h	2006-06-10 10:29:29.335736000 +0000
+++ xenomai/include/asm-powerpc/fptest.h	2006-06-10 16:12:09.395132000 +0000
@@ -10,11 +10,94 @@
 
 static inline void fp_regs_set(unsigned val)
 {
+	uint64_t fpval = val;
+	__asm__ __volatile__("lfd	0, %0\n"
+		"	fmr	1, 0\n"
+		"	fmr	2, 0\n"
+		"	fmr	3, 0\n"
+		"	fmr	4, 0\n"
+		"	fmr	5, 0\n"
+		"	fmr	6, 0\n"
+		"	fmr	7, 0\n"
+		"	fmr	8, 0\n"
+		"	fmr	9, 0\n"
+		"	fmr	10, 0\n"
+		"	fmr	11, 0\n"
+		"	fmr	12, 0\n"
+		"	fmr	13, 0\n"
+		"	fmr	14, 0\n"
+		"	fmr	15, 0\n"
+		"	fmr	16, 0\n"
+		"	fmr	17, 0\n"
+		"	fmr	18, 0\n"
+		"	fmr	19, 0\n"
+		"	fmr	20, 0\n"
+		"	fmr	21, 0\n"
+		"	fmr	22, 0\n"
+		"	fmr	23, 0\n"
+		"	fmr	24, 0\n"
+		"	fmr	25, 0\n"
+		"	fmr	26, 0\n"
+		"	fmr	27, 0\n"
+		"	fmr	28, 0\n"
+		"	fmr	29, 0\n"
+		"	fmr	30, 0\n"
+		"	fmr	31, 0\n"
+		: 
+		: "m" (fpval));
 }
 
+#define FPTEST_REGVAL(n) {						\
+	uint64_t t;							\
+	__asm__ __volatile__("	stfd	" #n ", %0" : "=m" (t));	\
+	e[n] = (unsigned)t;						\
+	}
+
 static inline int fp_regs_check(unsigned val)
 {
-    return 0;
+	unsigned i, failed = 0;
+	uint32_t e[32];
+
+	FPTEST_REGVAL(0);
+	FPTEST_REGVAL(1);
+	FPTEST_REGVAL(2);
+	FPTEST_REGVAL(3);
+	FPTEST_REGVAL(4);
+	FPTEST_REGVAL(5);
+	FPTEST_REGVAL(6);
+	FPTEST_REGVAL(7);
+	FPTEST_REGVAL(8);
+	FPTEST_REGVAL(9);
+	FPTEST_REGVAL(10);
+	FPTEST_REGVAL(11);
+	FPTEST_REGVAL(12);
+	FPTEST_REGVAL(13);
+	FPTEST_REGVAL(14);
+	FPTEST_REGVAL(15);
+	FPTEST_REGVAL(16);
+	FPTEST_REGVAL(17);
+	FPTEST_REGVAL(18);
+	FPTEST_REGVAL(19);
+	FPTEST_REGVAL(20);
+	FPTEST_REGVAL(21);
+	FPTEST_REGVAL(22);
+	FPTEST_REGVAL(23);
+	FPTEST_REGVAL(24);
+	FPTEST_REGVAL(25);
+	FPTEST_REGVAL(26);
+	FPTEST_REGVAL(27);
+	FPTEST_REGVAL(28);
+	FPTEST_REGVAL(29);
+	FPTEST_REGVAL(30);
+	FPTEST_REGVAL(31);
+
+	for (i = 0; i < 32; i++)
+		if (e[i] != val) {
+			printk("r%d: %u != %u\n", i, e[i], val);
+			failed = 1;
+		}
+
+	return failed;
 }
 
 #endif /* FPTEST_H */

--------------030309030606070404010307--

