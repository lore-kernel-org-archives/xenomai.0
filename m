Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Adeos-main] ppc64 switch_domain problem
Date: Tue, 8 Mar 2005 13:01:03 -0600
Message-ID: <0D21CBD1298D2C4790E2F2B86D96EC19380274@domain.hid>
From: "Reynolds, Terry \(Contractor-SIMTECH\)" <terry.reynolds2@domain.hid>
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

I don't think the stack is the problem, the same stack is used for both =
the case that works and the one that doesn't!  I only changed the =
attr.entry function pointer, the stack created is independent of which =
routine is about to be called. =20
=20
=20
Terry

________________________________

From: adeos-main-admin@domain.hid on behalf of Philippe Gerum
Sent: Tue 3/8/2005 11:54 AM
To: Reynolds, Terry (Contractor-SIMTECH)
Cc: adeos-main@gna.org
Subject: Re: [Adeos-main] ppc64 switch_domain problem



Reynolds, Terry (Contractor-SIMTECH) wrote:
> Hi All,
>=20
> Are there any ppc64 gurus lurking out there?  My port to ppc64 has a =
severe problem.  When attempting to register a new domain, as in the =
RTAI testsuite's latency example, the switch to the new domain fails on =
the branch to rthal_domain_entry.  It suffers an "unrecoverable FP =
unavailable exception 800 at 0xd0000..." which is the location of the =
attr.entry for the link to that function.
>=20
> The code has no floating point code in it, so it must be pulling up =
some garbage instruction that isn't actually at that location.  I made a =
new function rthal_domain_entry2 which is included in the kernel, it's =
in the same file as the __adeos_init_domain function (/adeos/ppc64.c for =
my port).  It's address is a kernel code 'like' 0xc0000...  The switch =
domain to that function works fine!
>=20
> I think the branch to lr works for the kernel address, but not the =
loaded module one because of some problem with the SLB.  The ppc64 =
_switch function does modify the memory management hardware if the ESID =
is different for the task being switched to.
>=20
> Anyone have an idea on how to correct this problem?
>=20

Since it switches stacks, __adeos_switch_domain() should probably be
updated to switch the SLB appropriately then.

>=20
> TIA!
>=20
> Terry Reynolds.
>=20
>=20
>
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


--

Philippe.

_______________________________________________
Adeos-main mailing list
Adeos-main@domain.hid
https://mail.gna.org/listinfo/adeos-main



