Message-ID: <4469C4CE.5000804@domain.hid>
Date: Tue, 16 May 2006 14:25:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <44689BBE.1000304@domain.hid>
	<200605152240.15620.berlemont.hauw@domain.hid>
In-Reply-To: <200605152240.15620.berlemont.hauw@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig14A5B6652045C6A262D93BED"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: LTTng intergration roadmap
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: ROSSIER Daniel <Daniel.Rossier@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig14A5B6652045C6A262D93BED
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Alexis Berlemont wrote:
> Hi,
>=20
>> the need for a high-level tracing tool constantly increases with the
>> growing code base of Xenomai applications.
>>
>> Yesterday I started a short discussion with Alexis about the status of=

>> his LTTng combo patch, the Xenomai integration, and the advances of
>> LTTng itself. But there are certainly more people interested in this
>> topic and may contribute ideas, comments, or even concrete code.
>>
>> Daniel, you once said that some of your students would start to work o=
n
>> this topic. In which domain precisely, more at patch level or rather o=
n
>> tools? What is the scheduled beginning and/or deadline for this thesis=
?
>>
>> Moreover, does anyone on this list recently tried LTTng on standard
>> Linux? Can we consider it reasonably stable and usable? One new thing
>> about LTTng internals which Alexis brought up were changes in the cust=
om
>> tracing event interface. As this is a rather crucial point with respec=
t
>> to the Xenomai instrumentation, we certainly do not want to change it
>> back and forth until LTTng stabilises.
>=20
> Here is a little quotation from the LTTng Quickstart guide, I used it t=
o=20
> define the LTT events for Xenomai:
>=20
> * Add new events to the kernel with genevent
>=20
> su -
> cd /usr/local/share/LinuxTraceToolkitViewer/facilities
> cp process.xml yourfacility.xml
>   * edit yourfacility.xml to fit your needs.
> cd /tmp
> /usr/local/bin/genevent /usr/local/share/LinuxTraceToolkitViewer/facili=
ties/yourfacility.xml
> cp ltt-facility-yourfacility.h ltt-facility-id-yourfacility.h \
>          /usr/src/linux-2.6.16-lttng-0.x.xx8/include/linux/ltt
> cp ltt-facility-loader-yourfacility.c ltt-facility-loader-yourfacility.=
h \
>          /usr/src/linux-2.6.16-lttng-0.x.xx/ltt
>   * edit the kernel file you want to instrument
>     - Add #include <linux/ltt/ltt-facility-yourfacility.h> at the begin=
ning
>       of the file.
>     - Add a call to the tracing functions. See their names and paramete=
rs in
>       /usr/src/linux-2.6.16-lttng-0.x.xx/include/linux/ltt/ltt-facility=
-yourfacility.h
>=20
> So, In order to test the combo patch adeos + LTTng I made:
> -> I wrote xenomai.xml (cf. attached file) which defines all the Xeno-L=
TT=20
> events;
> -> I used genevent so as to generate the sources and the headers relati=
ve with=20
> my events;
> -> Instead of copying them in the kernel, I integrated the sources in X=
enomai.=20
> I was considering that the Xeno events was independant from Linux.=20
>=20
> As a matter of fact, the last point should be rethought as the Xeno bui=
ld=20
> procedure is now integrated in the kernel.=20

Not necessarily, you may still compile the nucleus as a module.

>=20
> Things are simpler now, we could create an "I-pipe aware LTTng" patch w=
hich=20
> could contain :
> -> the modifications in Relayfs (for a proper functioning with Adeos);
> -> the LTTng core stuff adapted for Adeos (not much work to do on this =
part);
> -> the Xenomai events in include/linux/ltt, and the loading code in ...=


Hmm, I guess Philippe will not be happy to see Xeno-specific code in the
ipipe patch (like I had with my kgdb hack). Is there no clean way to
introduce this code together with the Xenomai installation, e.g. when
preparing the kernel with the script?

>=20
> This patch would be applied after the I-pipe patch (in the same way as =
the=20
> I-pipe tracer patch). So there would be no need to make combo patches, =
an=20
> arch-independant additionnal patch would be easier to maintain.
>=20
> What do you think of that ?

I do not overview every detail (I should actually look at the patch more
in detail, but - you know - time...). Everything that helps to reduce
maintenance costs while still keeping clean abstraction layers (ipipe is
 ipipe, xenomai is an independent add-on) is certainly good.

>=20
> Eventually, concerning LTTng stabilisation status, I had a look a their=
=20
> mailing-list (I am lurking on it since the beginning of LTTng) and at t=
heir=20
> roadmap: starting from now, their TODO list contains integration and po=
rts,=20
> therefore undertaking an integration of LTTng with Xenomai (rigth now o=
r next=20
> month) does not seem too risky, does it?

Sounds good. Sounds at least like they found a stable design we can use
now - or soon when resources are available.

Jan


--------------enig14A5B6652045C6A262D93BED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEacTOniDOoMHTA+kRAnAfAJ9raqpaU8b42rdwLO2yD2sOnPYdRgCfdSof
JGVSQMkmEakjkmmfIaYDm+Y=
=1ZM9
-----END PGP SIGNATURE-----

--------------enig14A5B6652045C6A262D93BED--

