Date: Tue, 21 Dec 2010 10:03:55 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
Message-ID: <alpine.DEB.1.10.1012210952150.8962@domain.hid>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463809534-145142294-1292922235=:8962"
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: [Xenomai-help] 2.5.3++ on Blackfin: Irritating warning
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai GNA <xenomai@xenomai.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809534-145142294-1292922235=:8962
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII

Hi,

I'm in the process of upgrading my Blackfin uclinux dist base from 2009R1.1 to 2010R1. This also includes a kernel and Xenomai upgrade.

The kernel is now 2.6.34 with I-pipe 1.14.02. With Xenomai 2.5.3, my application told me "Xenomai: User-space support anterior to 2.5.2 detected" on startup. I looked into newer Xenomai and found that there might have been related code changes, so I tried 2.5.5.2 (and also upgraded to I-pipe 1.15-01, but that doesn't seem to make a difference).

Now with 2.5.5.2, the warning when starting the application is gone, but I still get one when killing the application using SIGINT for the first time. The attached small example allows me to reliably reproduce the problem (please inform me if attachment didn't get through, it's only 30 lines).

When starting it after system reboot and then killing it with Ctrl-C after a few seconds, the warning is printed:

/ # /tmp/try
press ctrl-c to stop
press ctrl-c to stop
press ctrl-c to stop
^CXenomai: User-space support anterior to 2.5.2 detected, may corrupt memory upon
thread termination. Upgrade is recommended
/ #

The warning doesn't appear when starting and killing "try" a the second time.

I also experience some other problems with debugging, console output duplication and (probably) memory fragmentation, maybe they're related but I have not been able to reproduce them with a small example yet.

Thanks in advance for any hints in advance!
Kolja
---1463809534-145142294-1292922235=:8962
Content-Type: TEXT/x-csrc; name=try.c
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.1.10.1012211003530.8962@domain.hid>
Content-Description: 
Content-Disposition: attachment; filename=try.c

LyogQ29tcGlsZSB3aXRoIGdjYy00LjMuNSAoQmxhY2tmaW4gdG9vbGNoYWlu
IDIwMTBSMS1SQzQpDQoNCiAgIGJmaW4tbGludXgtdWNsaWJjLWdjYyBcDQog
ICAgICAtSS9vcHQvdUNsaW51eC9ibGFja2Zpbi1saW51eC1kaXN0L3N0YWdp
bmcvdXNyL2luY2x1ZGUgXA0KICAgICAgLWcgLURfR05VX1NPVVJDRSAtRF9S
RUVOVFJBTlQgLURfX1hFTk9fXyAtbyB0cnkuZ2RiIHRyeS5jIFwNCiAgICAg
IC1ML29wdC91Q2xpbnV4L2JsYWNrZmluLWxpbnV4LWRpc3Qvc3RhZ2luZy91
c3IvbGliIC1seGVub21haSAtbG5hdGl2ZSAtbHB0aHJlYWQgLWxydA0KDQog
Ki8NCg0KI2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8dW5pc3RkLmg+
DQojaW5jbHVkZSA8c2lnbmFsLmg+DQojaW5jbHVkZSA8c3lzL21tYW4uaD4N
CiNpbmNsdWRlIDxuYXRpdmUvdGFzay5oPg0KDQpzdGF0aWMgaW50IHF1aXQ7
DQoNCnZvaWQgc2lnaGFuZGxlcihpbnQgc2lnKQ0Kew0KICAgIHF1aXQrKzsN
Cn0NCg0KaW50IG1haW4gKCkNCnsNCiAgICBxdWl0ID0gMDsNCiAgICBzaWdu
YWwoU0lHSU5ULCBzaWdoYW5kbGVyKTsNCg0KICAgIGludCByOw0KICAgIFJU
X1RBU0sgbWFpbnRhc2s7DQogICAgbWxvY2thbGwoTUNMX0NVUlJFTlR8TUNM
X0ZVVFVSRSk7DQogICAgciA9IHJ0X3Rhc2tfc2hhZG93KCZtYWludGFzaywg
Im1haW50YXNrIiwgMywgMCk7DQoNCiAgICB3aGlsZSAocXVpdD09MCkNCiAg
ICB7DQogICAgICAgIHByaW50ZigicHJlc3MgY3RybC1jIHRvIHN0b3BcbiIp
Ow0KICAgICAgICBzbGVlcCgxKTsNCiAgICB9DQoNCiAgICByZXR1cm4gcjsN
Cn0NCg==

---1463809534-145142294-1292922235=:8962--

