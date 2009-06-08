MIME-Version: 1.0
Date: Mon, 8 Jun 2009 13:15:01 -0400
Message-ID: <8bd0f97a0906081015k59a49a1dre38622401f011362@domain.hid>
From: Mike Frysinger <vapier.adi@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] irq hooking and irqflags
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

i just finished converting Blackfin to the new irqflags.h system which
included punting pretty much all of the irq.h guts (including IPIPE).
since irqflags.h is directly designed for hooking the lower irq stuff,
do we still need this stuff patched into the Blackfin code ?  seems
like patching linux/irqflags.h would get you support for pretty much
all arches for free ...
-mike

