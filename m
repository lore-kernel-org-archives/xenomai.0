Message-ID: <44343E71.30807@domain.hid>
Date: Thu, 06 Apr 2006 00:02:25 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Questions porting existing rtai-24.1.12 app to
	xenomai (PART II)
References: <1CFEB358338412458B21FAA0D78FE86D042A2FEE@rennsmail02.eu.thmulti.com>	<44328187.6080005@domain.hid>	<44327F66.10800@domain.hid>	<44329186.3080908@domain.hid>	<44329D27.1000400@domain.hid>	<4433DC01.6060104@domain.hid>
	<4433F441.2080309@domain.hid> <44342E91.4080007@domain.hid>
In-Reply-To: <44342E91.4080007@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Randy Smith <rsmith@domain.hid>
Cc: xenomai@xenomai.org

Randy Smith wrote:
>=20
>=20
> Philippe Gerum wrote:
>=20
>> Wrt 2.4 kernels, the project provides patches against snapshots of=20
>> Denx's development tree, accessible from=20
>> http://www.denx.de/en/Software/CVS. The date of the snapshot was=20
>> missing in the patch filenames, which introduced a fair amount of=20
>> confusion; this has been fixed in the repository. All 2.4-based Adeos=20
>> patches for ppc have been built against Denx's devel tree as of=20
>> 2005-11-09 so far. The Adeos version is always given by the trailing=20
>> rev. number of any patch filename, e.g. 1.0-04 is the latest Adeos=20
>> rev. for 2.4/ppc kernels.
>>
>> For 2.6/ppc kernels, we provide patches against vanilla kernel trees=20
>> as released by kernel.org.
>=20
> Thanks,  That clears that up.
>=20
>>
>> Ok, it's a bit early for Xmas gifts, but anyway, try this patch on=20
>> 2.4.25-11 as shipped with the ELDK 3.1:
>>
>> http://download.gna.org/adeos/patches/v2.4/ppc/adeos-ipipe-2.4.25-11-p=
pc-denx-1.0-04.patch=20
>>
>>
> I have downloaded the patch and will try it over the next few days and=20
> report back.  Thanks again and Feliz Navidad or perhaps I should say=20
> Joyeux No=EBl?
>

Joyeux No=EBl would be perfect. Merry Christmas to you too.
[Redshift effect is ongoing on Xenomai-core]

--=20

Philippe.

