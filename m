Message-ID: <43C62CFC.1060401@domain.hid>
Date: Thu, 12 Jan 2006 11:18:36 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: Xenomai broken on Linux 2.4
References: <43C61CC6.5090802@domain.hid> <43C61D87.1080301@domain.hid>
	<BCC969F7-8D97-46BD-A314-2153708D71AE@openwide.fr>
In-Reply-To: <BCC969F7-8D97-46BD-A314-2153708D71AE@openwide.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stelian Pop <stelian.pop@domain.hid>
Cc: xenomai@xenomai.org

Stelian Pop wrote:
>=20
> Le 12 janv. 06 =E0 10:12, Philippe Gerum a =E9crit :
>=20
>>
>> Hi Wolfgang,
>>
>> Wolfgang Grandegger wrote:
>>
>>> Hi Philippe,
>>> I just realized that recent changes in ksrc/arch/powerpc/switch.S =20
>>> have broken the build of Xenomai with linuxppc_2_4_devel on PPC:
>>>  #include <asm/offsets.h> does not exist
>>>  Symbols like SAVE_NVGPRS do not exist
>>>
>>
>> Ok, thanks for the info. I'm going to fix and check the 2.4/ppc  port=20
>> today.
>=20
>=20
> 2.6/ppc build fails in the same way. Correcting it to <linux/asm-=20
> offsets.h> fixes fixes it.
>

Forgot that pre-2.6.14 versions include asm/offsets.h, while post- ones n=
ow=20
include asm/asm-offsets. Ok, will fix. Thanks.

> Stelian.
>=20
>=20


--=20

Philippe.

