Content-class: urn:content-classes:message
Subject: RE: [Adeos-main] Porting question (PPC64)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Feb 2005 20:59:16 -0600
Message-ID: <0D21CBD1298D2C4790E2F2B86D96EC19380269@domain.hid>
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

Hello all,
=20
I've fixed my data alignment problems, and the __adeos_init_domain =
function seems to have the stack set up properly for the new domain.  =
The next event is a switch_domain from the root domain to the new one.  =
This still fails.  On printing out the inputs, the root domain's stack =
isn't setup.  The items loaded in the initial call to __adeos_init are =
OK, but the stack pointer adp->esp[cpuid] is null, as is the m_link =
structure member.
=20
It looks like the root domain has never been suspended prior to the =
real-time domain being registered.  When should the root domain's esp's =
pointed at stack been created / initialized?  That isn't happening in =
the __adeos_init function.
=20
Thanks for any help!
=20
=20
Terry

________________________________

From: Reynolds, Terry (Contractor-SIMTECH)
Sent: Wed 2/23/2005 6:44 PM
To: adeos-main@gna.org
Subject: RE: [Adeos-main] Porting question


I've been looking at the __adeos_init_domain function with printk =
statements.   It looks like the ppc64's 64 bits
for unsigned long's have hosed up the positions of the structure =
elements.  The adp->m_link and adp->flags
both come back as zero from the call to the init_domain function.  They =
were non-zero in the function. I'll have
to re-compute the relative addresses for the structure elements.
=20
Thanks,
=20
Terry
=20

________________________________

From: adeos-main-admin@domain.hid on behalf of Philippe Gerum
Sent: Wed 2/23/2005 12:32 PM
To: Reynolds, Terry (Contractor-SIMTECH)
Cc: adeos
Subject: Re: [Adeos-main] Porting question



Reynolds, Terry (Contractor-SIMTECH) wrote:
> My apologies for being vague!  I'd never looked at the 2.4 tree & =
didn't know there was a ppc port there, I'm working on a ppc64, 2.6 =
port.
>=20
> I have a newfound appreciation for everyone porting ppc drivers to =
ppc64, the differences are huge.
>=20
> My specific problem is in using the RTAI sample test (latency), via =
the adeos/generic.c implementation.   In adeos_register_domain, when the =
root domain (linux) calls the adeos_switch_to function, the link =
register value stored for the RTAI_hal domain isn't set up properly to =
return to the register_domain function.
>=20
> At least I assume that's what's happening, since my system crashes in =
the adeos_switch_domain function, or in returning from there.
>=20
> This would be much easier to work on if there was a kdb available for =
ppc64!  Printk statements, with the kernel crashing every time I run the =
program is very time consuming.
>=20
> My question is: in the process of registering a domain, when does it's =
stack get setup so that a call to switch domain will pull up the correct =
value to place in the link register so that the switch function will =
know where to return to?
>=20
>=20

__adeos_init_domain(). Really. Excerpt:

        ksp[19] =3D (_cpuid =3D=3D cpuid); /* r3 */
        ksp[25] =3D (unsigned long)attr->entry; /* lr =
<=3D=3D=3D=3D=3D=3D */
        ksp[26] =3D flags & ~MSR_EE; /* msr */


PS: please ask your mail client to wrap lines. (My 2700 inches CRT does
not fit on my office desk...)

> Thanks,
>=20
>=20
> Terry
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



