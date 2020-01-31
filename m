MIME-Version: 1.0
References: <CAMJ=MEd18keoeV3DQZ5Z+CjKWEYqRfHPLp=bM=65tvW6518CAA@mail.gmail.com>
 <619c981a-d855-b51c-0c50-ab6b140b08ff@siemens.com>
In-Reply-To: <619c981a-d855-b51c-0c50-ab6b140b08ff@siemens.com>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Fri, 31 Jan 2020 12:37:09 +0100
Message-ID: <CAMJ=MEfe8t-+2aojcZ_JSsZfRCrTRWbDkccfxtPRuGtaWhYvEA@mail.gmail.com>
Subject: Re: bug in eventobj_wait when using EVOBJ_ALL mode
Content-Type: text/plain; charset="UTF-8"
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

Op vr 31 jan. 2020 om 11:41 schreef Jan Kiszka <jan.kiszka@siemens.com>:
>
> On 31.01.20 10:46, Ronny Meeus via Xenomai wrote:
> > Hello
> >
> > Following patch corrects an issue when passing the EVOBJ_ALL mode to the
> > eventobj_wait function.
> >
> > The expected behavior of this function to my understanding is:
> > eventobj_wait in EVOBJ_ALL mode is supposed to return when all the bits
> > specified by the caller are set in core.value (=pending events).
> > The state of the other bits in core.value is not relevant.
> >
> > The current behavior is that it returns when all bits are set AND no
> > other events
> > are pending in the core.value, which is not correct in my opinion.
> >
> > diff --git a/lib/copperplate/eventobj.c b/lib/copperplate/eventobj.c
> > --- a/lib/copperplate/eventobj.c
> > +++ b/lib/copperplate/eventobj.c
> > @@ -217,7 +217,7 @@ int eventobj_wait(struct eventobj *evobj
> >          }
> >
> >          waitval = evobj->EVOBJ_ANY & bits;
>                              ^^^^^^^^^
> Looks like you either hand-edited the patch, or there is something
> broken in your repo.

I think I changed the code by accident in the mail since the patch in my
repo is correct.

>
> > -       testval = mode & EVOBJ_ANY ? waitval : evobj->core.value;
> > +       testval = mode & EVOBJ_ANY ? waitval : bits;
> >
> >          if (waitval && waitval == testval) {
> >                  *bits_r = waitval;
> >
>
> This looks indeed like a bug, also present in the corresponding cobalt
> kernel logic. Can you enhance lib/alchemy/testsuite/event-1.c to cover
> this case and provide a patch for both paths?

I can look into it but at this moment I have no time for it.
Next to that I will also not be able to run the cobalt test since I have no
environment for that.
>
> Thanks,
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

