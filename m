Message-ID: <441845CD.8010102@domain.hid>
Date: Wed, 15 Mar 2006 17:50:21 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] the same error-solution
References: <4416CC6A.8030605@domain.hid>	<17430.53111.874553.840320@domain.hid>	<4416D650.3040609@domain.hid>	<17430.59156.719375.430724@domain.hid>	<4417C3D8.10801@domain.hid>
	<44184158.8010805@domain.hid>
In-Reply-To: <44184158.8010805@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1718FD85786BE084C2FC202E"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1718FD85786BE084C2FC202E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jeff Webb wrote:
> marcellin wrote:
>> -I've forgot rt_task_shadow() in the main Linux thread
>=20
> It would be helpful to add a note to the API docs for rt_task_shadow()
> explaining this usage.  It would also be good to note that tasks create=
d
> in this way must also be cleaned up using rt_task_delete().
>=20
> rt_task_shadow()
> -----
> Turns the current Linux task into a native Xenomai task.  Creates a
> real-time task running in the context of the calling regular Linux task=

> in user-space.  For instance, calling rt_task_shadow() from main() will=

> map the program's main thread to a native Xenomai thread, allowing it t=
o
> invoke blocking real-time services.  Note that all tasks created using
> rt_task_shadow() must be cleaned up using rt_task_delete().
> -----

Oops, this need for cleanup likely dates back to my comment It's
actually not that hard. The related kernel resources get released when
the task terminates. But cleanup is (still) mandatory for non-task object=
s.

>=20
> It would be good to put a note in the rt_task_delete() docs as well.
>=20
> rt_task_delete()
> -----
> ... A task exists in the system since rt_task_create() ( or possibly
> rt_task_shadow() ) has been called to create it, so this service must b=
e
> called in order to destroy it afterwards...
> -----
>=20
> I'm sure these comments are obvious to many folks, but it would help ou=
t
> the newbies.  It is helpful when the documentation explicitly says
> things like this, so one doesn't have to guess.
>=20
> Thanks again for putting in the effort to make great API documentation.=
=20
> I believe it is essential to the widespread adoption of Xenomai, and
> makes it very attractive to the newcomer.
>=20
> If you would rather have me submit suggestions like this in patch form,=

> I would be happy to do so.  Just show me an example diff (or 'svn
> diff'?)  command so I know what command-line options you prefer.

Yes, svn diff gives very good output. And yes, a patch is even more
welcome than your already helpful comments. I recently learned again
that RTDM is also still suffering from inherent but undocumented
characteristics, things that are obvious - at least for me. ;)

Jan


--------------enig1718FD85786BE084C2FC202E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEGEXNniDOoMHTA+kRAk+cAJ9CVcsIsWNECz8uYjrlIVf/CXujBwCdFCLI
M6zlkCMrhFguf4rb2Th6+Pw=
=uEl3
-----END PGP SIGNATURE-----

--------------enig1718FD85786BE084C2FC202E--

