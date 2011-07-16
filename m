Message-ID: <4E21C76C.5080403@domain.hid>
Date: Sat, 16 Jul 2011 19:16:28 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1QfDvt-0003TN-G7@domain.hid> <4E1B5860.1000309@domain.hid>
	<4E1B5944.5030408@domain.hid> <4E1BEC9F.1020404@domain.hid>
	<4E1BF619.6010609@domain.hid> <4E1C2912.9050605@domain.hid>
	<4E1C2959.8080004@domain.hid> <4E1C2A2D.9090602@domain.hid>
	<4E1C2AA5.6060208@domain.hid> <4E1C2B44.5060907@domain.hid>
	<4E1C2B8F.5080700@domain.hid> <4E1C2F56.8020103@domain.hid>
	<4E1C302A.8050309@domain.hid> <4E1C3301.2030203@domain.hid>
	<4E1C3672.1030104@domain.hid> <4E1C36EE.70803@domain.hid>
	<4E1C38CE.7090202@domain.hid> <4E1C3A5D.3020700@domain.hid>
	<4E1C44B4.50106@domain.hid> <4E1C8508.5010400@domain.hid>
	<4E1C858A.7070403@domain.hid> <4E1C86A1.6030707@domain.hid>
	<4E1C87BB.7000307@domain.hid> <4E1DE646.1090900@domain.hid>
	<4E1DEC58.4000901@domain.hid> <4E1DEE27.7030900@domain.hid>
	<4E1F581C.4050809@domain.hid> <4E2032EF.5030700@domain.hid>
	<4E203C55.3080605@domain.hid .de> <4E21483B.7050503@domain.hid>
	<1310806379.2154.418.camel@domain.hid > <4E215694.8000506@domain.hid>
	<1310810182.2154.455.camel@domain.hid>
In-Reply-To: <1310810182.2154.455.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig927ACCE8E96321C7B9154A5F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Fix race
 between gatekeeper and thread deletion
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig927ACCE8E96321C7B9154A5F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2011-07-16 11:56, Philippe Gerum wrote:
> On Sat, 2011-07-16 at 11:15 +0200, Jan Kiszka wrote:
>> On 2011-07-16 10:52, Philippe Gerum wrote:
>>> On Sat, 2011-07-16 at 10:13 +0200, Jan Kiszka wrote:
>>>> On 2011-07-15 15:10, Jan Kiszka wrote:
>>>>> But... right now it looks like we found our primary regression:
>>>>> "nucleus/shadow: shorten the uninterruptible path to secondary mode=
".
>>>>> It opens a short windows during relax where the migrated task may b=
e
>>>>> active under both schedulers. We are currently evaluating a revert
>>>>> (looks good so far), and I need to work out my theory in more
>>>>> details.
>>>>
>>>> Looks like this commit just made a long-standing flaw in Xenomai's
>>>> interrupt handling more visible: We reschedule over the interrupt st=
ack
>>>> in the Xenomai interrupt handler tails, at least on x86-64. Not sure=
 if
>>>> other archs have interrupt stacks, the point is Xenomai's design wro=
ngly
>>>> assumes there are no such things.
>>>
>>> Fortunately, no, this is not a design issue, no such assumption was e=
ver
>>> made, but the Xenomai core expects this to be handled on a per-arch
>>> basis with the interrupt pipeline.
>>
>> And that's already the problem: If Linux uses interrupt stacks, relyin=
g=20
>> on ipipe to disable this during Xenomai interrupt handler execution is=
=20
>> at best a workaround. A fragile one unless you increase the pre-thread=
=20
>> stack size by the size of the interrupt stack. Lacking support for a=20
>> generic rescheduling hook became a problem by the time Linux introduce=
d=20
>> interrupt threads.
>=20
> Don't assume too much. What was done for ppc64 was not meant as a
> general policy. Again, this is a per-arch decision.

Actually, it was the right decision, not only for ppc64: Reusing Linux
interrupt stacks for Xenomai does not work. If we interrupt Linux while
it is already running over the interrupt stack, the stack becomes taboo
on that CPU. From that point on, no RT IRQ must run over the Linux
interrupt stack as it would smash it.

But then the question is why we should try to use the interrupt stacks
for Xenomai at all. It's better to increase the task kernel stacks and
disable interrupt stacks when ipipe is enabled. That's what I'm heading
for with x86-64 now (THREAD_ORDER 2, no stack switching).

What we may do is introducing per-domain interrupt stacks. But that's at
best Xenomai 3 / I-pipe 3 stuff.

Jan


--------------enig927ACCE8E96321C7B9154A5F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4hx3AACgkQitSsb3rl5xS2PgCg1SupVXKLkUcUVPpe/2+6qwPa
5qwAoMv4stglDfCcdPnP1/au+sLpRz+F
=113r
-----END PGP SIGNATURE-----

--------------enig927ACCE8E96321C7B9154A5F--

