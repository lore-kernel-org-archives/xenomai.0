Message-ID: <521A991F.2020202@xenomai.org>
Date: Mon, 26 Aug 2013 01:54:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52138425.2030000@steinkuehler.net> <5213B7D3.5030606@xenomai.org>
	<5213C836.403@steinkuehler.net> <5213C9AD.2010903@xenomai.org>
	<5213D09E.80103@steinkuehler.net> <5213EFBA.90608@steinkuehler.net>
	<5213F7DA.1010200@xenomai.org> <52153BE5.8060409@steinkuehler.net>
In-Reply-To: <52153BE5.8060409@steinkuehler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] Fix for awk vs. gawk
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: xenomai@xenomai.org

On 08/22/2013 12:15 AM, Charles Steinkuehler wrote:
> On 8/20/2013 6:12 PM, Gilles Chanteperdrix wrote:
>> On 08/21/2013 12:37 AM, Charles Steinkuehler wrote:
>>> Problem #1 (solved): The genpatches.sh script calls awk, but
>>> seems to be incompatible with the stock awk (mawk) on my Debian
>>> Wheezy system.  I was getting errors on all the match ($0, ...)
>>> lines until I installed gawk:
>> 
>> I knew that, sorry for not mentioning it. And by the way, if you
>> know how to rewrite this in portable awk, patches are welcome.
> 
> Here you go.  You have to do away with the character classes, but
> the gawk code is only using [:blank:] which is space and tab, so
> not a whole lot of horrible things to go wrong with multi-character
> international locales.  :)
> 
> On my system this produces the exact same output using mawk as the 
> existing code produces with gawk, but I only tested in the
> ipipe-3.8 branch.  That said, I think I properly converted the
> intent of the regex matching code into something most older awk
> implementations can understand.
> 
> It might not be as pretty as the gawk code (I'm more used to
> hacking sed than awk, and the gawk extensions _are_ nifty), but it
> should work with most awks now.
> 
Merged, thanks.

-- 
                                                                Gilles.

