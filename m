Message-ID: <45E3E323.7060209@domain.hid>
Date: Tue, 27 Feb 2007 08:52:03 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Scheduling of different domains in Adeos
References: <45E15BC1.2000303@domain.hid>
	<45E161AA.9070005@domain.hid>
	<45E2FAB3.2000305@domain.hid>
	<45E3116E.70402@domain.hid>
In-Reply-To: <45E3116E.70402@domain.hid>
Content-Type: multipart/mixed; boundary="------------080701000508080300030602"
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
--------------080701000508080300030602
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> See above: each domain (which may contain an OS) has a certain priority,
> and the one with the highest priority which has events pending gets the
> CPU. That's what the Adeos/I-pipe patch does on event arrival or domain
> suspension.

Ok, this I know already.

> Adeos doesn't do full CPU virtualisation. Therefore, the domains must
> cooperate on those resources (memory management, FPU, etc.) that aren't
> switched by the nano-kernel. Adeos is not qemu or kvm, if this is what
> you have in mind.

So if you want to get working more than one operating system, each
embodied in it's own domain, you have to adapt the operating systems in
order to get also some kind of CPU virtualization. But these changes are
not part of the Adeos-Patches for the Linux kernel, right?

Has anybody ever tried to set up a system with let's say two Linux
kernels working on top of Adeos, simultaneously?

Regards,
Markus

--------------080701000508080300030602
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


--------------080701000508080300030602--

