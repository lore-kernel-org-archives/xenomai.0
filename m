From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 1 Oct 2014 17:43:15 -0400
Message-ID: <20141001214315.GJ4435@csclub.uwaterloo.ca>
References: <20141001150206.GB4435@csclub.uwaterloo.ca>
 <542C1DA3.8080306@xenomai.org>
 <20141001154641.GC4435@csclub.uwaterloo.ca>
 <20141001155252.GD4435@csclub.uwaterloo.ca>
 <20141001160219.GE4435@csclub.uwaterloo.ca>
 <542C3A89.7000307@xenomai.org>
 <20141001174029.GF4435@csclub.uwaterloo.ca>
 <542C3DF7.90804@xenomai.org>
 <20141001175437.GG4435@csclub.uwaterloo.ca>
 <542C748E.7080706@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <542C748E.7080706@xenomai.org>
Subject: Re: [Xenomai] I-pipe error when requesting irq that is on omap gpio
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Oct 01, 2014 at 11:39:26PM +0200, Gilles Chanteperdrix wrote:
> Well, what is on the other end of the GPIO ? If this is a button, you
> may want to set the interrupt type to edge, otherwise the interrupt will
> remain asserted as long as you press the button, and you will get an
> interrupt storm. If it is another GPIO, then you should reset that GPIO
> state in the irq handler.

No it is a marvell switch chip.  And it is in fact level triggered.
And it does clear when handled.

And I could probably get a button hooked up for testing, and just use
the debouncing feature in the gpio system to make it more manageable.

I am still not convinced the gpio-omap doesn't have a problem, but maybe
it is OK.

> Also, it may actually be simpler to write an RTDM driver than to use the
> deprecated, error-prone rtintr API.

Fair enough.  May have to consider that.  At the moment the system is
polling the switch chip given the IRQ isn't working yet, so idially we
want it working, but it isn't preventing things from working completely.

I will have a look at the rtdm stuff.

-- 
Len Sorensen

