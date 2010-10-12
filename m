Message-ID: <4CB498CD.1050804@domain.hid>
Date: Tue, 12 Oct 2010 19:20:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CB33738.206@domain.hid>	<4CB338AB.3070803@domain.hid>	<4CB339F9.5080202@domain.hid>	<4CB33F04.3000600@domain.hid>	<4CB34031.5090505@domain.hid>	<4CB3424A.5090504@domain.hid>	<4CB4299D.70600@domain.hid>
	<4CB43704.4020504@domain.hid> <4CB45B06.2070905@domain.hid>
In-Reply-To: <4CB45B06.2070905@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAA8A9976E0F5BEAD2CE0D15A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai and capabilities
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAA8A9976E0F5BEAD2CE0D15A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 12.10.2010 14:56, Anders Blomdell wrote:
> On 2010-10-12 12.23, Anders Blomdell wrote:
>> On 2010-10-12 11.25, Anders Blomdell wrote:
>>> On 2010-10-11 18.58, Jan Kiszka wrote:
>>>> Am 11.10.2010 18:49, Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Am 11.10.2010 18:23, Gilles Chanteperdrix wrote:
>>>>>>> Jan Kiszka wrote:
>>>>>>>> enabling the Xenomai watchdog should provide a reasonably safe&s=
ecure
>>>>>>>> environment.
>>>>>>> AFAIK, the BIG FAT warning at the bottom of this page still appli=
es. You
>>>>>>> can make an environment with no hardware lockups, but secure, I d=
o not
>>>>>>> think so. We do not know how Xenomai APIs could be exploited for =
a
>>>>>>> non-root user to become root.
>>>>>>
>>>>>> For sure, no one audited the interface for security so far. There =
is no
>>>>>> hole in design that comes to my mind ATM, but I would be surprised=
 as
>>>>>> well if you couldn't develop any exploit for some bug or missing c=
heck.
>>>>>> Still, there is a huge difference between giving anyone root acces=
s and
>>>>>> confining Xenomai access this way.
>>>>>
>>>>> I was just reacting to "reasonably secure". The experience proves t=
hat
>>>>> if you do not do any particular effort for security, then your code=
 is
>>>>> not secure. Not even reasonably.
>>>>
>>>> This is no black-or-white domain, and I wouldn't say we spend no eff=
ort
>>>> on security at all. We do have interest in making the userspace APIs=

>>>> robust which addresses security up to a certain level as well.
>>>>
>>>> What is still definitely not secure, though, is RTnet as it conseque=
ntly
>>>> lacks any kind of check on user-passed addresses. But that's not
>>>> Xenomai's fault (rather mine).
>>> If I understand manpages and code correctly, xenomai is insecure by d=
esign (not
>>> a major problem here, I hope), but I had hoped to be able to avoid CA=
P_SYS_RAWIO
>>> which I think is the biggest security problem (access to /proc/kcore =
IS scary),
>>> but since CAP_SYS_NICE implies CAP_SYS_RAWIO via shadow.c:
>>>     if (!capable(CAP_SYS_NICE) &&
>>>         (xn_gid_arg =3D=3D -1 || !in_group_p(xn_gid_arg)))
>>>         return -EPERM;
>>>
>>>      wrap_raise_cap(CAP_SYS_NICE);
>>>      wrap_raise_cap(CAP_IPC_LOCK);
>>>      wrap_raise_cap(CAP_SYS_RAWIO);
>>>
>>> I will go for the group thing (simple and totally insecure) for now, =
and put
>>> some more thought into it later on.
>> Well, obviously this feature is somewhat broken:
>>
>>> testprog
>> Xenomai: binding failed: Cannot allocate memory.
>>
>> This is what syslog says:
>> Xenomai: testprog[2367] cannot map MAYDAY page
>>
>> Running as root works as it should.
> CAP_DAC_OVERRIDE fixes this issue (and how safe is that :-( )

This is not a Xenomai issue but a system misconfiguration. Installing
the Xenomai-provided udev scripts will fix it (ie. grant your Xenomai
group access to /dev/rtheap).

>=20
> How necessary are CAP_SYS_RAWIO and CAP_DAC_OVERRIDE [the two capabilti=
ties i
> think have the most severe security implications] when main has started=
 running,
> i.e. could I drop them after initialization and still do something usef=
ul?

In the absence of user space drivers, you should be able to live without
CAP_SYS_RAWIO. Not sure, though, if there is a way to overcome
CAP_SYS_RAWIO for user space TSC access on ARM as Gilles mentioned. But
if that turns out to be the only remaining problem, making this
capability optional (at least on !=3DARM) should be no big deal IMHO.

Jan


--------------enigAA8A9976E0F5BEAD2CE0D15A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAky0mNAACgkQitSsb3rl5xTjtwCglq0dVRRn6NXptWBD1FLqVs72
B2MAnRVnNx8WQiyr2dXRX7heJ2Y1LrF/
=cIZt
-----END PGP SIGNATURE-----

--------------enigAA8A9976E0F5BEAD2CE0D15A--

