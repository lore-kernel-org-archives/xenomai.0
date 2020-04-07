MIME-Version: 1.0
References: <CAAvDm6Zsm-gF+HwBLx1jo4-WHHu37_YoPGOTvgey3FVeWVCMWA@mail.gmail.com>
 <03215306-db00-75ce-e473-3de10cb233e7@siemens.com>
 <CAFc1U0uz3hc5_crXa3ahrqOAWLpjA0FhDXMUGvQ4SY2=DRc4tA@mail.gmail.com>
In-Reply-To: <CAFc1U0uz3hc5_crXa3ahrqOAWLpjA0FhDXMUGvQ4SY2=DRc4tA@mail.gmail.com>
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Tue, 7 Apr 2020 19:16:10 +0800
Message-ID: <CAAvDm6aDZk8Nbidi_+HnLFxqVFXGC=k2Ln0nAwxbPr3M2q8F7w@mail.gmail.com>
Subject: Re: Is anybody can show me a simple rtdm driver to read/write virtual
 memory device?
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai <xenomai@xenomai.org>

Thanks, I'll check it out.

Pierre FICHEUX <pierre.ficheux@smile.fr> =E4=BA=8E2020=E5=B9=B44=E6=9C=887=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:34=E5=86=99=E9=81=93=EF=BC=
=9A

> Hi,
>
> I wrote some RTDM examples for Pi 3 GPIO (based on BCM register access,
> not GPIO kernel API).
>
> May be it could help...
>
> regards
>
> Le lun. 6 avr. 2020 =C3=A0 09:45, Jan Kiszka via Xenomai <xenomai@xenomai=
.org>
> a =C3=A9crit :
>
>> On 06.04.20 09:22, =E5=AD=99=E4=B8=96=E9=BE=99 via Xenomai wrote:
>> > Is anybody could show me a simple xenomai3 rtdm driver to read/write
>> > virtual memory device?
>> > A virtual memory device to:
>> >      write "hello world" to memory device in real real time(It's
>> appricate
>> > if the write operation could wake up the read task which allready
>> waited to
>> > read)
>> > read  the memory device in real time(It's appricate if the read
>> operation
>> > could wake up the write task which allready waited to write)
>> >
>>
>> What do you mean with "virtual memory"?
>>
>> If you are looking for a pattern how a driver implements read/write
>> callbacks, maybe study the serial drivers. They come closest to "simple"=
.
>>
>> Jan
>>
>> --
>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>> Corporate Competence Center Embedded Linux
>>
>>
>
> --
>
> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
>                              http://www.smile.fr
>                              https://smile.eu/fr/offres/embarque-iot
> I would love to change the world, but they won't give me the source code
>
>
