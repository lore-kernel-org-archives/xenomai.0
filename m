MIME-Version: 1.0
References: <20200131152713.1811748-1-rpm@xenomai.org>
 <0c811fd4-dc46-0bce-99b3-64c150725d3d@siemens.com>
 <230535ea0245408dbd941bc26c4f6df9@intel.com>
 <bbab7ccf-0f5e-617a-2d94-afc79f2d7efa@siemens.com>
In-Reply-To: <bbab7ccf-0f5e-617a-2d94-afc79f2d7efa@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Fri, 31 Jan 2020 14:20:33 -0500
Message-ID: <CALLqZ8Qk-BEuYjYtRpqkTVT5N9iWJHpU=3n109jCMCy4Yd_8TA@mail.gmail.com>
Subject: Re: [PATCH 0/8] Assorted fixes
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
Cc: "Meng, Fino" <fino.meng@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

HI,


On Fri, Jan 31, 2020 at 12:53 PM Jan Kiszka via Xenomai
<xenomai@xenomai.org> wrote:
>
> Hi Fino,
>
> On 31.01.20 17:25, Meng, Fino wrote:
> > Hi Jan
> >
> > Regarding to torture tests, do we have a recommend test suite & working flow  from the community?
> > I searched xenomai wiki but didn't find a guide for this.
>
> Out testing leaves a bit of room for improvement, but it is getting
> better. What we have so far is the smokey testsuite which is part of
> many of our test runs. It has some shortcomings, e.g. unstructured
> reporting, but it is at least a baseline. There are some further tests,
> like switchtest, that are also included when running xeno-test. And then
> there are loose ends like lib/*/testsuite that should probably be hooked up.
Is there anything on the wiki with what tests are needed or what area
we need to focus on for unit tests?

>
> > We plan to recommend UP Extreme board (https://up-board.org/up-xtreme/)  to public users since it's easy to buy for anyone
> > And we want to write a guide for torture test, at least for these boards,
>
> Defining reference boards is indeed another topic. I think we started
> that at some point on the list, but it did not go very far.

IMHO, based on what people on the list are posting as boards being
used, beaglebone black or similar variant, raspberry-pi 2b  or
Zynq-7000 would be good choices for arm boards.  Raspberry pi 3 and
possibly Ultra96 for the ARM64 variants?  I have these boards on hand
and would help out with testing as I can.
>
> On x86, the situation is rather comfortable as the reference image we
> produce with xenomai-images works well on many boards and larger
> systems. I don't have an UP board around but many products that have at
> least similar SoCs. We once played with a Minnow board but that was,
> well, not recommendable. The UP Xtreme could be another option.

> The next level is then automated execution of tests. There are many
> ways, the one we are preparing so far is LAVA-based. Quirin started that
> in
> https://code.siemens.com/ebsy/debian/xenomai-images/tree/master/tests.
> He is busy the next weeks but he wants to follow-up on that with more
> details afterwards so that we can discuss in the community if that could
> become an official pattern for Xenomai.
>
I like the idea of Lava, would there be extra hardware needed if
someone wanted to create the test setup at home?
I can't access the link above, is it possible to open that link up to
the public?

> Any comments, suggestions in this area are of course welcome!
>
> Thanks,
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>

