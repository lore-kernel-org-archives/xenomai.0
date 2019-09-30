Subject: Re: Problem with _rt / _nrt functions in Xeno 3
References: <CAFc1U0sBsAvi3Spz6+9ExCr1gpkB81BTjVC31G84WKyfbwPBmg@mail.gmail.com>
 <15646031-7d6c-2e9b-2ed7-0cee06a2d149@siemens.com>
 <CAFc1U0t6ggrybDhz1BpHNXq5iJC9nemDL4cxv+eqswyzC3zoJw@mail.gmail.com>
 <f8cb47b5-bfd1-cc7e-9d42-0243d31caf0a@siemens.com>
 <CAFc1U0sU1ZjGi5eFR-gjCdSbGGNqNOTpO5HVDNY8iNs+pa627Q@mail.gmail.com>
 <fad7d3e1-5958-54ec-6bf9-c069a23379cb@siemens.com>
 <CAFc1U0v1WUTsPQP9xDPT9gkgU-p+ALQV64aPzOqhsAADqCsVbw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <929b3eb9-9ef2-9738-3e3e-90bf01d26484@siemens.com>
Date: Mon, 30 Sep 2019 17:18:46 +0200
MIME-Version: 1.0
In-Reply-To: <CAFc1U0v1WUTsPQP9xDPT9gkgU-p+ALQV64aPzOqhsAADqCsVbw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: xenomai@xenomai.org

On 30.09.19 17:12, Pierre FICHEUX wrote:
> How can I think of read/write as ioctl? very different parameters...
> 

/wrt domain switch control. OTH, there is generally no reason for signaling 
ENOSYS from any of them, like in the IOCTL cases, because there is only one 
reason to enter these calls. And then you know in advance if there is support 
for rt or nrt and can encode that already by providing a handler or not.

BTW, there are plenty of examples for read/write in the existing drivers.

Jan

> Le lun. 30 sept. 2019 à 16:44, Jan Kiszka <jan.kiszka@siemens.com 
> <mailto:jan.kiszka@siemens.com>> a écrit :
> 
>     On 30.09.19 16:15, Pierre FICHEUX wrote:
>      > Hi Jan,
>      >
>      > Actually it was  "clear" for me after reading some examples such
>      > as kernel/drivers/testing/rtdmtest.c.
> 
>     OK, that's good to hear.
> 
>      >
>      > Btw examples deal only with ioctl and I don't understand how it could
>     work for
>      > read/write (any example around??).
>      >
> 
>     Other handlers are actually a simple case of IOCTLs: Think of them as an IOCTL
>     handler which only accepts a single code, identical on both entry paths.
> 
>     Jan
> 
>      > regards
>      >
>      >
>      >
>      > Le lun. 23 sept. 2019 à 15:10, Jan Kiszka <jan.kiszka@siemens.com
>     <mailto:jan.kiszka@siemens.com>
>      > <mailto:jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>>> a écrit :
>      >
>      >     On 20.09.19 16:23, Pierre FICHEUX wrote:
>      >      > Thx for the answer bu I don't understand the first sentence
>     (because of
>      >     my  bad
>      >      > english :))
>      >      >
>      >      > What dou you mean with "Xenomai 3 prefers the RT patch of a RTDM
>     callback
>      >     over
>      >      > the NRT if the caller is
>      >      > a real-time task." ? What is a "patch of RTDM callback" ??
>      >
>      >     I actually have to correct myself: Since "cobalt/syscalls: allow for
>     handing
>      >     over mode selection to syscall handlers" (predates v3.0.3), RTDM
>     entry points
>      >     are supposed to have to original behavior again (call driver handler
>      >     corresponding to current caller mode first, then switch if handler
>     returns
>      >     -ENOSYS).
>      >
>      >     Maybe we need to look into your concrete case again if something else
>     changes
>      >     the migration pattern.
>      >
>      >     Jan
>      >
>      >      >
>      >      > Le ven. 20 sept. 2019 à 15:45, Jan Kiszka <jan.kiszka@siemens.com
>     <mailto:jan.kiszka@siemens.com>
>      >     <mailto:jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>>
>      >      > <mailto:jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>
>     <mailto:jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>>>> a écrit :
>      >      >
>      >      >     On 20.09.19 15:34, Pierre FICHEUX via Xenomai wrote:
>      >      >      > Hi all,
>      >      >      >
>      >      >      > I've been using RTDM _rt / _nrt functions for a long time
>     with Xenomai
>      >      >      > 2.6.x but it seems not to work (the same way ?) with Xenomai 3
>      >     (tested with
>      >      >      > several versions up to 3.0.8). Actually the _nrt driver
>     function
>      >     is never
>      >      >      > called (_rt is always called...). I wrote a simple example for
>      >     Xeno 2 and
>      >      >      > Xeno 3 available here:
>      >      >      >
>      >      >      > https://github.com/pficheux/xenomai_examples.git
>      >      >      >
>      >      >      > Here is the test on Raspberry Pi 3 (Xeno 3).
>      >      >      >
>      >      >      > # insmod rtdm_test.ko
>      >      >      >
>      >      >      > # ./xenomai_test
>      >      >      >
>      >      >      > [   47.661245] RTDM open:.
>      >      >      >
>      >      >      > [   47.667473] ioctl: RT
>      >      >      >
>      >      >      > [   47.672674] ioctl: RT
>      >      >      >
>      >      >      > [   48.667479] ioctl: RT
>      >      >      >
>      >      >      > [   48.678078] ioctl: RT
>      >      >      >
>      >      >      > [   49.667463] ioctl: RT
>      >      >      >
>      >      >      > [   49.683076] ioctl: RT
>      >      >      >
>      >      >      > [   50.667463] ioctl: RT
>      >      >      >
>      >      >      > [   50.687868] ioctl: RT
>      >      >      >
>      >      >      >
>      >      >      > Of course it works fine with Xenomai 2 (on Pi B+) :
>      >      >      >
>      >      >      > # insmod rtdm_test.ko
>      >      >      >
>      >      >      > # ./xenomai_test
>      >      >      >
>      >      >      > [  753.614275] RTDM open
>      >      >      >
>      >      >      > [  753.632852] ioctl: RT
>      >      >      >
>      >      >      > [  753.636779] ioctl: NRT
>      >      >      >
>      >      >      > [  755.632839] ioctl: RT
>      >      >      >
>      >      >      > [  755.640252] ioctl: NRT
>      >      >      >
>      >      >      > [  756.632841] ioctl: RT
>      >      >      >
>      >      >      > [  757.632838] ioctl: RT
>      >      >      >
>      >      >      > [  757.643779] ioctl: NRT
>      >      >      >
>      >      >      > [  758.632836] ioctl: RT
>      >      >      >
>      >      >      > Thx by advance for your help
>      >      >      >
>      >      >
>      >      >     Xenomai 3 prefers the RT patch of a RTDM callback over the NRT
>     if the
>      >     caller is
>      >      >     a real-time task. Xenomai 2 had an adaptive behavior where the
>      >     current state of
>      >      >     the caller defined that. This is a problem I also ran into
>     before and
>      >     proposed
>      >      >     to revert to the old behavior (in fact, we do that in one internal
>      >     deployment).
>      >      >     But there is also the point that preferring RT over NRT makes
>     sense
>      >     for many
>      >      >     scenarios.
>      >      >
>      >      >     Discussing this with Philippe back then on the list (I do not
>     find the
>      >      >     reference
>      >      >     ATM), we came to the conclusion that the better answer is to
>     allow the
>      >      >     driver to
>      >      >     declare which particular behavior a callback should have - in
>      >     contrast to doing
>      >      >     that in one way or the other at the top level, ie. on syscall
>     entry
>      >     of ioctl
>      >      >     etc. But I do not have a design for that yet, and I didn't want to
>      >     delay the
>      >      >     3.1
>      >      >     release further to finish that first.
>      >      >
>      >      >     What we could consider for 3.1 is adding a compile-time
>     configurable to
>      >      >     re-enable the old behavior at syscall level when a user needs it.
>      >     Then we could
>      >      >     later on (3.2) push that properly to the driver level and
>     remove the
>      >     control
>      >      >     again.
>      >      >
>      >      >     Jan
>      >      >
>      >      >     --
>      >      >     Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>      >      >     Corporate Competence Center Embedded Linux
>      >      >
>      >      >
>      >      >
>      >      > --
>      >      >
>      >      > Pierre FICHEUX -/- CTO Smile ECS, France
>     -\-pierre.ficheux@smile.fr <mailto:pierre.ficheux@smile.fr>
>      >     <mailto:pierre.ficheux@smile.fr <mailto:pierre.ficheux@smile.fr>> 
>     <mailto:pierre.ficheux@smile.fr <mailto:pierre.ficheux@smile.fr>
>      >     <mailto:pierre.ficheux@smile.fr <mailto:pierre.ficheux@smile.fr>>>
>      >      > http://www.smile.fr  <http://www.smile.fr/>
>      >      > https://smile.eu/fr/offres/embarque-iot
>      >      > I would love to change the world, but they won't give me the
>     source code
>      >      >
>      >
>      >     --
>      >     Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>      >     Corporate Competence Center Embedded Linux
>      >
>      >
>      >
>      > --
>      >
>      > Pierre FICHEUX -/- CTO Smile ECS, France -\-pierre.ficheux@smile.fr
>     <mailto:pierre.ficheux@smile.fr>  <mailto:pierre.ficheux@smile.fr
>     <mailto:pierre.ficheux@smile.fr>>
>      > http://www.smile.fr  <http://www.smile.fr/>
>      > https://smile.eu/fr/offres/embarque-iot
>      > I would love to change the world, but they won't give me the source code
>      >
> 
>     -- 
>     Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>     Corporate Competence Center Embedded Linux
> 
> 
> 
> -- 
> 
> Pierre FICHEUX -/- CTO Smile ECS, France -\-pierre.ficheux@smile.fr  <mailto:pierre.ficheux@smile.fr>
>                               http://www.smile.fr  <http://www.smile.fr/>
>                               https://smile.eu/fr/offres/embarque-iot
> I would love to change the world, but they won't give me the source code
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

