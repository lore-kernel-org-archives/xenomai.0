From: Nikolaj Fogh <nf@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 07 Jan 2009 11:49:52 +0000
Message-Id: <1231328992.7413.3.camel@domain.hid>
Mime-Version: 1.0
Subject: [Xenomai-help] Blackfin serial port in Xenomai
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

Hi,

I am trying to interface with a serial port on a bluetechnics cm-bf537e
board (a blackfin chip). However, it seems that the serial port in the
blackfin is not compatible with a 8250 chip, so I cannot get the xenomai
rtdm serial driver working. Has anyone got a driver for the blackfin
serial port for hard real time.

Right now, I am just printf'ing to a serial console to print data. I
would like to avoid that.

Thanks
  - Nikolaj Fogh

