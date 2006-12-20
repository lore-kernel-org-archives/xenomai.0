Message-ID: <458915DB.80909@domain.hid>
Date: Wed, 20 Dec 2006 11:52:11 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050501080608050700010902"
Subject: [Xenomai-help] install an interrupt-handler from a kernel module
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
--------------050501080608050700010902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dear Xenomai-Users/Developers,

I have a basic question. Installing an interrupt handler is possible via
"rt_intr_create()", both from user-space and from a kernel module.
What happens when I do a "rt_intr_create()" from the module_init()
routine? By which priority, interrupts are delegated to my ISR? Do I
need to create an extra realtime task via "rt_task_create()" in order to
achieve hard realtime response, or is it enough to install the
interrupt-handler from module_init().


Thanks for help,
Markus Franke

--------------050501080608050700010902
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


--------------050501080608050700010902--

