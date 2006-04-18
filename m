Date: Tue, 18 Apr 2006 13:14:28 +0200
From: Bernhard Walle <bernhard.walle@domain.hid>
Message-ID: <20060418131428.31f735e9@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Adeos-main] CONFIG_PREEMPT doesn't work with ADEOS
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

Hello,

I have a kernel 2.6.15.6 with
http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.15-i386-1.2-03.patch
patch. In this configuration, CONFIG_PREEMPT doesn't work any more,
i.e. the kernel is not preempted.

With the kernel without ADEOS patch, it works fine. A test program is
at http://www.bwalle.de/temp/kern-preempt.tar.bz2.

Do you know what's wrong?


Regards,
  Bernhard
-- 
Bei der Eroberung des Weltraums sind zwei Probleme zu lösen: die
Schwerkraft und der Papierkrieg. Mit der Schwerkraft wären wir fertig
geworden. -- Wernher von Braun

