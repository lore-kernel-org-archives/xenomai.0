Date: Tue, 24 Feb 2015 13:50:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150224125027.GA13354@hermes.click-hack.org>
References: <CAB6vvjmqqX1_NbPLDOmwkd=htsC+z3b99H8BwSYXgRYhXty+=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB6vvjmqqX1_NbPLDOmwkd=htsC+z3b99H8BwSYXgRYhXty+=A@mail.gmail.com>
Subject: Re: [Xenomai] rtnet issue with xenomai-3.git next branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Antoine Hoarau <hoarau.robotics@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On Tue, Feb 24, 2015 at 10:39:48AM +0000, Antoine Hoarau wrote:
> > Please stay on the list.
> My bad.
> >Ok, maybe a consequence of the udp module bug. Please try again with
> >the patch applied, and if you still get the bug, we will investigate
> >further. Please try and enable frame pointers so as to get more
> >meaningful stack traces.
> I tried the patch, rtudp is now correctly loaded, but et rtnet start, the
> system hangs, and I can't print/see any kernel debug...

Ok, could you try and load the modules manually to check which one
is causing issues ?

-- 
					    Gilles.

