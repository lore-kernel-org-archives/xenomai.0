Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Feb 2005 17:22:37 -0600
Message-ID: <0D21CBD1298D2C4790E2F2B86D96EC19380243@domain.hid>
From: "Reynolds, Terry \(Contractor-SIMTECH\)" <terry.reynolds2@domain.hid>
Subject: [Adeos-main] adeos_switch_domain PPC
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
To: adeos-main@gna.org

Hi All,
=20
=20
I'm working on a port of adeos, and have a simple question concerning =
the adeos_switch_domain function.  In the code the link register is =
swapped for the value stored in the incoming domain's stack.  Since this =
value is the return address used by the blr statement, how does the =
function get back to the switch_to function that called it from the old =
domain?  My problem seems to occur the first time the new domain is =
created, when the switch domain function is called, the link register =
doesn't seem to be set up to the same spot. =20
=20
=20
Any light some one could shed on this would be greatly appreciated!
=20
=20
Thanks,=20
=20
=20
=20
Terry

