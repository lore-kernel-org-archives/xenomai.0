Date: Thu, 14 Jan 2010 08:53:43 +0100
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20100114075343.GA5179@domain.hid>
References: <4B209B9C.7010309@domain.hid>
	<20100108105925.GA14163@domain.hid>
	<1262949018.2455.5.camel@domain.hid>
	<1263312199.2455.169.camel@domain.hid>
	<20100112172443.GP8605@domain.hid>
	<1263318551.2455.188.camel@domain.hid>
	<20100112185012.GQ8605@domain.hid>
	<1263324215.2455.293.camel@domain.hid>
	<20100112221802.GR8605@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100112221802.GR8605@domain.hid>
Subject: Re: [Xenomai-core] [Adeos-main] I-pipe for 2.6.32 PPC
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Lennart Sorensen <lsorense@domain.hid>
Cc: Bernhard Pfund <bernhard@domain.hid>, adeos-main@gna.org, xenomai@xenomai.org

On Tue, Jan 12, 2010 at 05:18:02PM -0500, Lennart Sorensen wrote:
> Well I have not been able to find the magic invocation that lets me take
> the DENX tree (which I have had around for a long time just to look at
> occationally, whenever I was trying to get an ipipe patch to apply),
> apply the ipipe patch, revert the DENX changes to get back to a release
> kernel, and generate a diff of the ipipe changes.  It has never worked
> when I tried.

Lennart,

It is not so hard (using git) to remove the Denx patches from the
ipipe tree. I did this myself for 2.6.30 in about a half an hour. If
you don't know how to use git, then you would have to consider the
additional time you need to get to understand it. (For me, it was only
a year or so ;)

In the ipipe tree, the Denx commits have been "squashed" together into
one or two really large commits. So, you can just cherry pick the
adeos commits into a new branch, with a few minor fixups.

Philippe,

I actually agree with Lennart that the Denx stuff is an
annoyance. When considering my "no-denx" branch that I made, I could
not see any significant Denx change that adeos builds upon. There were
a few Denx fixes for one specific board that were close to the adeos
changes, but these were only a few, and easy to fix. So, I could not
understand why Denx is a prerequisite for adeos.

I understand that Denx sponsored the original PowerPC Xenomai port. Is
the reason that ipipe is based on Denx simply to honor that fact? If
so, I would not think it a bad reason at all.

However, I would still prefer the following ordering for the changes:

1. stable linux (2.6.xx.y)
2. adeos arch indepedendent
3. adeos powerpc
4. denx
5. adeos for denx (minimal changes, I expect)

Richard

