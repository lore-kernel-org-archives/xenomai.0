Date: Sat, 13 Dec 2014 02:03:58 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141213010358.GD11058@hermes.click-hack.org>
References: <548B67E3.1090309@nta-inc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <548B67E3.1090309@nta-inc.net>
Subject: Re: [Xenomai] Add cards parameter to rt_e1000e module?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <jeff.webb@nta-inc.net>
Cc: Xenomai <xenomai@xenomai.org>

On Fri, Dec 12, 2014 at 04:10:43PM -0600, Jeff Webb wrote:
> The rtnet rt_e1000e module does not implement the 'cards'
> parameter. I have attached a patch for the 'next' branch of
> xenomai-3.git that adds this parameter, and it seems to work fine
> on my hardware. The code was ported straight from the rt_e1000
> module. My machine has two e1000e cards, so this is a useful
> feature for me. (I actually applied the same fix to the standard
> e1000e driver, which is even more useful to me, but I know it
> would be a maintenance nightmare for Xenomai to start maintaining
> that sort of patching...)

I understand the need for the "cards" parameter, but...
Is not there another way to solve this issue ? I do not know,
something in /proc or /sys to tell Linux to not load this driver for
that card? I suppose if we tell Linux to not use its driver for some
cards, then later loading the rtnet driver will be used for these
cards? Adding the cards parameter means that the rtnet drivers
diverge from mainline drivers, and so imply a maintenance cost. On
the other hand, maybe that is a cheaper one than trying and solving
the issue globally.

-- 
					    Gilles.

