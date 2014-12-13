From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Sat, 13 Dec 2014 12:14:19 -0500
Message-ID: <20141213171419.GB24110@csclub.uwaterloo.ca>
References: <548B67E3.1090309@nta-inc.net>
 <20141213010358.GD11058@hermes.click-hack.org>
 <20141213021223.GA24110@csclub.uwaterloo.ca>
 <20141213051151.GE11058@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141213051151.GE11058@hermes.click-hack.org>
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

On Sat, Dec 13, 2014 at 06:11:51AM +0100, Gilles Chanteperdrix wrote:
> As all RTDM drivers, RTnet drivers are just linux drivers. The issue
> is to have a setup where two cards with the same chip are used by
> two different drivers. Linux does not have this problem, because it
> rarely has several drivers for the same chip. The problem with the
> bind/unbind solution is that the driver that will get all the cards
> first depends on the drivers initialization order. With the "cards"
> parameter, you do not have this issue.

Well I remember multiple drivers in the past for the tulip network chip,
and for a while there where two firewire drivers too.  Also those that
run xen with pci passthrough have the same issue of preventing linux
from grabbing a given device.

It would seem that just using bind/unbind and loading all the drivers,
user space could resolve the issue, but the cards parameter may be more
convinient, at the expense of having to add that to the driver of course.

-- 
Len Sorensen

