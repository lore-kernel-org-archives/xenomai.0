Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Feb 2005 12:18:59 -0600
Message-ID: <0D21CBD1298D2C4790E2F2B86D96EC19380259@domain.hid>
From: "Reynolds, Terry \(Contractor-SIMTECH\)" <terry.reynolds2@domain.hid>
Subject: [Adeos-main] Porting question
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos <adeos-main@gna.org>

My apologies for being vague!  I'd never looked at the 2.4 tree & didn't =
know there was a ppc port there, I'm working on a ppc64, 2.6 port.
=20
I have a newfound appreciation for everyone porting ppc drivers to =
ppc64, the differences are huge.
=20
My specific problem is in using the RTAI sample test (latency), via the =
adeos/generic.c implementation.   In adeos_register_domain, when the =
root domain (linux) calls the adeos_switch_to function, the link =
register value stored for the RTAI_hal domain isn't set up properly to =
return to the register_domain function.
=20
At least I assume that's what's happening, since my system crashes in =
the adeos_switch_domain function, or in returning from there.
=20
This would be much easier to work on if there was a kdb available for =
ppc64!  Printk statements, with the kernel crashing every time I run the =
program is very time consuming.
=20
My question is: in the process of registering a domain, when does it's =
stack get setup so that a call to switch domain will pull up the correct =
value to place in the link register so that the switch function will =
know where to return to?
=20
=20
Thanks,
=20
=20
Terry

