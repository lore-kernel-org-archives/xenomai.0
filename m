Message-ID: <45D0155A.70805@domain.hid>
Date: Mon, 12 Feb 2007 08:20:58 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Make error
References: <e45fe62b0702112124r71b9e03fv8413028178857a57@domain.hid>
In-Reply-To: <e45fe62b0702112124r71b9e03fv8413028178857a57@domain.hid>
Content-Type: multipart/mixed; boundary="------------030109090603080409020706"
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
--------------030109090603080409020706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Preetam Joshi wrote:
> But i get the error as /usr/bin/ld: cannot find -lnative
> collect2: ld returned 1 exit status
> 
> How do i resolve this error.

You should maybe add something like "-L<PATH_TO_XENOMAI>/lib" to your
LDFLAGS in the Makefile. The problem is that "libnative.a" is not found
during linking process.

Regards,
Markus


--------------030109090603080409020706
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


--------------030109090603080409020706--

