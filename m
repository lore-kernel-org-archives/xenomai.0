Date: Mon, 22 Feb 2021 17:19:00 -0300
From: Gabriel Dinse <gabriel_dinse@hotmail.com>
Subject: Re: Incompatible pointer type error when compiling kernel
Message-ID: <SN6PR08MB5661C3C2C5B38134D7D9946493819@SN6PR08MB5661.namprd08.prod.outlook.com>
In-Reply-To: <CALLqZ8QsOrU62afZpPck=rJWCpnjtVVRs94Zkzg3SW8YwBqWrA@mail.gmail.com>
References: <SN6PR08MB56613FE5201E248CC7901EB093819@SN6PR08MB5661.namprd08.prod.outlook.com>
 <CALLqZ8QsOrU62afZpPck=rJWCpnjtVVRs94Zkzg3SW8YwBqWrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: xenomai@xenomai.org



On Mon, Feb 22, 2021 at 9:12 am, Greg Gallagher <greg@embeddedgreg.com>=20
wrote:
>=20
>=20
> On Mon, Feb 22, 2021 at 5:15 AM Gabriel Dinse via Xenomai=20
> <xenomai@xenomai.org <mailto:xenomai@xenomai.org>> wrote:
>>  > This is a 32-bit build running on the rpi3?
>>  Yes, it is
>>=20
>>   > I have some ipipe fixes coming, but I don't think these are ipipe
>>  related.
>>   > Can you show how you patched and built your kernel? I'll try to
>>  reproduce
>>   > on my end.  What compiler are you using?
>>=20
>>  For patching the kernel, I did:
>>  xenomai-3.1 on =EE=82=A0 main =E2=9E=9C ./scripts/prepare-kernel.sh
>>  --linux=3D~/Projects/linux-kernels/linux-5.4.93-ipipe --arch=3Darm
>>  --ipipe=3D~/Projects/linux-kernels/ipipe-core-5.4.93-arm-0.patch
>>=20
>>  The config I'm using is multi_v7_defconfig modified a little bit.=20
>> The
>>  same configuration was fine for Vanilla kernel using the same=20
>> version
>>  (5.4.93), as I was pretending to compare both.
>>=20
>>  Toolchain I'm using, selected directly on buildroot-2020.02.11 long
>>  term is: Linaro ARM 2018.05
>=20
> Okay, I used that defconfig during the port so there shouldn=E2=80=99t be=
 a=20
> problem. Let me try with my repos and I=E2=80=99ll let you know shortly.
>=20

Ok, sure
Let me know if I need to change configuration on my side from compiling=20
it again.

> -Greg
>>=20
>>=20

