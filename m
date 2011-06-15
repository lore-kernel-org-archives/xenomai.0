From: Christian Kapeller <christian.kapeller@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 15 Jun 2011 14:02:00 +0200
Message-ID: <1308139320.2568.7.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] unexpected rt_task_sleep behaviour
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

Hi,

I am using a KARO TX-51 board (imx 515) running linux 2.6.31.12 + karo
supplied bsp patches. Xenomai is at version 2.5.6

In a userspace task i create an interrupt, and want to wait for 1 to 14
ms. If I supply any non zero delay to rt_task_sleep, I get a delay of
830 ms (measured on scope) no matter what delay argument i use.

It seems something got wrong with the adeos patch. I also experience
that the serial console is quite laggy.

 Can anyone give me some pointers where to start investigating this
matter?

Regards,
Christian


