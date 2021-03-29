MIME-Version: 1.0
References: <CAFc1U0s93=zDEQA9X+QyGD=miNAHdhKVTwn0YPbsAAysChdMyA@mail.gmail.com>
 <CAFc1U0tfFRARvpZ4pWajwidipQ809dbORJZx10rv6rF7dZ3Nvw@mail.gmail.com>
 <CALLqZ8TEcPEyH9ZUMvOO6rSHPtzjZdGvrxCntW5OzwBRPGxngA@mail.gmail.com>
 <CAFc1U0t0EOejpmVsBQcnDzdBgmNbNYcxZbgbtMULKWt-0ECsAQ@mail.gmail.com>
In-Reply-To: <CAFc1U0t0EOejpmVsBQcnDzdBgmNbNYcxZbgbtMULKWt-0ECsAQ@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 29 Mar 2021 09:17:00 -0400
Message-ID: <CALLqZ8RQYv=+bDa=1KKqiRt+MMHCGRCbA+ynadEcaSwnf9nr0w@mail.gmail.com>
Subject: Re: Arm64 jitter
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
Cc: xenomai <xenomai@xenomai.org>

On Mon, Mar 29, 2021 at 8:06 AM Pierre FICHEUX <pierre.ficheux@smile.fr>
wrote:

> Hi Greg,
>
> Thks for the answer, so you're currently tracking the problem?
>
> Le lun. 29 mars 2021 =C3=A0 13:43, Greg Gallagher <greg@embeddedgreg.com>=
 a
> =C3=A9crit :
>
>>
>>
>> On Mon, Mar 29, 2021 at 5:22 AM Pierre FICHEUX via Xenomai <
>> xenomai@xenomai.org> wrote:
>>
>>> I mean Arm64 AND 5.x is recent !
>>>
>>> Le lun. 29 mars 2021 =C3=A0 11:20, Pierre FICHEUX <pierre.ficheux@smile=
.fr> a
>>> =C3=A9crit :
>>>
>>> > Hi all,
>>> >
>>> > I=E2=80=99ve been using Xenomai-3.1/I-pipe for several months on Pi 3=
 B/B+ with
>>> > mainline kernel (4.19.128 and 4.19.144, arm). I had good results
>>> (about 30
>>> > =C2=B5s jitter) with latency + dohell (or latency + hackbench).
>>> >
>>> > Unfortunately, a new arm64 test on  5.4.72 or 5.4.107
>>> > (ipipe-core-5.4.107-arm64-1 tag) leads to a  70 =C2=B5s jitter on the=
 same
>>> > board.
>>> >
>>> > I know I-pipe support is recent for arm64 but do you have any idea
>>> about
>>> > the problem? What are the results on other Arm64 boards such as iMX, =
or
>>> > OMAP ?
>>> >
>>> >
>>> > Please note, I removed the warnings about APM/ACPI/CPU freq/MIGRATION
>>> from
>>> > the kernel config.
>>> >
>>> >
>>> > Thx by advance
>>> >
>>> >
>>> > Regards
>>> >
>>> > --
>>> >
>>> > Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
>>> >                              http://www.smile.fr
>>> >                              https://smile.eu/fr/offres/embarque-iot
>>> > I would love to change the world, but they won't give me the source
>>> code
>>> >
>>> >
>>>
>>> --
>>>
>>> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
>>>                              http://www.smile.fr
>>>                              https://smile.eu/fr/offres/embarque-iot
>>> I would love to change the world, but they won't give me the source cod=
e
>>
>>
>> I test with Ultra96 board and have seen higher then normal. I=E2=80=99m =
using
>> ftrace to track down the source of the latency.
>>
>> -Greg
>>
>
>
> --
>
> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
>                              http://www.smile.fr
>                              https://smile.eu/fr/offres/embarque-iot
> I would love to change the world, but they won't give me the source code
>
> Hi Pierre,
  I have a hang to look at in arm64 qemu and then I=E2=80=99m getting back =
to
looking at what is causing the latency. The ultra96 is showing higher then
normal latency.
   I=E2=80=99m hoping to have some answers by the end of the week. A update=
d 4.19
release is on its way as well, but Im seeing good latency numbers with that
release.

-Greg

>
