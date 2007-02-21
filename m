Message-ID: <45DCB408.8060800@domain.hid>
Date: Wed, 21 Feb 2007 22:05:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] latency results for ppc and x86
References: <725115.56324.qm@domain.hid>
	<Pine.LNX.4.60.0702211019590.2291@domain.hid>
	<45DC23D4.5090000@domain.hid>
	<Pine.LNX.4.60.0702211116020.2526@domain.hid>
	<45DC3B13.5090200@domain.hid>
	<Pine.LNX.4.60.0702211302290.2780@domain.hid>
	<45DC4E6A.6090708@domain.hid> <45DC5CAC.8020901@domain.hid>
	<Pine.LNX.4.60.0702211552170.3327@domain.hid>
	<45DC8F03.4020703@domain.hid>
	<Pine.LNX.4.60.0702211959180.3773@domain.hid>
In-Reply-To: <Pine.LNX.4.60.0702211959180.3773@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1ADFAEDBB86250B33425A70E"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Nicholas Mc Guire <der.herr@domain.hid>
Cc: adeos-main@gna.org, Wolfgang Grandegger <wg@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1ADFAEDBB86250B33425A70E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Nicholas Mc Guire wrote:
>> Nicholas Mc Guire wrote:
>>>>>> well thats true for ADEOS/RTAI/RTLinux as well - we are also only
>>>>>> black-box testing the RT-kernel - there currently is absolutley NO=

>>>>>> prof for worst-case timing in any of the flavours of RT-Linux.
>>>>>
>>>>> Nope, it isn't. There are neither sleeping not spinning lock nestin=
g
>>>>> depths of that kind in Xenomai or Adeos/I-pipe (or older RT
>>>>> extensions,
>>>>> AFAIK) - ok, except for one spot in a driver we have scheduled for
>>>>> re-design already.
>>>
>>> that might be so - never the less there is no formal-proof that the
>>> worst
>>> case of ADEOS/I-pipe is X-microseconds, the latency/jitter numbers ar=
e
>>> based on black-box testing. In fact one problem is that there are not=

>>> even
>>> code-coverage tools (or I just did not find them) that can provide
>>> coverage data for ADEOS - thus how can one guarantee worst-case ?
>=20
>> The fact that tool support is "improvable" doesn't mean that such an
>> analysis is impossible. You may over-estimate, but you can derive
>> numbers for a given system (consisting of real-time core + RT
>> applications) based on a combined offline system analysis and runtime
>> measurements. But hardly anyone is doing this "for fun".
>=20
>=20
> with the current status I don't think a off-line analysis is resonable
> I don't think a model of ADEOS is resonably duable, alteast not a
> modleing that would lead to any usable results - I might be wrong - do
> you know of any such successfull approaches ? All testing is really
> inherently limited, from black-box testing you simply don't get any
> guarantees.

We are no longer black-box testing - thanks to our "KFT". I'm trying to
advertise this model heavily to users, but it still requires a bit too
much system knowledge. Still, modelling a system of I-pipe + Xenomai
remains an open challenge AFAIK.

>=20
> <snip>
>>> its not a corener case demonstration, Ive been doing benchmarks on rt=

>>> preempt now for quite some time, there is still an advantage if you r=
un
>>> simple comparisons (jitter measurements) - but it is clearly going do=
wn,
>>> The problem I have with RT-preempt being 50us and ADEOS is 15us is
>>> simply that the sector that does need those numbers that RT-preempt w=
ill
>>> most likely
>>> never reach is generally interested in guaranteed times, and thats wh=
ere
>>> it becomes tough to argue any of the hard-realtime extensions at this=

>>> point - that is not saying RT-preempt can replace ADEOS/RTAI/RTLinux-=
gpl
>>> Im just saying that the numbers are no longer 2/3 orders of
>>> magnitude,which they were in 2.2.X/2.4.X and where arguing the use wa=
s
>>> simple.
>=20
>> Granted, arguing becomes more hairy when you have to pull out low-leve=
l
>> system details like I posted (and not discussing individual issues of
>> certain patches). There are scenarios where I would recommend -rt as
>> well, but so far only few where RT extensions are fitting too.
>=20
>>>
>>> Don't get me wrong Im not trying to argue away ADEOS/RTAI or I would
>>> have given up RTLinux/GPL quite some time ago - but I belive if these=

>>> low-jitter/latency systems want to keep there acceptance in industry =
a
>>> key issue will be to improve the tools for verification/validation -
>=20
>> Ack, and I'm sure they will emerge over the time. I don't expect this =
to
>> happen just because someone enjoys it (adding features is always
>> funnier), but because users will at some point really need them. It's =
a
>> process that will derive from the steadily growing professional user
>> base in both industry and academia.
>=20
> let see - I hope you are right - I'm just starting into a FMEA/HAZOP fo=
r
> XtratuM "for fun" ;)

Will be interesting to hear/read about practical experiences.

>=20
>>>
>>> <snip>
>>>
>>>  THAT is a problem in arguing for ADEOS/I-pipe - WHAT is the worst ca=
se
>>> now ? what is the cause of the worst case ? and can I really demonstr=
ate
>>> by strong evidence that the worst case on this system is actually XXX=
X
>>> microseconds under arbitrary load and will not be higher in some stra=
nge
>>> corner cases ?
>=20
>> Leaving the completely formal proof aside (that's something even
>> microkernels still cannot provide), you may go to the drawing board,
>> develop a model of your _specific_ system, derive worst-case
>> constellations, and trace the real system for those events (probably
>> also stimulating them) while measuring latencies. Then add some safety=

>> margin ;), and you have worst-case numbers of a far higher quality the=
n
>> by just experimenting with benchmarks. This process can become complex=

>> (ie. costly), but it is doable.
>=20
>> The point about co-scheduling approaches is here, that they already co=
me
>> with a simpler base model (for the RT part), and they allow to "tune"
>> your system to simplify this model even further - without giving up an=

>> integrated non-RT execution environment and its optimisations. We will=

>> see the effect better on upcoming multi-core systems (not claiming tha=
t
>> Xenomai is already in /the/ perfect shape for them).
>=20
>=20
>> However, if you have suggestions on how to improve the current tool
>> situation, /me and likely others are all ears. And such improvements d=
o
>> not have to be I-pipe/Xenomai-specific...
>=20
> well one thing Im looking into for RTLinux is to extend things like
> kernel GCOV into RTLinux and KFI/KFT to RTLinux as this allows much
> better assessment. I guess that those extensions would equally be worth=

> while
> for ADESO/I-pipe/Xenomai.
>=20
> refs:
>=20
>  KFT www.celinuxforum.org/CelfPubWiki/PatchArchive last one for 2.6.12
>  GCOV-Kernel part of LTP now (last one is for linux-2.6.16-gcov.patch.g=
z
>=20

[Quick glance at GCOV patch] Hmm, the thrilling thing is typically
locking, but I don't see a single spinlock, just some semaphores that
cannot be called from arbitrary contexts anyway. Hmm. Did you already
played with it for some kernel?

Regarding KFT: we have such thing already. Partly derived from Ingo
Molnar's work, but with less impact during freeze, the function tracer
is in I-pipe since more than a year. It's heavily used (at least by the
core team) for application and kernel debugging, and for latency
spotting of course. Available for most I-pipe archs, even for the latest
x86_64-WiP. The funny thing is that even RTAI could make use of it - if
they only realised that it's in their patches.

Next to come (yeah, long announced) is LTTng support, i.e. patch and
front-end extensions for Xenomai. There is a working version lying
around somewhere in Canada, I just need to kick the guy again who did
that work for his thesis so that he roles out a release and we can start
discussing the patch integration. Good to be reminded...

So there is definitely not nothing - but surely still enough to do :).
If you see some potential in cooperating on front-ends (given that you
still seem to head for your own kernel-patch path), let us know. I guess
there should be common ground.

Jan


--------------enig1ADFAEDBB86250B33425A70E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3LQIniDOoMHTA+kRAlUHAJ418aWkeh0uAp767wlMihp2rNX/4gCfaTcH
ZOQh7KfTWSP+Fb/4GkmqxKQ=
=Zb2w
-----END PGP SIGNATURE-----

--------------enig1ADFAEDBB86250B33425A70E--

