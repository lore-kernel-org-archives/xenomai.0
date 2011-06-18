Message-ID: <4DFC7C0E.1090700@domain.hid>
Date: Sat, 18 Jun 2011 12:21:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1QXaC2-0007dE-Ar@domain.hid>
	<4DFB869F.9080006@domain.hid>	<4DFB88EC.9090100@domain.hid>
	<4DFBA305.9000303@domain.hid>
In-Reply-To: <4DFBA305.9000303@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDD52D2DE0451173E30CEBDDC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Fix
	interrupt handler tails
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDD52D2DE0451173E30CEBDDC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-06-17 20:55, Gilles Chanteperdrix wrote:
> On 06/17/2011 07:03 PM, Jan Kiszka wrote:
>> On 2011-06-17 18:53, Gilles Chanteperdrix wrote:
>>> On 06/17/2011 04:38 PM, GIT version control wrote:
>>>> Module: xenomai-jki
>>>> Branch: for-upstream
>>>> Commit: 7203b1a66ca0825d5bcda1c3abab9ca048177914
>>>> URL:    http://git.xenomai.org/?p=3Dxenomai-jki.git;a=3Dcommit;h=3D7=
203b1a66ca0825d5bcda1c3abab9ca048177914
>>>>
>>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>>> Date:   Fri Jun 17 09:46:19 2011 +0200
>>>>
>>>> nucleus: Fix interrupt handler tails
>>>>
>>>> Our current interrupt handlers assume that they leave over the same =
task
>>>> and CPU they entered. But commit f6af9b831c broke this assumption:
>>>> xnpod_schedule invoked from the handler tail can now actually trigge=
r a
>>>> domain migration, and that can also include a CPU migration. This ca=
uses
>>>> subtle corruptions as invalid xnstat_exectime_t objects may be resto=
red
>>>> and - even worse - we may improperly flush XNHTICK of the old CPU,
>>>> leaving Linux timer-wise dead there (as happened to us).
>>>>
>>>> Fix this by moving XNHTICK replay and exectime accounting before the=

>>>> scheduling point. Note that this introduces a tiny imprecision in th=
e
>>>> accounting.
>>>
>>> I am not sure I understand why moving the XNHTICK replay is needed: i=
f
>>> we switch to secondary mode, the HTICK is handled by xnpod_schedule
>>> anyway, or am I missing something?
>>
>> The replay can work on an invalid sched (after CPU migration in
>> secondary mode). We could reload the sched, but just moving the replay=

>> is simpler.
>=20
> But does it not remove the purpose of this delayed replay?

Hmm, yes, in the corner case of coalesced timed RT task wakeup and host
tick over a root thread. Well, then we actually have to reload sched and
keep the ordering to catch that as well.

>=20
> Note that if you want to reload the sched, you also have to shut
> interrupts off, because upon return from xnpod_schedule after migration=
,
> interrupts are on.

That would be another severe bug if we left an interrupt handler with
hard IRQs enabled - the interrupt tail code of ipipe would break.

Fortunately, only xnpod_suspend_thread re-enables IRQs and returns.
xnpod_schedule also re-enables but then terminates the context (in
xnshadow_exit). So we are safe.

Jan


--------------enigDD52D2DE0451173E30CEBDDC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk38fBMACgkQitSsb3rl5xR/OgCdHVNb4CA8NwZTiNlMP5JjBBRK
WksAnAwIaNoOBQsgb/xbYpJ9BukWDTeL
=jEgo
-----END PGP SIGNATURE-----

--------------enigDD52D2DE0451173E30CEBDDC--

