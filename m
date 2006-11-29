Message-ID: <456D7198.9030406@domain.hid>
Date: Wed, 29 Nov 2006 12:40:08 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] measuring context switch primary<->secondary mode
References: <456D5075.1060905@domain.hid>
	<456D58E7.7030807@domain.hid>
In-Reply-To: <456D58E7.7030807@domain.hid>
Content-Type: multipart/mixed; boundary="------------020509010706070608070407"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------020509010706070608070407
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> You will observe some differences only if you put some load on your
> system. The usual way of putting some load on your system is to use dd
> or the cache calibrator. See TROUBLESHOOTING.
> 

Thanks for the hint but the values for the CONFIG_PREEMPT case are still
at least 5% above the non-CONFIG_PREEMPT values. I did several testruns
and the result were reobservable. How much improvments with additional
fine granular Kernel Preemptability can one expect?

Thanks in advance,
Markus Franke

--------------020509010706070608070407
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


--------------020509010706070608070407--

