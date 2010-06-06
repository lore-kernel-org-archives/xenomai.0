Message-ID: <4C0B478A.7060303@domain.hid>
Date: Sun, 06 Jun 2010 09:00:26 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4C037798.8070307@domain.hid>	<1275403262-23939-1-git-send-email-P.B.Cheblakov@domain.hid>	<4C051D3F.2030407@domain.hid>
	<4C0A8B94.7020207@domain.hid> <4C0ABA8F.8000104@domain.hid>
	<4C0ABE03.9000400@domain.hid>
In-Reply-To: <4C0ABE03.9000400@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PATCH V3] rtcan: add rtcan_plx_pci driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 06/05/2010 11:13 PM, Gilles Chanteperdrix wrote:
> Wolfgang Grandegger wrote:
>> On 06/05/2010 07:38 PM, Gilles Chanteperdrix wrote:
>>> P.B.Cheblakov wrote:
>>>> I'v=D1=83 merged fixes from Wolfgang for Kconfig and for warnings in=
 this=20
>>>> patch and tested it
>>> Thanks, but it seems we still have a few build issues:
>>> - the PCI IDs used by this patch are not available in old kernels
>>
>> OK, this can to be fixed with some "ifndef ..." lines. What kernel did
>> make problems?
>=20
> http://sisyphus.hd.free.fr/~gilles/bx

OK.

>>> - the I-pipe patches no longer apply on some stable releases.
>>
>> I don't understand this issue? What does it have to do with this drive=
r?
>=20
> Nothing. It simply showed up at the same time because I had not run the
> build test for some time.

Hm, the error message is quite clear:

prepare-kernel.sh: Unable to patch kernel 2.6.33.5 with adeos-ipipe-2.6.3=
3.4-powerpc-2.9-01.patch

But it's dissappointing that a successive extraversion breaks the patch.

Wolfgang.


