Message-ID: <45EC5946.9030508@domain.hid>
Date: Mon, 05 Mar 2007 18:54:14 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_pipe_write() returns -ENOMEM
References: <45EC4111.6070104@domain.hid>
	<45EC428E.5060306@domain.hid>
	<45EC4AF4.7000808@domain.hid>
	<45EC4F8E.905@domain.hid>
In-Reply-To: <45EC4F8E.905@domain.hid>
Content-Type: multipart/mixed; boundary="------------080605080302010909030905"
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
--------------080605080302010909030905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

OK. And if there is an overflow is there anything I can do during
runtime, e.g. just to overwrite the data in the queue?

Regards,
Markus Franke

Gilles Chanteperdrix wrote:
> Markus Franke wrote:
> 
>>what happens if rt_pipe_write() returns
>>-ENOMEM? Does the data to be written simply get lost or is it simply
>>enqeued at the end and the first element in the pipe get's lost?
>>
> 
> 
> No, the rt_pipe_write which returns an error fails.
> 

-- 
Nichts ist so praktisch wie eine gute Theorie!

--------------080605080302010909030905
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


--------------080605080302010909030905--

