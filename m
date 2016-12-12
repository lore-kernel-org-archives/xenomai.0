References: <1481114381-17548-1-git-send-email-leupold@rsi-elektrotechnik.de>
 <965cb08c-9a13-da03-4cf5-060ce94cae6e@xenomai.org>
From: Jan Leupold <leupold@rsi-elektrotechnik.de>
Message-ID: <46ec47bc-286d-a206-ef85-6347ba095660@rsi-elektrotechnik.de>
Date: Mon, 12 Dec 2016 17:59:27 +0100
MIME-Version: 1.0
In-Reply-To: <965cb08c-9a13-da03-4cf5-060ce94cae6e@xenomai.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [PATCH] analogy: fix __a4l_get_sbsize() if device has
 only one subdevice
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Am 12.12.2016 um 16:55 schrieb Jorge Ramirez:
> On 12/07/2016 01:39 PM, Jan Leupold wrote:
>> All a4l_sbinfo_t are handled in __a4l_fill_desc() as a contiguous array
>> and is stored as data in a4l_root_t. The old code allocated enough
>> memory when the device had at least two subdevices, but missed 8 bytes
>> (on ARM32), which is the difference between sizeof(a4l_root_t) and
>> sizeof(a4l_leaf_t).
>=20
> sorry I dont understand this patch. could you expand on the scenario you
> are testing?

Scenario: one a4l device with exactly one a4l subdevice with one channel
and one range. A call to a4l_fill_desc() then returns -ENOMEM, which is
caused by a check at the beginning of a4l_leaf_add().

> a4l_root_setup already takes into consideration the size of the a4l_root_t
> (check the offset initialization)

My interpretation of what should be constructed in sbdata memory is this:

+---------------------------------
|r|s|s|s|s|...|s|l|c|c|c|...
+---------------------------------
                ^
r =3D a4l_root_t
s =3D a4l_sbinfo_t
l =3D a4l_leaf_t
c =3D a4l_chinfo_t

What I mean is: the root stores the whole array of all subdevice info and
its size must be "root + n * sbinfo" (this is where the ^ points to).
But __a4l_get_sbsize() is implemented as "n * (leaf + sbinfo)". root and
leaf differ in size.

As soon as the a4l device has more than one subdevice (n > 1) always enough
memory is allocated. But for n =3D=3D 1 the size difference between a4l_roo=
t_t
and a4l_leaf_t is not taken into account. a4l_root_setup() sets the offset
correctly according to sizeof(a4l_root_t), but __a4l_get_sbsize() used
sizeof(a4l_leaf_t) to calculate it.

Memory size for channel and range info is also calculated as
"n * (leaf + info)" and could be reduced to "leaf + n * info", but
out-of-memory is not an issue here.

>=20
>=20
>=20
>> ---
>>  lib/analogy/descriptor.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/analogy/descriptor.c b/lib/analogy/descriptor.c
>> index bc4d7bd..fa8cf93 100644
>> --- a/lib/analogy/descriptor.c
>> +++ b/lib/analogy/descriptor.c
>> @@ -100,8 +100,9 @@ static inline a4l_leaf_t *a4l_leaf_get(a4l_leaf_t * =
lf,
>>  static int __a4l_get_sbsize(int fd, a4l_desc_t * dsc)
>>  {
>>  	unsigned int i, j, nb_chan, nb_rng;
>> +	/* all subdevice a4l_sbinfo_t are within one special leaf: the root */
>>  	int ret, res =3D
>> -		dsc->nb_subd * (sizeof(a4l_sbinfo_t) + sizeof(a4l_leaf_t));
>> +		sizeof(a4l_root_t) + dsc->nb_subd * (sizeof(a4l_sbinfo_t));
>> =20
>>  	for (i =3D 0; i < dsc->nb_subd; i++) {
>> =20
>>
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai
>=20


--=20
_____________________________________________________________
R-S-I Elektrotechnik GmbH & Co. KG
Woelkestrasse 11
D-85301 Schweitenkirchen
Fon: +49 8444 9204-0
Fax: +49 8444 9204-50
www.rsi-elektrotechnik.de

_____________________________________________________________
Amtsgericht Ingolstadt - GmbH: HRB 191328 - KG: HRA 170363
Gesch=E4ftsf=FChrer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
USt-IdNr.: DE 128592548


