Message-ID: <479F2825.4000405@domain.hid>
Date: Tue, 29 Jan 2008 14:20:37 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090101000209020405090202"
Subject: [Xenomai-core] [PATCH] bug in xnintr_irq_proc()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------090101000209020405090202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

attached is a fix for a nice bug in xnintr_irq_proc() of Xenomai v2.3.x.
Check for tabs. I have not checked if it's present in recent versions as
well.

Wolfgang.

--------------090101000209020405090202
Content-Type: text/x-patch;
 name="xenomai-2.3.x-irq-proc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-2.3.x-irq-proc.patch"

Index: ksrc/nucleus/intr.c
===================================================================
--- ksrc/nucleus/intr.c	(revision 3441)
+++ ksrc/nucleus/intr.c	(working copy)
@@ -836,7 +836,7 @@ int xnintr_irq_proc(unsigned int irq, ch
 #if defined(CONFIG_XENO_OPT_SHIRQ_LEVEL) || defined(CONFIG_XENO_OPT_SHIRQ_EDGE)
 	intr = xnirqs[irq].handlers;
 	if (intr) {
-		strcpy(p, "	   "); p += 8;
+		strcpy(p, "	   "); p += 4;
 
 		do {
 			*p = ' '; p += 1;
@@ -848,7 +848,7 @@ int xnintr_irq_proc(unsigned int irq, ch
 #else /* !CONFIG_XENO_OPT_SHIRQ_LEVEL && !CONFIG_XENO_OPT_SHIRQ_EDGE */
 	intr = rthal_irq_cookie(&rthal_domain, irq);
 	if (intr) {
-		strcpy(p, "	    "); p += 9;
+		strcpy(p, "	    "); p += 5;
 		strcpy(p, intr->name); p += strlen(intr->name);
 	}
 #endif /* CONFIG_XENO_OPT_SHIRQ_LEVEL || CONFIG_XENO_OPT_SHIRQ_EDGE */

--------------090101000209020405090202--

