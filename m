Message-ID: <470B76F0.1050102@domain.hid>
Date: Tue, 09 Oct 2007 14:41:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <515338.44993.qm@domain.hid>	
	<80b317760709110456k2ef95162t19d833da7c5781de@domain.hid>	
	<46E699C6.80609@domain.hid>	
	<305035a40709140817q452ca77dude2af88ce6fc3dd9@domain.hid>	
	<18186.42065.560821.557825@domain.hid>	
	<470B4688.6010808@domain.hid>	
	<305035a40710090235g54c57436u770168437f27a7f6@domain.hid>	
	<470B4DCD.4000303@domain.hid>
	<305035a40710090341i642ca2cavc8c1e90afbce93d6@domain.hid>
In-Reply-To: <305035a40710090341i642ca2cavc8c1e90afbce93d6@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig63E5C6E072088261B2F7936E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] RTOS porting on ARM
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gregory CLEMENT <gclement00@domain.hid>
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig63E5C6E072088261B2F7936E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[Switching the account to underline again that this is my personal POV.]

Gregory CLEMENT wrote:
> 2007/10/9, Jan Kiszka <jan.kiszka@domain.hid>:
>> Gregory CLEMENT wrote:
>>> 2007/10/9, Jan Kiszka <jan.kiszka@domain.hid>:
>>>> Gilles Chanteperdrix wrote:
>>>>> gclement00 at gmail.com (Gregory CLEMENT) wrote:
>>>>>  >
>>>>>  > For RTAI we have now a working systeme with have better max late=
ncy
>>>>>  > than Xenomai ( 50us instead of around 100us for Xenomai). I plan=
 to
>>>>>  > update the patches on our site with this new version and communi=
cate
>>>>>  > on it on RTAI list as soon as I have some free time.
>>>>>
>>>>> A good place for discussing about these figures would have been Xen=
omai
>>>>> mailing list, a place where we could have answered you immediately.=
 Are
>>>>> you sure you are not comparing Xenomai user-space scheduling latenc=
y
>>>>> with RTAI kernel-space scheduling latency ?
>>>> Me too asked Gregory for some discussion on this long ago but receiv=
ed
>>>> no response.
>>>>
>>>> Anyway, the critical thing beyond latencies remains *maintenance*. I=
f
>>>> someone decides to apply I-pipe on RTAI *and* doesn't forget to
>>>> contribute to the mandatory bits of the Adeos project, work actively=

>>>> within that community (test new versions and report results, track d=
own
>>>> bugs, port to new kernels releases, etc.), anyone would benefit in t=
he
>>>> end. BTW, that would surely stimulate discussions about differing
>>>> numbers on both sides as well.
>>> And you think we didn't contribute to adeos projects, test new versio=
n
>>> and report result???
>>> Because it is exactly what we have done.
>> You did this for the startup of this port, and it is highly appreciate=
d.
>> But such things require lasting effort. Probably I'm just so sceptical=

>> because there have been many people before posting patches once and th=
en
>> never again. Just look at RTAI's ARM history of the last, mmh, 4 years=
=2E
>> I'm always happy being proved wrong regarding such scepticisms of mine=
!
>=20
> There is no more post on adeos mailing list just because we didn't
> change it, since our last post.
> As I mentioned earlier we just set dbgu priority level at a different
> level, it is not a big change, but I will post the patch for it.

Tiny change, but probably significant impact. Every generic improvement
is worth posting. You will help others to exploit it, and you will also
allow other professionals to give you feedback on the changes. The old
story of open source.

>>> Our result on RTAI are pretty recent, and the lack of discussion on i=
t
>>> is only a lack of time and not a lack of wiling.
>> Then I'm looking forward to have this now, e.g. backed up with tracer
>> outputs of both variants.
>=20
> As I mentionned, that for now, I am deep under load ? Because I am,
> and so I will do my best but time is not extensible unforutnately.

I understand that (as long as you do not spread half-explained
benchmarks at the same time). Well, maybe you then recall even better
the concerns I sent you earlier about required future maintenance
efforts vs. available time...

Jan


--------------enig63E5C6E072088261B2F7936E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHC3bwniDOoMHTA+kRAq18AKCCDLX5xw6GCDoJB9aqRsc+GLy6BQCfXK+f
fZGWTcqJdREUTn/38tEAkyk=
=faKy
-----END PGP SIGNATURE-----

--------------enig63E5C6E072088261B2F7936E--

