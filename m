Message-ID: <499BBB08.5060801@domain.hid>
Date: Wed, 18 Feb 2009 08:38:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <9c789a000902160455k7dcae1d2tc151b12df6140ec0@domain.hid>	<200902170940.54910.peter.soetens@domain.hid>	<499A8636.5020100@domain.hid>	<200902171208.07297.peter.soetens@domain.hid>
	<87y6w4r167.fsf@domain.hid>
In-Reply-To: <87y6w4r167.fsf@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFD769FCF237244132CDB1B35"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Comedi drivers in Xenomai porting/integration
	status ?
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFD769FCF237244132CDB1B35
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Alexis Berlemont wrote:
> Hi,
>=20
> Peter Soetens <peter.soetens@domain.hid> writes:
>=20
>> On Tuesday 17 February 2009 10:41:10 Jan Kiszka wrote:
>>> Peter Soetens wrote:
>>>> These are the facts we observed:
>>>>
>>>> * The Xenomai/Comedi port breaks the complete Comedi API, user space=

>>>> *and* kernel space. (We thought/assumed that only the user space
>>>> interface would go over RTDM and that once that was done, the kernel=

>>>> modules could be almost copy/pasted into the new framework.)
>>> Maybe you have a list of the major differences. Then please share it =
so
>>> that the motivation can be discussed here and maybe clarified (it's a=

>>> blurred topic for me as well).
>> Damn. I should have posted back then :-) Our main lead was the Doxygen=
 pages,=20
>> from which we went on to see how things were done in code. Unfortunate=
ly (?),=20
>> I'm not a Comedi developer, I twiddled only with one Comedi driver. On=
ce. I=20
>> can't really compare to the bone. But what was clear immediately was t=
hat both=20
>> user API and kernel API were different.=20
>>
>> User ('Library') API was cleaned up and streamlined, we could live wit=
h that=20
>> for new applications. I'm sure there are still issues, but they'll onl=
y come=20
>> up once people start using this branch. I like the separation between =
a low=20
>> level 'instruction' api and a high level 'function' api. Something ups=
tream=20
>> comedi mixes to much.
>>
>> For kernel ('Driver') API, a new data transfer mechanism is in place, =
which=20
>> requires the 'porting' of all drivers. I genuinely can't estimate how =

>> drastically this changes existing drivers, but the API is quite huge a=
nd works=20
>> with the 'inversion of control' paradigm: Each driver must implement a=
 series=20
>> of hooks, and the Comedi/RTDM framework will call these when necessary=
=2E
>=20
> Just to sum-up why the whole Comedi API suffers so many changes from
> the upstream Comedi API (sorry for 'legacy'):
>=20
> * At the very beginning (If I remember well), I just wanted to port
>   the current Comedi layer so as to comply with RTDM API. My first
>   resolution was to leave the drivers set unchanged so as to
>   seamlessly use them in the ported framework. However, I was facing
>   many issues (RT/NRT contexts, mix with kernel API, etc.) I could not
>   handle without altering drivers code. Eventually, I was unable to
>   provide a coherent RTDM Comedi module considering the code
>   organization.
>=20
> * That was the point which makes try to overhaul the original
>   branch. I sent an email on the Comedi mailing list. I received no
>   answer; by the way, the activity seemed quite low. I wanted to
>   develop a Comedi infrastructure usable on both configurations
>   (common Linux API and RTDM). Fulfilling such a constraint led me to
>   redefine the kernel driver API. Before integrating the code into
>   Xenomai's trunk, I decided to drop the common Linux interface while
>   keeping in mind that the RTDM-native module would allow the new
>   Comedi core to run on common kernels (maybe that was a
>   mistake). That is why, the driver API still have the context notion;
>   I should remove it.
>=20
> Then I did my best to design a coherent layer. There are still many
> flaws to be improved. Notably at the driver level, the API is too
> closed. I (and/or anyone interested) should find a way to provide more
> freedom to drivers developers.
>=20
> Concerning the library API, I just thought there were too many
> functions in comedilib, and some were redundant with each other. I
> tried to propose an alternative like the native skin API was an
> alternative to the RTAI API. Maybe I was wrong.
>=20
> All that work relied on my assumption that upstream Comedi was not
> very active anymore. Then, it was an opportunity for me to have fun
> trying to deliver an RTDM port based on a new architecture.
>=20
> That was the reason why, I was really suprised to find Comedi
> integrated into the mainline kernel. What strikes me more is that
> Comedi seems to be left as is. Do you think, it will be cleaned up or
> reworked ?

Without rework Comedi will not make into mainline (I wouldn't call the
staging corner "mainline"). And when reading this
http://permalink.gmane.org/gmane.linux.kernel/793476, it is probably the
best time now to propose interface changes and contribute back
improvements made for the RTDM rework.

Jan


--------------enigFD769FCF237244132CDB1B35
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkmbu1QACgkQniDOoMHTA+liCQCeLugtD92FV3iVu8k2tldaMv9a
mN0Ani4cQz0SBrXyzixHjCw2rXFKPDTz
=FtNc
-----END PGP SIGNATURE-----

--------------enigFD769FCF237244132CDB1B35--

