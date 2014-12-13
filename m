From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 12 Dec 2014 21:12:23 -0500
Message-ID: <20141213021223.GA24110@csclub.uwaterloo.ca>
References: <548B67E3.1090309@nta-inc.net>
 <20141213010358.GD11058@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141213010358.GD11058@hermes.click-hack.org>
Subject: Re: [Xenomai] Add cards parameter to rt_e1000e module?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On Sat, Dec 13, 2014 at 02:03:58AM +0100, Gilles Chanteperdrix wrote:
> I understand the need for the "cards" parameter, but...
> Is not there another way to solve this issue ? I do not know,
> something in /proc or /sys to tell Linux to not load this driver for
> that card? I suppose if we tell Linux to not use its driver for some
> cards, then later loading the rtnet driver will be used for these
> cards? Adding the cards parameter means that the rtnet drivers
> diverge from mainline drivers, and so imply a maintenance cost. On
> the other hand, maybe that is a cheaper one than trying and solving
> the issue globally.

Certainly a well behaved driver would not touch a device already handled
by a linux driver.  It should be possible to just issue an unbind request
to the linux driver for the desired device and then a bind request to
the rtnet driver to take over that device.

But I have not looked at rtnet, so I don't know how those behave compared
to linux drivers.

-- 
Len Sorensen

