MIME-Version: 1.0
References: <CAFc1U0s93=zDEQA9X+QyGD=miNAHdhKVTwn0YPbsAAysChdMyA@mail.gmail.com>
 <CAFc1U0tfFRARvpZ4pWajwidipQ809dbORJZx10rv6rF7dZ3Nvw@mail.gmail.com>
 <CALLqZ8TEcPEyH9ZUMvOO6rSHPtzjZdGvrxCntW5OzwBRPGxngA@mail.gmail.com>
 <CAFc1U0t0EOejpmVsBQcnDzdBgmNbNYcxZbgbtMULKWt-0ECsAQ@mail.gmail.com>
 <CALLqZ8RQYv=+bDa=1KKqiRt+MMHCGRCbA+ynadEcaSwnf9nr0w@mail.gmail.com>
 <CAFc1U0vL05ZNSP4G5S=aG2V_PRY041EHCop0p0xGFDEDSSWv4Q@mail.gmail.com>
 <CALLqZ8TJ2VqH7qRc=Kxy+3URveu=q2vcB7EbL1Z98-hUicrQMg@mail.gmail.com>
 <66c7ed10-b868-bf1c-7960-1d5094655546@gmail.com>
In-Reply-To: <66c7ed10-b868-bf1c-7960-1d5094655546@gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 5 Apr 2021 01:24:19 -0400
Message-ID: <CALLqZ8SVi6GasNB3x9ofJ-DbAK56yjjw6uj1j1FSfoc2Wa4fAw@mail.gmail.com>
Subject: Re: Arm64 jitter
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Robert Berger <xenomai.list@gmail.com>
Cc: Pierre FICHEUX <pierre.ficheux@smile.fr>, xenomai <xenomai@xenomai.org>

On Sun, Apr 4, 2021 at 4:49 PM Robert Berger <xenomai.list@gmail.com> wrote:

> Hi,
>
> My comments are in-line:
>
> On 02/04/2021 07:54, Greg Gallagher via Xenomai wrote:
> >>
> >>
> > Looks like this is affecting 4.19/5.4 arm and arm64.  Still
> investigating,
> > hopefully I'll have a root cause shortly.
>
> With cyclictest, stress-ng and a loadavg of over 12 I see a jitter of
> approx. 55 usec on an arm32: i.mx6 quad.
>
> Did not yet start testing on arm64.
>
> >
> > -Greg
> >
>
> Regards,
>
> Robert
>
Hi,

I think I've tracked down a couple issues that could be causing this.  I'll
hopefully have an update this week with a fix.

Thanks for testing,

Greg
