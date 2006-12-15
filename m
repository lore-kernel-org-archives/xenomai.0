Message-ID: <4582D4D0.3060404@domain.hid>
Date: Fri, 15 Dec 2006 18:01:04 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090008000708070106050508"
Subject: [Xenomai-help] measuring external interrupt latency
Reply-To: Markus.Franke@domain.hid
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

This is a multi-part message in MIME format.
--------------090008000708070106050508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dear Xenomai users/developers,

I want to measure external interrupt latencies. Therefore, I have a
parallel port loopback connector (25 pins). Pin 9 (D7) and Pin 10 (ACK)
are connected. I would like to trigger an interrupt via Pin 9 and
measure the time till the ISR is entered.

Can somebody give me a hint how to start writing such an application. I
read something about RTDM and I also had a look on the IRQ-Loop
testsuite. I am wondering whether I can reuse some of this code which is
written there. Besides, is it really necessary to use the RTDM framework?

Sorry, but I am really new to Xenomai. I just want to have some small
hints how to start developing.


Thanks in advance,

Markus Franke

--------------090008000708070106050508
Content-Type: text/x-vcard; charset=utf-8;
 name="Markus.Franke.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Markus.Franke.vcf"

begin:vcard
fn:Markus Franke
n:Franke;Markus
adr;quoted-printable:;;Vettersstra=C3=9Fe 64/722;Chemnitz;Saxony;09126;Germany
email;internet:Markus.Franke@domain.hid
x-mozilla-html:FALSE
url:http://www.tu-chemnitz.de/~franm
version:2.1
end:vcard


--------------090008000708070106050508--

