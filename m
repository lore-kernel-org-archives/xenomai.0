From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OkI7tdBFsI"
Content-Transfer-Encoding: 7bit
Message-ID: <17641.49824.304831.889667@domain.hid>
Date: Mon, 21 Aug 2006 16:26:40 +0200
Subject: Re: [Xenomai-help] Oops on PPC405EP
In-Reply-To: <44E9BA20.4000607@domain.hid>
References: <44E9B5A1.3010102@domain.hid>
	<44E9BA20.4000607@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org


--OkI7tdBFsI
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Heikki Lindholm wrote:
 > Since your hardware AFAIK does not have an FPU, shouldn't you be 
 > compiling Xenomai without hardware FPU support?

Maybe we could prevent this mistake in Kconfig ?

-- 


					    Gilles Chanteperdrix.

--OkI7tdBFsI
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-hw-fpu-depends-on-ppc-fpu.patch"
Content-Transfer-Encoding: 7bit

Index: ksrc/arch/powerpc/Kconfig
===================================================================
--- ksrc/arch/powerpc/Kconfig	(revision 1484)
+++ ksrc/arch/powerpc/Kconfig	(working copy)
@@ -6,6 +6,7 @@
 
 config XENO_HW_FPU
 	bool "Enable FPU support"
+	depends on PPC_FPU
 	default y
 	help
 	The FPU executes instructions from the processor's normal

--OkI7tdBFsI--

