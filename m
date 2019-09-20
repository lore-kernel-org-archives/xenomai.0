MIME-Version: 1.0
References: <CAFc1U0sBsAvi3Spz6+9ExCr1gpkB81BTjVC31G84WKyfbwPBmg@mail.gmail.com>
 <15646031-7d6c-2e9b-2ed7-0cee06a2d149@siemens.com>
 <CAFc1U0t6ggrybDhz1BpHNXq5iJC9nemDL4cxv+eqswyzC3zoJw@mail.gmail.com>
In-Reply-To: <CAFc1U0t6ggrybDhz1BpHNXq5iJC9nemDL4cxv+eqswyzC3zoJw@mail.gmail.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Fri, 20 Sep 2019 16:29:52 +0200
Message-ID: <CAFc1U0tciiB9JSL-43C89xg0j=8VSjPX65=0unEJ2qxUtEXsWQ@mail.gmail.com>
Subject: Re: Problem with _rt / _nrt functions in Xeno 3
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Didn't see any reference of it in
https://xenomai.org/documentation/xenomai-3/html/MIGRATION (?)

regards

Le ven. 20 sept. 2019 =C3=A0 16:23, Pierre FICHEUX <pierre.ficheux@smile.fr=
> a
=C3=A9crit :

> Thx for the answer bu I don't understand the first sentence (because of
> my  bad english :))
>
> What dou you mean with "Xenomai 3 prefers the RT patch of a RTDM callback
> over the NRT if the caller is
> a real-time task." ? What is a "patch of RTDM callback" ??
>
> Le ven. 20 sept. 2019 =C3=A0 15:45, Jan Kiszka <jan.kiszka@siemens.com> a
> =C3=A9crit :
>
>> On 20.09.19 15:34, Pierre FICHEUX via Xenomai wrote:
>> > Hi all,
>> >
>> > I've been using RTDM _rt / _nrt functions for a long time with Xenomai
>> > 2.6.x but it seems not to work (the same way ?) with Xenomai 3 (tested
>> with
>> > several versions up to 3.0.8). Actually the _nrt driver function is
>> never
>> > called (_rt is always called...). I wrote a simple example for Xeno 2
>> and
>> > Xeno 3 available here:
>> >
>> > https://github.com/pficheux/xenomai_examples.git
>> >
>> > Here is the test on Raspberry Pi 3 (Xeno 3).
>> >
>> > # insmod rtdm_test.ko
>> >
>> > # ./xenomai_test
>> >
>> > [   47.661245] RTDM open:.
>> >
>> > [   47.667473] ioctl: RT
>> >
>> > [   47.672674] ioctl: RT
>> >
>> > [   48.667479] ioctl: RT
>> >
>> > [   48.678078] ioctl: RT
>> >
>> > [   49.667463] ioctl: RT
>> >
>> > [   49.683076] ioctl: RT
>> >
>> > [   50.667463] ioctl: RT
>> >
>> > [   50.687868] ioctl: RT
>> >
>> >
>> > Of course it works fine with Xenomai 2 (on Pi B+) :
>> >
>> > # insmod rtdm_test.ko
>> >
>> > # ./xenomai_test
>> >
>> > [  753.614275] RTDM open
>> >
>> > [  753.632852] ioctl: RT
>> >
>> > [  753.636779] ioctl: NRT
>> >
>> > [  755.632839] ioctl: RT
>> >
>> > [  755.640252] ioctl: NRT
>> >
>> > [  756.632841] ioctl: RT
>> >
>> > [  757.632838] ioctl: RT
>> >
>> > [  757.643779] ioctl: NRT
>> >
>> > [  758.632836] ioctl: RT
>> >
>> > Thx by advance for your help
>> >
>>
>> Xenomai 3 prefers the RT patch of a RTDM callback over the NRT if the
>> caller is
>> a real-time task. Xenomai 2 had an adaptive behavior where the current
>> state of
>> the caller defined that. This is a problem I also ran into before and
>> proposed
>> to revert to the old behavior (in fact, we do that in one internal
>> deployment).
>> But there is also the point that preferring RT over NRT makes sense for
>> many
>> scenarios.
>>
>> Discussing this with Philippe back then on the list (I do not find the
>> reference
>> ATM), we came to the conclusion that the better answer is to allow the
>> driver to
>> declare which particular behavior a callback should have - in contrast t=
o
>> doing
>> that in one way or the other at the top level, ie. on syscall entry of
>> ioctl
>> etc. But I do not have a design for that yet, and I didn't want to delay
>> the 3.1
>> release further to finish that first.
>>
>> What we could consider for 3.1 is adding a compile-time configurable to
>> re-enable the old behavior at syscall level when a user needs it. Then w=
e
>> could
>> later on (3.2) push that properly to the driver level and remove the
>> control again.
>>
>> Jan
>>
>> --
>> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>> Corporate Competence Center Embedded Linux
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
>

--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
