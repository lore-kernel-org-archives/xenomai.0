Date: Mon, 5 Feb 2018 11:52:55 -0500
Message-ID: <20180205165255.2xd4vusp5djejrhh@csclub.uwaterloo.ca>
References: <CALLqZ8QsQAox-UO_r-did=GDML2Dkm3Yx4VVObmOCHy-uS6ndg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALLqZ8QsQAox-UO_r-did=GDML2Dkm3Yx4VVObmOCHy-uS6ndg@mail.gmail.com>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: [Xenomai] Reference Board
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Feb 05, 2018 at 11:22:46AM -0500, Greg Gallagher wrote:
> Hi,
>    After the recent meet up we had, I had an idea to help with a
> couple of issues that we identified.  One issue that was brought up is
> new users don't know how to get started with Xenomai, this impacts the
> community of users and downstream feedback we get.  To help this
> problem I'm proposing we choose one hardware board (maybe more later)
> that we would ensure has proper Xenomai support.
>    This would ensure that new users are able to try out Xenomai on
> real hardware and we (the Xenomai community) can make sure that it
> works well and gives new users a great experience as they get started
> with Xenomai.  Based on popularity and availability I suggest we start
> with the Raspberry PI family of boards.  They are pretty common and
> most people of this list probably have one or two (because of an
> office clean out at work, I now have almost one of each variant).  The
> wide availability would make it easy to (eventually) distribute the
> testing across interested contributors and new Xenomai users.
>    The other nice benefit is the ability to test and maintain a good
> set of example drivers for the raspberry PI platform.  We can ensure
> that these RTDM drivers are using the most up to date interfaces and
> best practices.  These could be examples that we point developers to
> when they try to create RTDM drivers for their own platform.  I did a
> quick audit of what we currently support today in Xenomai for
> raspberry pi and we are only 3-4 drivers away from supporting most of
> what's on the board.  Video drivers, GPU etc would be left to only the
> Linux domain for now.
> Creating and easy to use getting started wiki around the raspberry pi
> would give us the ability to create interesting examples using Xenomai
> that controls real hardware.  We could provide pre-built images based
> on either buildroot or Ubuntu (I've done both of these for different
> pi boards with good success).  This would give new users the ability
> to get their hands dirty pretty quickly and with out having to build
> everything from scratch.  Once they get comfortable with Xenomai then
> they can move into building it from scratch and replacing bits and
> pieces of the stock images.
>    The cost of doing this may seem steep at first, but I'm willing to
> take on a good chunk of the work and then hopefully the maintenance
> and testing won't prove to be too bad.  As the idea becomes more clear
> hopefully other users or developers will help out.  The benefit of
> doing this I believe will help with the ability to build a community
> around Xenomai and start to create a larger base of downstream users.
> 
>    If we think this is a good path to go down, I can post some more
> information on what I've already started and what needs to be done.
> Discussion and feedback would be appreciated :)

So would that be the Pi, Pi 2 or Pi 3?  A, or B or Zero?

-- 
Len Sorensen

