Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Aug 2005 14:55:47 -0500
Message-ID: <0D21CBD1298D2C4790E2F2B86D96EC1935943D@amr-ex5.ds.amrdec.army.mil>
From: "Reynolds, Terry \(Contractor-SIMTECH\)" <terry.reynolds2@domain.hid>
Subject: [Adeos-main] ppc64 SMP, need help
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org

=20
 Hi All,

I'm stuck on getting the SMP version of ppc64 to correctly boot the
other cpu.  The way the=20
kernel starts the other cpu(s) is to temporarily replace the reset
vector with a pointer to
the secondary cpu startup routines (pmac_secondary_start_1, _2 etc),
trigger a reset=20
interrupt, and then restore the vector.  What I can't figure out is why
having CONFIG_ADEOS=20
defined stops this from working even if I postpone the registering the
root domain and=20
enabling the pipeline until after the other cpus should be started
(after doing the reset=20
interrupts for the second cpu).

How do you think this should be handled?  How do I get to the Adeos
version of the reset=20
vector to send it off to the secondary start functions?

Thanks for any ideas!


Terry Reynolds

Simulation Technologies, INC.



