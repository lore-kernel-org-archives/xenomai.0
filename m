MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17638.61794.839306.246645@domain.hid>
Date: Sat, 19 Aug 2006 13:09:22 +0200
Subject: Re: [Xenomai-core] [PATCH] speed up building of posix apps
In-Reply-To: <44E6E6D2.8020204@domain.hid>
References: <44E5ACFA.50905@domain.hid>
	<17637.50472.580142.331066@domain.hid>
	<44E5ED9A.9040201@domain.hid>
	<17637.63696.703047.258987@domain.hid>
	<44E5FB40.1050306@domain.hid>
	<17638.11497.402153.649650@domain.hid>
	<44E6E6D2.8020204@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Jan Kiszka wrote:
 > >  > Gilles Chanteperdrix wrote:
 > >  > > Jan Kiszka wrote:
 > >  > >  > Ok, here comes version 2, now with detection of the required ld feature.
 > >  > >  > Falls back to normal behaviour if ld is too old. Could you test it please?
 > >  > >  > 
 > >  > >  > [Grmbl, the fun stops where autoconf begins...]
 > >  > > 
 > >  > > Seems to work. But maybe we could find the bottleneck and fix it in a
 > >  > > general way. What part of the process is slow ?
 > >  > > 
 > >  > 
 > >  > Don't know. Maybe it's some automake magic (the arguments look different
 > >  > between libtool invocation and linker run), maybe just the long list of
 > >  > arguments.
 > >  > 
 > >  > Anyway, it's also annoying how the screen is filled up with this
 > >  > irrelevant information. So besides looking for other optimisations (but
 > >  > things run fine now I think), I definitely vote for the @file approach
 > >  > for the sake of output reduction. I haven't build a larger POSIX project
 > >  > against Xenomai recently, but I could imagine that the dump size can
 > >  > become even more than just annoying...
 > > 
 > > Patch applied, thanks. Since we are talking about optimisation, in shell
 > > scripts, I prefer to set a variable to true (or better, the : builtin)
 > > or false, this way, it may be used directly as a condition.
 > > 
 > 
 > Sorry, don't get yet what part you are referring to. If you would like
 > to express something in that patch differently, go ahead. I was already
 > happy when it worked. :)

I meant, instead of doing:
var=yes

if test $var = yes

do:

var=true

if $var

But it is not really important.

-- 


					    Gilles Chanteperdrix.

