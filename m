Message-ID: <45D0F1E2.3020201@domain.hid>
Date: Tue, 13 Feb 2007 00:01:54 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] interrupt latencies (irqloop/irqbench)
References: <45D0E411.4010807@domain.hid>
	<45D0EDBC.5020402@domain.hid>
In-Reply-To: <45D0EDBC.5020402@domain.hid>
Content-Type: multipart/mixed; boundary="------------020805030901090603050400"
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
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

This is a multi-part message in MIME format.
--------------020805030901090603050400
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> This test mode exploits the I-pipe support for multiple domains
> intensively. 

I know....I read the nice txt-document :-)

> By default, Xenomai is configured to be the topmost domain
> and is optimised for this use case. But it can also be "second-best" and
> let someone else be first in the interrupt pipeline - e.g. xeno_irqloop.
> To achieve this, switch off CONFIG_XENO_OPT_PIPELINE_HEAD (nucleus
> option) and retry the test.

Ok I understand. It would be good if such a hint would be in this txt-file.

> Then there is a bug - in the doc. :)

Why? The above information is simply missing. :-)

Regards,
Markus

--------------020805030901090603050400
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


--------------020805030901090603050400--

