Date: Fri, 26 Oct 2012 14:36:34 +0200
From: Nicholas Mc Guire <der.herr@hofr.at>
Message-ID: <20121026123634.GA28381@opentech.at>
References: <CAMVghhVFiQNbPLgS5zpLw7Bu5t9mxdY5U9htVOOrRxQt_RWgVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMVghhVFiQNbPLgS5zpLw7Bu5t9mxdY5U9htVOOrRxQt_RWgVQ@mail.gmail.com>
Subject: Re: [Xenomai] Seeking recommendations for SBC with precision timer
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Howard Lee Harkness <howard.lee.harkness@gmail.com>
Cc: xenomai@xenomai.org

On Fri, 26 Oct 2012, Howard Lee Harkness wrote:

> I have a client requirement for a system that can handle hard real time
> with precision timing, and I'm looking for recommendations for a SBC to
> support it. Here's what is needed:
> 
> 1) x86 architecture

fanless ?

> 2) support for Linux (I will probably be using Xenomai)
> 3) precision timer with 1 us resolution

many systems will be able to give you a timer reolution of <=1us
but there is no system that will bee able to timstamp an event with
that precission - that is any timestamp you get will have an
uncertenty atleast in the range of a few microseconds to a few
tens of microseconds (thats independent of using Xenomai, Preept-RT
or RTAI)

> 4) PC/104 bus
> 5) lots of I/O (USB 2, I2C, SPI, GPIB, etc)
> 
> Anybody here have any experience with a board that has all this?

it does to some extent depend on the "etc" of the "lots of I/O" unless you
are good with it all being stacked on the PC/104.

you might want to look at the boards in the http:/www.OSADL.org/QA, unfortunately not xenomai based systems in the farm but the jitter/latency numbers will most likely hold for Xenomai based systems with negligable offsets.

thx!
hofrat


