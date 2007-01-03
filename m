Message-ID: <459C13C5.9010007@domain.hid>
Date: Wed, 03 Jan 2007 21:36:21 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] parallelport module for measuring
	external	interrupt latency
References: <459B6DAD.4030406@domain.hid>	<459B7C6C.9030401@domain.hid>
	<459B8382.7060508@domain.hid>
	<459B8A19.2060809@domain.hid>
In-Reply-To: <459B8A19.2060809@domain.hid>
Content-Type: multipart/mixed; boundary="------------070704010807050905070601"
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
--------------070704010807050905070601
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> 
> Even if the notification is not time-critical, you first have to get out
> of the Xenomai context in a sane manner. rtdm_nrtsig may help if you
> don't want to use the RT scheduler for user task wakeup.

OK. Thank you for the hint with rtdm_nrtsig_*. The kernel-module works now.

But I have still a problem when generating interrupts with a high
frequency, let's say 100us. Then I get large latencies in the range of
1,5 seconds. Can you see any reason for this. An intervall of 1ms works
without any problems and the latencies reach maybe 13us in worst case.

Thanks in advance,
Markus Franke

--------------070704010807050905070601
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


--------------070704010807050905070601--

