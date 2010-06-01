MIME-Version: 1.0
Date: Tue, 1 Jun 2010 09:45:32 +0800
Message-ID: <AANLkTimu2exL1jW_LoGtrQxStjGwLb5C5PvSGJOtSZPP@mail.gmail.com>
From: Everett Wang <everteq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] IRQ programming
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

Hi All,

I want to us an x86 machine to program IRQ from an externel signal
(GPS). The GPS device can send
a square pulse from precision timer. But I am not sure where this
signal should be connected to so an IRQ can be
generated. I googled this topics a little bit and found that parallel
port can be used. Since most embedded
X86 board now doesn't have any parallel port, I wonder if we have a
better way to sensor the signal? Can
I route the GPS pulse signal to serial port to generate IRQ? or use
GPIO that some of the boards have?

Any suggestions are welcome,

Everett

