Message-ID: <4E09D058.10906@domain.hid>
Date: Tue, 28 Jun 2011 15:00:08 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Xenomai 2.6.5 with Linux 2.6.38.8 kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

is the Xenomai 2.6.5 supposed to work with Linux 2.6.38.8 kernel and
adeos patch 2.6.38.8-x86-2.10 supposed to work?

The above combination gives me an error compiling
arch/x86/xenomai/hal_32.c in function rthal_arch_init where nmi_watchdog
and NMI_IO_APIC are not defined. Indeed those are not defined anywhere
in the kernel or xenomai source tree.

Thank you. Cheers,
-- 
Daniele

