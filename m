From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 13 May 2015 13:33:01 -0400
Message-ID: <20150513173301.GB6169@csclub.uwaterloo.ca>
References: <CAKC9m6cXp+ZQdZG2qCQA5+J2m0W-2hnLniL0wswfSu5aD32wwg@mail.gmail.com>
 <20150430201409.GA1993@hermes.click-hack.org>
 <20150430212151.GD24389@csclub.uwaterloo.ca>
 <20150430212749.GB1993@hermes.click-hack.org>
 <20150501134547.GF24389@csclub.uwaterloo.ca>
 <20150501135651.GE1993@hermes.click-hack.org>
 <20150501143631.GH24389@csclub.uwaterloo.ca>
 <20150501144428.GI1993@hermes.click-hack.org>
 <20150501153325.GJ24389@csclub.uwaterloo.ca>
 <20150513170156.GA6169@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150513170156.GA6169@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] Ipipe-core patched kernel fails to start when certain
 platform drivers are enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, May 13, 2015 at 01:01:56PM -0400, Lennart Sorensen wrote:
> On Fri, May 01, 2015 at 11:33:25AM -0400, Lennart Sorensen wrote:
> > There is some talk of a 50% or 12.5% safety margin, but that doesn't
> > explain it either.  Looks like a bug somehow.
> > 
> > Your calculation looks right, the kernel's looks crazy.
> 
> Trying to boot 3.14.39 I just saw:
> 
> [    0.040557] I-pipe, 6.147 MHz clocksource, wrap in 3000934451555157 ms
> [    0.054082] sched_clock: 56 bits at 6MHz, resolution 162ns, wraps every 2794592043008ns
> 
> I wonder who could be right... :)
> 
> Of course then it gets stuck at
> [    0.070615] Switching to timer-based delay loop
> [    0.081432] Interrupt pipeline (release #9)
> 
> so I better figure out what I did wrong with this new version.  Time to
> check the config.  It booted before I added ipipe to it.

Oh good, I managed to make it fail without ipipe enabled, so that's good.
Not an ipipe problem I think, unless the ipipe patch is at fault.

-- 
Len Sorensen

