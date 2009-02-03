Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 3 Feb 2009 17:40:49 -0000
Message-ID: <4B3F8896E1733D4787DDB0EA1C7FF91F6B58D5@domain.hid>
From: "Mike McTernan" <mmcternan@domain.hid>
Subject: [Xenomai-help] IRQ reservation and config
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

I'm porting a simple driver to be under the Xenomai. RTDM  The driver
simply blocks on read calls until an interrupt arrives, and returns a
count.  This is on Blackfin uClinux.

I think I've understood how to make the driver, the only thing I'm
missing is how to reserve and configure the irq source.=20

Should I be using the standard Linux request_irq() to do this in the
RTDM prior to calling rtdm_irq_request()?

Regards,

Mike

