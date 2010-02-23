From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100223075308.GA6661@domain.hid>
References: <1262949018.2455.5.camel@domain.hid>
	<1263312199.2455.169.camel@domain.hid>
	<20100112172443.GP8605@domain.hid>
	<1263318551.2455.188.camel@domain.hid>
	<20100112185012.GQ8605@domain.hid>
	<1263324215.2455.293.camel@domain.hid>
	<20100112221802.GR8605@domain.hid>
	<1263567811.2428.487.camel@domain.hid>
	<20100115161415.GA24305@domain.hid>
	<1263576144.2428.527.camel@domain.hid>
	<20100223075308.GA6661@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 23 Feb 2010 11:07:57 +0100
Message-ID: <1266919677.26785.279.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Adeos-main] I-pipe for 2.6.32 PPC
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: adeos-main@gna.org, xenomai@xenomai.org, Lennart Sorensen <lsorense@domain.hid>

On Tue, 2010-02-23 at 08:53 +0100, Richard Cochran wrote:
> Philippe,
> 
> After updating my ipipe git repo, I notice that you have done
> something new with ipipe-2.6.32-powerpc, back in January.  Previously,
> the Denx bits appeared as "squashed" commits. Now, the Denx commits
> appear individually.
> 
> I am curious, what's up with that?
> 

I wanted to rebase on the official DENX stable branch, since my work was
previously based on a dev snapshot, and I did this by fetching+merging
that branch into mine, based on v2.6.32.2; in that case, the changes
appear as individual commits I guess. I did not want to mess with jumbo
patches and the error-prone manual operations they entail.

With ipipe-2.6.33 solely tracking mainline, only the few temporary trees
with not-mainlined-yet features/support will pull from the DENX tree to
get them.

> Thanks,
> Richard
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 
Philippe.



