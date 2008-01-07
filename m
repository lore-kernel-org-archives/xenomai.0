Message-ID: <4781F1A1.8070004@domain.hid>
Date: Mon, 07 Jan 2008 10:32:17 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080604030907030907010404"
Subject: [Xenomai-core] [PATCH] extend HPET-disabled requirement
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai-core@domain.hid

This is a multi-part message in MIME format.
--------------080604030907030907010404
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

As this thread [1] demonstrated, there is another nasty corner-case
where enabled CONFIG_HPET_TIMER bites us. The attached patch aims at
catching this case as well.

Jan

[1] https://mail.gna.org/public/xenomai-help/2008-01/msg00009.html

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------080604030907030907010404
Content-Type: text/x-patch;
 name="extend-hpet-dependency.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="extend-hpet-dependency.patch"

---
 scripts/Kconfig.frag |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: xenomai/scripts/Kconfig.frag
===================================================================
--- xenomai.orig/scripts/Kconfig.frag
+++ xenomai/scripts/Kconfig.frag
@@ -12,12 +12,12 @@ comment "(menu Device Drivers/Input devi
 	depends on !X86_TSC && X86 && INPUT_PCSPKR
 
 comment "NOTE: Xenomai needs either X86_LOCAL_APIC enabled or HPET_TIMER disabled."
-	depends on !X86_LOCAL_APIC && X86 && HPET_TIMER
+	depends on (!X86_LOCAL_APIC || !X86_TSC) && X86 && HPET_TIMER
 comment "(menu Processor type and features)"
-	depends on !X86_LOCAL_APIC && X86 && HPET_TIMER
+	depends on (!X86_LOCAL_APIC || !X86_TSC) && X86 && HPET_TIMER
 
 config XENOMAI
-	depends on ((X86_TSC || !X86 || !INPUT_PCSPKR) && (!HPET_TIMER || !X86 || X86_LOCAL_APIC))
+	depends on ((X86_TSC || !X86 || !INPUT_PCSPKR) && (!HPET_TIMER || !X86 || (X86_LOCAL_APIC && X86_TSC)))
 	bool "Xenomai"
 	default y
         select IPIPE

--------------080604030907030907010404--

