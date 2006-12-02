Message-ID: <4571BEF8.5080900@domain.hid>
Date: Sat, 02 Dec 2006 18:59:20 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Adeos support for 2.6.18 merged PowerPC
	architecture.
References: <20061124105346.e442448d.benjamin.zores@domain.hid>	
	<4566C5AF.7030107@domain.hid>	
	<20061124113009.08c0a490.benjamin.zores@domain.hid>	
	<4569E699.6050003@domain.hid>	
	<20061127092143.e633cd91.benjamin.zores@domain.hid>	
	<456ACA35.8030206@domain.hid>	
	<20061127125419.3852edd9.benjamin.zores@domain.hid>	
	<456AD5EB.5040901@domain.hid>	
	<20061130133745.272ab4b1.benjamin.zores@domain.hid>	
	<456EDA4B.3060809@domain.hid> <1165013200.4952.177.camel@domain.hid>	
	<1165014875.4952.199.camel@domain.hid> <4571491D.502@domain.hid>	
	<1165078727.4952.222.camel@domain.hid>
	<4571B9DF.6010101@domain.hid>
	<1165081330.4952.228.camel@domain.hid>
In-Reply-To: <1165081330.4952.228.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0541C9DD4624A962FADE3E67"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0541C9DD4624A962FADE3E67
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sat, 2006-12-02 at 18:37 +0100, Wolfgang Grandegger wrote:
>> Philippe Gerum wrote:
>>> On Sat, 2006-12-02 at 10:36 +0100, Wolfgang Grandegger wrote:
>>>> Philippe Gerum wrote:
>>>>> On Fri, 2006-12-01 at 23:46 +0100, Philippe Gerum wrote:
>>>>>> On Thu, 2006-11-30 at 14:19 +0100, Jan Kiszka wrote:
>>>>>>
>>>>>>> Anyway, there is an unreleased work-in-progress patch for x86 ove=
r -rc6
>>>>>>> by Philippe. I recently had the chance to test it and hack a bit =
on the
>>>>>>> SMP IO-APIC part. It seems to work fine under UP, but SMP had som=
e
>>>>>>> issues that are identified, but still need to be addressed - than=
ks to
>>>>>>> genirq, now in a widely arch-independent way.
>>>>>>>
>>>>>>> Philippe, I know you are very busy, but shouldn't we make a pre-r=
elease
>>>>>>> available already, also to discuss further how to deal best with =
genirq
>>>>>>> on other platforms beyond x86?
>>>>>> Actually, the draft patch I sent you did not boot on my SMP box to=
day,
>>>>>> so qemu seems to have been a bit too friendly. Knowing that, issui=
ng a
>>>>>> half-baked patch would have made no sense, so I finally refrained =
from
>>>>>> doing that. Since I'm now basically in love with the genirq layer =
(at
>>>>>> least for x86) compared to the utter mess that we had to endure
>>>>>> previously, I've decided to tackle the issue completely, and rewri=
te the
>>>>>> I-pipe interrupt flow in order to leverage it. Will post something=
 asap.
>>>>>>
>>>>> Ok, here we are. I've just merged 2.6.19-ipipe-1.6-00. It has been
>>>>> tested on a low-end classic Pentium 90Mhz, a dusty two-way Celeron
>>>>> 750Mhz, and on a terrible Celeron 1GHz oldish laptop. Looks ok so f=
ar,
>>>>> and even passed the horrid "dohell" test on the SMP box, just smili=
ng.
>>>>> However, I don't have the required hw at hand to check if our frien=
d the
>>>>> MSI support is not killing us once more. This said, the MSI support=
 in
>>>>> 2.6.19 also conforms to the genirq specs, so there's hope.
>>>>>
>>>>> The patch is available from the Adeos download area, and I've also
>>>>> committed it to the SVN trunk/.
>>>>>
>>>>> Feedback welcome,
>>>>>
>>>>> PS: I have the corresponding quilt-managed patches available upon
>>>>> request, to the people who want to use this work as a reference for=

>>>>> porting to other archs.
>>>> You mean that you have separate patches for the common and arch=20
>>>> dependent part.
>>> Mostly, yes. The patches are split by function, but this usually
>>> correlates with the noarch / arch-specific break down view too.
>>>
>>>>  That would be nice. I'm interested!
>>> http://download.gna.org/adeos/patches/v2.6/i386/split/
>>>
>>>>  As a consequence we=20
>>>> could provide separated patches in general and prepare-kernel.sh app=
lies=20
>>>> them in sequence. Just an idea for the future.
>>>>
>>> Problem is that we would have to store a set of patches for each Adeo=
s
>>> version/arch combo, instead of a single one. What advantage do you se=
e
>>> in breaking the Adeos patches down for prepare-kernel.sh?
>> Maintenance issues for the noarch part, e.g., if you fix a bug in the =

>> common part or add new features it's available for all arch.
>=20
> I think this should be easier once we have moved to git, pulling commit=
s
> is made simple (yeah, I'm late on this too...)

Ah, I just read the keyword: git! ;)

Rough idea from my side on a potential organisation of the git trees:

 o A generic I-pipe core tree that primarily targets git head (i.e. 2.6)
 o One branch for git head, pulls both from Linus' tree and the I-pipe
   core
 o One tree for each major 2.6 version in maintenance mode, pulls from
   related stable branch and I-pipe core (when applicable)
 o Only if required: a generic I-pipe core tree for 2.4
 o One tree for 2.4 head to maintain x86
 o One tree for 2.4 ELDK to maintain PPC

Quite a lot trees... Do you this this may work?

Jan


--------------enig0541C9DD4624A962FADE3E67
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFcb75niDOoMHTA+kRAvM3AJ9QAc6TgodlC2FnA9V9+bg/5UCxewCfcj/W
xP3mGQOq2WXBzPuVquCr44s=
=ZELb
-----END PGP SIGNATURE-----

--------------enig0541C9DD4624A962FADE3E67--

