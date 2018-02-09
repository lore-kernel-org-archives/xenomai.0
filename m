Date: Fri, 9 Feb 2018 14:02:30 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180209140230.0ff9a226@mmd1pvb1c.ad001.siemens.net>
In-Reply-To: <20180209110028.285442406CD@gemini.denx.de>
References: <20180208145121.7551c081@mmd1pvb1c.ad001.siemens.net>
 <20180209110028.285442406CD@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai community meeting 2018, meeting minutes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Denk <wd@denx.de>
Cc: "Kiszka, Jan (CT RDA IOT SES-DE)" <jan.kiszka@siemens.com>, Steven Seeger <steven.seeger@nasa.gov>, karim.yaghmour@opersys.com, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Am Fri, 9 Feb 2018 12:00:28 +0100
schrieb Wolfgang Denk <wd@denx.de>:

> Dear Henning,
> 
> In message <20180208145121.7551c081@mmd1pvb1c.ad001.siemens.net> you
> wrote:
> > 
> > on 02/02/18 we had an open community meeting in Brussels to discuss
> > topics around Xenomai. Both the recent development as well as plans
> > for the future.  
> 
> Thanks for the summary - it's a pity I was not able to attend.
> 
> > - open questions:
> >  Will issues, pull-request and wikis from gitlab be open?  
> 
> I think it would be beneficial to provide open access to registered
> users, so everybody can contribute with minimal effort.  The
> registration (and verification of the provided email address) is
> necessary to avoid spammers / wiki trolls.

We already discussed that elsewhere. Multiple channels can mean that
you get spammed with notifications, have to poll multiple channels,
miss information, or have to keep multiple channels in sync.

And the big problem with issues and all that magic is, that you bury
very valuable information in the depth of a web-application. Where it
might be very hard to extract it from and switch to something else.

If we are ok with the second point, we could just give it a try and
react if the first one becomes a problem.

> >  Will the website move into gitlab?  
> 
> Otherwise we will find ways to host that, too.
> 
> >   - usage stats could be extracted from our website, downloads,
> >     mailinglists  
> 
> We have to be very careful here.  German law is pretty strict about
> what you can (or rather must not) do with such data...
> 
> >    - for now we do not look at that and try to not be nosy  
> 
> I can't parse that?

What i wanted to say is that nobody looked at that yet, now that you
mentioned possible legal problems that is probably a good thing.

> >    - usage stats could be very useful for users as well
> >     - get an idea how popular Xenomai is
> >     - where in the world
> >     - which versions especially  
> 
> I doubt this will actually work.  In my experience, there is a
> pretty large base of users who intentionally do NOT advertise their
> use of Xenomai.

Using stats collected on our infrastructure is a way to work around
users silently consuming, that is why we talked about that topic. You
at least get an idea how many times i.e. a tarball got downloaded (like
on sourceforge)

> > Testing:
> > --------
> > - with the new hoster we will have gitlab-ci to control or run all
> >   sorts of tests
> > - at the end we would like to have all that in CI:
> >   - compile tests for all arches and multiple configs
> >   - full OS image generation for testing on reference boards
> >   - functional testing "smokey"
> >   - performance testing ("latency", "switch-test" etc. combined with
> >     stress, dd, ...)  
> 
> Heiko Schocher has such a system up and running for a few boards of
> our customers; it is based on his tbot test framework.  It's nothing
> too sophisticated yet, but at least he builds the images, runs the
> latency test, makes sure there are no overruns and verifies that a
> max value is not exceeded.  Heiko even generates some grpahics using
> gnuplot and includes this into the automatically generated PDF
> documentation.
> 
> Sorry, I can't show an example here as thi is customer specific, but
> the test cases itself are free, see [1].

I have a fork of tbot running here as well, i did not even know it was
used somewhere else. It was before my time at Siemens but i think Heiko
initially developed that for us.
Now i wanted to suggest to make that open-source ... but it is! I will
have to see what changed in there since and see whether my additions
could be useful for upstream.

> [We use a Yocto meta layer for Xenomai here.  This is pretty generic
> and has actually been submitted to mainline, but the steering
> committee still has to decide if there is interest to add it :-( ]
> 
> > - we will have to divide and conquer and start with the low-hanging
> >   fruits like compile-only  
> 
> Runtime tests are cheap as well if you find tbot [2], [3] is good
> enough for your purposes.  You can also run these under Jenins etc.
> easily [4]. I will ask Heiko to get this running on a BBB as well so
> we could even show it on the tbot2go setup [5]. Give me a week,
> please.
> 
> [1] https://github.com/hsdenx/tbot/tree/master/src/tc/linux/xenomai
> [2] https://www.tbot.tools/
> [3] https://github.com/hsdenx/tbot
> [4] http://www.tbot.tools/jenkins.html
> [5] http://www.tbot.tools/tbot2go.html
> 
> > - all testing infrastructure should be open, ideally contributers
> >   should be able to use it as well, or at least see the reports
> > - Gilles used to run a CI that could do a lot of the above
> >  - but that was pretty custom and would be hard to use/maintain
> > without Gilles ... given the code can still be found  
> 
> If you have a board to run the tests on, you can easily set up all
> needed infrastructure to use tbot for these purposes.  If you don't
> already have hardware that allows for remote console access and
> remote power cycling you can follow the tbot2go example for less
> than 100 Euro (and by just adding more relays, you can use one such
> setup for several boards, of course).

I guess i will have to check tbot mainline for sure, that all sounds
promising. I had planned to throw out tbot completely, because we
have an early prototype version of it. And i did not know it evolved
and is used anywhere else.

Henning
 
> Best regards,
> 
> Wolfgang Denk
> 


