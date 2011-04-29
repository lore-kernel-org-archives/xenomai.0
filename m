Message-ID: <4DBA921F.60607@domain.hid>
Date: Fri, 29 Apr 2011 12:25:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <BANLkTi=ayVOVM5Zyag=mgK2S7QUc3_-oxw@domain.hid>
	<BANLkTinf+tfYG8s1RF6sN7ROOc8DLC6e-A@mail.gmail.com>
	<4DBA9065.1010507@domain.hid>
In-Reply-To: <4DBA9065.1010507@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Adeos-main] adeos-ipipe-2.6.37.6-x86-2.9-01.patch build fails
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: adeos-main@gna.org

On 2011-04-29 12:18, Jan Kiszka wrote:
> On 2011-04-29 11:48, Henri Roosen wrote:
>> Arch: x86
>> Kernel: 2.6.37.6
>> Config: see attachment.
>>
>> The build fails when CONFIG_X86_LOCAL_APIC is not defined:
>> arch/x86/kernel/ipipe.c:156: error: implicit declaration of function
>> =E2=80=98ipipe_apic_vector_irq=E2=80=99
>>
>> The attached patch fixes the problem but should be checked for correct=
ness!
>=20
> Right, mea culpa.
>=20
> Please just reorder the hunks to save one #ifdef.

Err, nonsense. Without an APIC there is also no IRQ_MOVE_CLEANUP_VECTOR
(because there is SMP, thus no IRQ migration). The whole function should
become void.

Jan

--=20
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

