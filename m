From: Wolfgang Denk <wd@denx.de>
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
In-reply-to: <71b1c406-6eb5-8c62-36e6-c48341bafa75@opersys.com>
References: <20180208145121.7551c081@mmd1pvb1c.ad001.siemens.net>
 <20180209110028.285442406CD@gemini.denx.de>
 <71b1c406-6eb5-8c62-36e6-c48341bafa75@opersys.com>
Date: Fri, 09 Feb 2018 17:45:43 +0100
Message-Id: <20180209164543.E16882406CD@gemini.denx.de>
Subject: Re: [Xenomai] Xenomai community meeting 2018, meeting minutes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Karim Yaghmour <karim.yaghmour@opersys.com>
Cc: "Kiszka, Jan (CT RDA IOT SES-DE)" <jan.kiszka@siemens.com>, Steven Seeger <steven.seeger@nasa.gov>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Dear Karim,

In message <71b1c406-6eb5-8c62-36e6-c48341bafa75@opersys.com> you wrote:
> 
> >>    - usage stats could be extracted from our website, downloads,
> >>      mailinglists
> > 
> > We have to be very careful here.  German law is pretty strict about
> > what you can (or rather must not) do with such data...
> 
> I'm obviously not in a position to provide any sort of legal advice nor 
> would I recommend violating any laws. However, it would probably be 
> worth getting some specifics on this instead of just shying away because 
> of an unspecified potential issue. The point is, it's my understanding 
> that there would be no selling nor advertising of this nor use for any 
> commercial purpose. The only purpose here is to get a better 
> understanding of who is using Xenomai and where they are physically 
> located to plan activities accordingly and provide a more accurate 
> picture to the larger open source community as to the composition of the 
> Xenomai user-base.

This is not intended to "shy away" anybody.  But the laws are really
strict. Yes,we can easily generate information like numners of
downloads or such, without problems.  But just storing accessing IP
addresses (even whenyou never ever disclose these to anybody) means
you are storing pesonal information, and you might require
permission from the accessing user.  So for exmaple trying to
evaluate accessing domain names to generate statistics about the
number of companies who are interested in Xenomai would be something
which I would not do without prior legal clearance.

> > I doubt this will actually work.  In my experience, there is a
> > pretty large base of users who intentionally do NOT advertise their
> > use of Xenomai.
> 
> That's a good point. Still, Xenomai has historically suffered from 
> having a primarily "anonymous" user base. Yet, that user base is 
> hampered by the lack of seeming traction given that few are willing to 
> "endorse" the project.

This is only natural, I think. We are not one of the classic open
source communities like Linux of U-Boot have.  You don't run Xenomai
on your toy project to scratch some private itches.  Xenomai is
intended for and primarily applied in industrial environments.
The overwhelming majority of Xenomai users known to me don't do this
for fun, but for business. And many of them are not permitted to
disclose any details of their work, often not even the name of the
company.  This has not much to do with being willing or not, but
with being permitted.

> That's the core issue. If no one is going to show public and strong 
> support for this project, it's going to be close to impossible to show 
> the value of the project to the wider open source community, especially 
> the Linux kernel developers. The project's value can only be argued for 
> so long simply based on logical arguments when compared to other approaches.

This problem is as old as Xenomai.  We tried before to overcome
this, for example with the first (and so far only, sic!) Xenomai
User's Meeting of 2009 where we were actually able to find a few
companies willing to publicly confirm their use of Xenomai ([1]).
We did a number of projects based on Xenomai since, and please
don't assume that we did not try to get more such publicity.

I really don't want to discourage you, but please don't hold your
breath!

[1] http://www.denx.de/en/News/Xum2009AbstractsAndPresentations


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If a train station is a place where a train stops,
                                           then what's a workstation?

