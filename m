Message-ID: <50DCA303.7090303@xenomai.org>
Date: Thu, 27 Dec 2012 20:35:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAFjfccCyg_nbnNB3UGxEbWy3+SV+wp9T5iuj87DBN1Do08C7DQ@mail.gmail.com>
	<loom.20121227T200150-371@post.gmane.org>
In-Reply-To: <loom.20121227T200150-371@post.gmane.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Kernel compilation error due to Adeos patch error in
 'io_apic.c'
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wim <wim@hidof.com>
Cc: xenomai@xenomai.org

On 12/27/2012 08:06 PM, Wim wrote:

> =20
>> Vanilla Kernel: 3.2.21
>> Adeos Patch: ipipe-core-3.2.21-x86-1.patch
>> gcc --version: 4.7.0
>> Xenomai Version: 2.6.1
>>
>> Patch applies itself cleanly.
>>
>> Compilation error during initial kernel 'make':
>> arch/x86/kernel/apic/io_apic.c: In function
>> =E2=80=98irq_remap_modify_chip_defaults=E2=80=99:
>> arch/x86/kernel/apic/io_apic.c:2763:1: error: expected expression befo=
re
>> =E2=80=98}=E2=80=99 token
>>
>> Problem:
>> Commas instead of semi-colons at the end of lines inside CONFIG_IPIPE =
'if'
>> directives in 'io_apic.c'.
>=20
>=20
>=20
> Thanks Steve, this really helped! =20
>=20
> I can confirm that this problem still exists with yesterday's =20
> stable Xenomai release 2.6.2, ipipe-core-3.2.21-x86-2.patch, a vanilla =
3.2.21=20
> kernel, ang gcc 4.6.3 on Ubuntu 12.04.


Ok, do you have the issue with I-pipe core 3.4 and 3.5 ?


--=20
                                                                Gilles.


