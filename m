Message-ID: <45E2FAB3.2000305@domain.hid>
Date: Mon, 26 Feb 2007 16:20:19 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Scheduling of different domains in Adeos
References: <45E15BC1.2000303@domain.hid>
	<45E161AA.9070005@domain.hid>
In-Reply-To: <45E161AA.9070005@domain.hid>
Content-Type: multipart/mixed; boundary="------------010601080804010803080402"
Reply-To: Markus.Franke@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org

This is a multi-part message in MIME format.
--------------010601080804010803080402
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Scheduling takes place only based on the domain priority, each time a
> new asynchronous event (interrupt) arrives or a domain reports to be
> idle. There is no explicit source file or function called "scheduler",
> you will find its logic in the dispatching code of pipelined interrupts
> and in ipipe_suspend_domain().

As far as I understood, it is possible to run more than operating system
on top of Adeos, at a time. Adeos is said to be a resource
virtualization layer and the CPU is also a resource, which has to be
shared. But if there are more than one operating system, who decides
which one get's the CPU?
The question is out of scope of the interrupt virtualization. It's just
a question about CPU virtualization.

Please correct me if I missunderstood something totally. :-)


Regards,
Markus Franke

--------------010601080804010803080402
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


--------------010601080804010803080402--

