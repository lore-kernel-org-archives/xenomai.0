MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EtdrheZbAp"
Content-Transfer-Encoding: 7bit
Message-ID: <17614.15855.660608.773754@domain.hid>
Date: Mon, 31 Jul 2006 19:29:19 +0200
Subject: Re: [Xenomai-core] [PATCH] detect conflict with INPUT_PCSPKR
In-Reply-To: <44CE350F.5060303@domain.hid>
References: <44CB2884.80801@domain.hid>
	<17611.36969.814874.846387@domain.hid>
	<17611.37633.881446.443324@domain.hid>
	<44CC5D59.3080405@domain.hid>
	<17614.12685.956714.372133@domain.hid>
	<44CE350F.5060303@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
Cc: xenomai-core <xenomai@xenomai.org>


--EtdrheZbAp
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Jan Kiszka wrote:
 > >  > No problem, but only when combining with a
 > >  > 
 > >  > comment "Switch off CONFIG_INPUT_PCSPKR to use Xenomai" (or so)
 > >  > 	depends on !X86_TSC && X86 && INPUT_PCSPKR
 > >  > 
 > >  > Otherwise the user will be left alone here with a non-selectable Xenomai
 > >  > option...
 > >  > 
 > >  > This actually remind me of my suggestion some months ago to add Kconfig
 > >  > warnings for CONFIG_CPU_FREQ & friends. Might be a good chance to catch
 > >  > this all. Is scripts/Kconfig.frag the preferred place to add it?
 > > 
 > > 
 > > Why not? Here is a second patch that follows your suggestions.
 > 
 > No objections! Looks good to me. But shouldn't we add APM as well?

With APM, as well as with warnings for 2.4.

-- 


					    Gilles Chanteperdrix.

--EtdrheZbAp
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-kconfig-warnings.diff"
Content-Transfer-Encoding: 7bit

Index: scripts/Kconfig.frag
===================================================================
--- scripts/Kconfig.frag	(revision 1402)
+++ scripts/Kconfig.frag	(working copy)
@@ -1,7 +1,20 @@
 
 menu "Real-time sub-system"
 
+comment "WARNING! You enabled APM, CPU Frequency scaling or use of ACPI"
+	depends on APM || CPU_FREQ || ACPI_PROCESSOR
+comment "processor C states as idle handler (ACPI 'processor' option)."
+	depends on APM || CPU_FREQ || ACPI_PROCESSOR
+comment "These options are known to cause troubles with Xenomai."
+	depends on APM || CPU_FREQ || ACPI_PROCESSOR
+
+comment "NOTE: Xenomai conflicts with PC speaker support."
+	depends on !X86_TSC && X86 && INPUT_PCSPKR
+comment "(menu Device Drivers/Input device support/Miscellaneous devices)"
+	depends on !X86_TSC && X86 && INPUT_PCSPKR
+
 config XENOMAI
+	depends on X86_TSC || !X86 || !INPUT_PCSPKR
 	bool "Xenomai"
 	default y
         select IPIPE
Index: ksrc/arch/i386/Config.in
===================================================================
--- ksrc/arch/i386/Config.in	(revision 1402)
+++ ksrc/arch/i386/Config.in	(working copy)
@@ -1,6 +1,12 @@
 mainmenu_option next_comment
 comment 'Real-time sub-system'
 
+if [ "$CONFIG_APM" != "n" -o "$CONFIG_APM_CPU_IDLE" != "n" -o "$CONFIG_APM_DISPLAY_BLANK" != "n" -o "$CONFIG_ACPI_PROCESSOR" != "n" ]; then
+    comment "WARNING! You enabled APM or use of ACPI processor C states as"
+    comment "idle handler (ACPI 'processor' option)."
+    comment "These options are known to cause troubles with Xenomai"
+fi
+
 if [ "$CONFIG_IPIPE" = "n" ]; then
     comment "Xenomai depends on Adeos interrupt pipeline"
 else

--EtdrheZbAp--

