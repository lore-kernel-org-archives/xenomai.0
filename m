From: Patrick <kpa_info@domain.hid>
Content-Type: text/plain
Date: Thu, 14 May 2009 21:44:41 +0200
Message-Id: <1242330281.3919.12.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai standalone
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hello all,

I would like to know if it's possible to simply "separate" Xenomai
(nucleus) from Linux and adeos ? My goal is to have a simple RTOS based
on Xenomai (only native skin in kernel space).

I have done a quick look at the source and it's seems ok to remove adeos
by editing hal. About linux, Xenomai seems to need only MM, timer, and
some part of irq management. Is that right ?

So do you think that it would be possible to run Xenomai nucleus as a
standalone RTOS ?

Thanks in advance for any help

Patrick



