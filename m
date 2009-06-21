Message-ID: <4A3E9E09.7060109@domain.hid>
Date: Sun, 21 Jun 2009 22:54:33 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] kernel build fails with CONFIG_X86_MCE_P4THERMAL=y
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

hi,

if 'check for P4 thermal throttling interrupt.' ( 
CONFIG_X86_MCE_P4THERMAL ) is enabled, kernel builds ok with 2.6.28, but 
fails with adeos-ipipe-2.6.29.5-x86-2.4-02.patch:

arch/x86/kernel/ipipe.c: In function ‘__ipipe_enable_pipeline’:
arch/x86/kernel/ipipe.c:210: error: ‘smp_thermal_interrupt’ undeclared 
(first use in this function)
arch/x86/kernel/ipipe.c:210: error: (Each undeclared identifier is 
reported only once
arch/x86/kernel/ipipe.c:210: error: for each function it appears in.)
make[3]: *** [arch/x86/kernel/ipipe.o] Fehler 1
make[2]: *** [arch/x86/kernel] Fehler 2


