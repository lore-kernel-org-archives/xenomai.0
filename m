Message-ID: <45D2DD6C.9010005@domain.hid>
Date: Wed, 14 Feb 2007 10:59:08 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CONFIG_PREEMPT & irqbench
References: <45D25145.3000407@domain.hid>
	<45D2CE27.5040303@domain.hid> <45D2CF9E.40308@domain.hid>
In-Reply-To: <45D2CF9E.40308@domain.hid>
Content-Type: multipart/mixed; boundary="------------000102030607000303050103"
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-help@domain.hid

This is a multi-part message in MIME format.
--------------000102030607000303050103
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

> Hmm, I should have better said "tiny". This experience is based on
> I-pipe tracer observations, and I guess you don't have that thing on,
> have you?

I have set:

---snip---
# CONFIG_IPIPE_DEBUG is not set
CONFIG_IPIPE_TRACE_ENABLE_VALUE=0
---snap---

in both kernels (either with preempt or without).

> How much is the difference? How long did you measure to exclude noise.

The difference is about 1 us (in average and worst case) when running
irqloop in IRQ handler mode.

I have been running the measurements for 1 minute under heavy load with
an interrupt frequency of 1 ms. This gives 60000 samples. Is this too
less in order to exclude noise?


Regards,
Markus Franke

--------------000102030607000303050103
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


--------------000102030607000303050103--

