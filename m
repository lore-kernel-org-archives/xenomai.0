From: Thomas Kuhlmann <maillist@domain.hid>
Date: Wed, 30 Jun 2004 11:13:48 +0200
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406301113.48282.maillist@domain.hid>
Subject: [Adeos-main] Adeos testprogram "adtest" does not test all features
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos-main@gna.org

Hello

I just compiled my first Adeos-patched kernel for armnommu/arch-netarm and 
tried the test module: adtest.c

However adtest.c only catches the timer interrupts, counts them and propagates 
the interrupt to linux.

It would be nice to check, if adtest is able to catch interrupts which are 
disabled by the linux kernel (the timer interrupt isn't disabled by linux).

has anyone an idea which interrupt to test, or even an extended version of 
adtest.c ?

btw: adtest.c refers to "adsysinfo_t.timer.irq" which is not available in 
adeos-linux-2.4.22-armnommu-r12.patch, its called "adsysinfo_t.archdep.tmirq" 
there.

Thanks, Thomas.

