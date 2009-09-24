MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Date: Thu, 24 Sep 2009 09:39:03 -0400
Message-ID: <1253799543.12598.26.camel@domain.hid>
From: "Andreas Glatz" <AndreasGlatz@domain.hid>
Subject: [Xenomai-help] Q about registering for an interrupt on MPC8360e
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hi,

Currently, we are trying to register for IRQ1-7=20
of our MPC8360e.

We found that we have to do the following steps to=20
get interrupts working:

1) irq_of_parse_and_map(): To get and map the hardware interrupt
2) request_irq(): Installs a dummy handler
3) rt_intr_create(): Installs the real ISR

The application is running in user-space. 1) and 2) are=20
called from and ioctl(). 3) is called directly from the=20
user-space Xenomai application.

Is request_irq() required? IMHO it shouldn't be, right?

Andreas


Xenomai: 2.4.9
Ipipe: 2.7
Kernel: 2.6.30


