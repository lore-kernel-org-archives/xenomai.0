Message-ID: <4C92A9D5.7010602@domain.hid>
Date: Fri, 17 Sep 2010 01:35:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4C91D29F.7020106@domain.hid> <4C91E05E.6010202@domain.hid>
	<4C926742.4010601@domain.hid>
In-Reply-To: <4C926742.4010601@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig16BE4B747CC2FF7DEE40160A"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] (Not yet) Xenomai 2.5.5.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig16BE4B747CC2FF7DEE40160A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 16.09.2010 20:51, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Am 16.09.2010 10:17, Gilles Chanteperdrix wrote:
>>> Hi,
>>>
>>> I would like to make that next release of Xenomai, especially since t=
he
>>> fix for the I-pipe on x86_32 with grub2 has been available for some t=
ime
>>> now, and has not yet been in a stable release.
>>>
>>> So, I have a few minor questions:
>>> - Wolfgang, Alexis, it seems we have a few warnings when compiling
>>> rtcan/analogy tools with recent versions of gcc (4.4.1 from
>>> codesourcery). You will find the logs here:
>>> http://sisyphus.hd.free.fr/~gilles/pastebin/KVSBtb
>>> we are not in a hurry to fix this, so simply tell me if the fix is ea=
sy
>>> or not.
>>> - Alexis, from the mailing list discussions, you probably have some
>>> commits ready in the analoty branch, would it be possible to have a p=
ull
>>> request for these?
>>> - Jan, where are we with CLOCK_HOST_REALTIME, are the I-pipe ready?
>>> Should I merge Wolfgang's patches, or the I-pipe/Xenomai interface ha=
s
>>> changed following the discussions with Philippe?
>>
>> I've a ready-to-use version that should address all of Philippe's
>> remarks in my 2.6.35 queue [1]. The plan was to push it along this lin=
e,
>> but then things got stuck due to the 32-bit boot hang report by Ed
>> Hoffman (still waiting for further information from him). Also my KVM
>> patches in that queue do not work yet, but they will likely be postpon=
ed.
>>
>> Besides that, I've longer queue of fixes and enhancement to Xenomai [2=
]
>> that partially depends on [1]. I already sent pull requests, but then
>> did not refresh it due to the dependency.
>>
>> Unfortunately, I'm "a bit" short on time the next weeks, so we need to=

>> find the cheapest way of getting the most important stuff merged for
>> 2.5.5 I guess. I already started backporting the critical sync fixes f=
or
>> I-pipe to 2.6.34 [3], just sent no pull request yet.
>=20
> Ok. I would like to be able to merge at least before the middle of next=

> week so as to validate a bit the result before releasing, hopefully,
> before the end of next week.
>=20
> I had a look at the patches you pushed. I find it a bit dangerous to
> merge quickly such patches, which fiddle with the nklock, without
> extensive testing.

This is first of all xenomai-head stuff, nothing that shall be
unconditionally backported. But even for head, we can perfectly skip the
debugging part. Important are the fixes. I've reordered and shortened my
queue already.

> The risk is that on SMP machines, the cpus start
> dumping stack traces concurrently, resulting in an unreadable mess (we
> have seen this in the past actually), whereas, correct me if I am wrong=
,
> if the output takes place on the serial port, which is the current
> preferred debug setup with Xenomai, we do not have to schedule klogd to=

> get an output, so we do not have to release the nklock.

I will have to check this again, but I bet the need for dropping nklock
came from the fact that more than the serial port was configured (that's
default here). Then some other console driver may have locked things up
while walking the write handlers. Moreover, I would like to get more
data in case the user did not yet prepare for catching a Xenomai panic.
But, of course, dump regressions must be avoided.

>=20
> I also do not understand the game with panic. It looks to me there is a=

> risk of breaking compatibility with older Adeos patches, whose panic wa=
s
> not as solid as the one of the current releases.

Do you have some versions in mind? Something in the early 2.6.20th or
younger?

Jan


--------------enig16BE4B747CC2FF7DEE40160A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkySqdkACgkQitSsb3rl5xQcewCg7WtBTxopq3WzSmSmUVavuk4b
Uo8AnjLbr89V7b7pDwIhqYybmdhO1+Wz
=mEKk
-----END PGP SIGNATURE-----

--------------enig16BE4B747CC2FF7DEE40160A--

