Message-ID: <4400F7B1.6050408@domain.hid>
Date: Sun, 26 Feb 2006 01:34:57 +0100
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] "top" doesn't start ?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi all!

I just recognized that "top" doesn't start if the
RTDM demo
http://www.captain.at/xenomai-real-time-driver-example.php
runs.

=> "user" runs, "top" is started:
"top" doesn't start as long as "user" is running.

When "user" is terminated, "top" displays the ncurses screen.

xeno-2.1-rc3
K2.6.15

Anyone got an idea ?

Thanks & best regards,
Hannes.


