Message-ID: <45D0E411.4010807@domain.hid>
Date: Mon, 12 Feb 2007 23:02:57 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070006010107000202080304"
Subject: [Xenomai-help] interrupt latencies (irqloop/irqbench)
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
--------------070006010107000202080304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dear all,

I am doing some latency benchmarks with irqbench/irqloop.
Everything works fine with irqloop in testmode (1=user, 2=kernel and
3=irq handler) But when trying to start with testmode 4=hard IRQ
handler, I get the following message:

---snip---
irqloop: error starting test: Resource temporarily unavailable
---snap---

This occurs somewhere when calling:

	ioctl(benchdev, RTTST_RTIOC_IRQBENCH_START, &config)

Any quick suggestions how to solve this problem?
By the way: I read already the provided document in "txt" folder.


Thanks in advance,

Markus Franke

--------------070006010107000202080304
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


--------------070006010107000202080304--

