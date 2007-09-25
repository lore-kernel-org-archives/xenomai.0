From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46F777EE.3060100@domain.hid>
References: <46F777EE.3060100@domain.hid>
Content-Type: text/plain
Date: Tue, 25 Sep 2007 20:25:35 +0100
Message-Id: <1190748335.22323.11.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Adeos PowerPC patch differences
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Benjamin ZORES <benjamin.zores@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Mon, 2007-09-24 at 10:40 +0200, Benjamin ZORES wrote:
> Hello Philippe (or any that can provide me with some infos),
> 
> I've seen you've commited a patch for Adeos on upcoming 2.6.23
> based on DENX tree.
> 
> Can you tell me what are the main differences between the Adeos 1.7
> and 2.0 series from a functionnal point of view ?

Basically none.

The point of the I-pipe/powerpc 2.0 series on top of 2.6.22+ is:
1) to introduce the flat interrupt log, and also reduce the cache
footprints of the pipeline.
2) to merge the 32 and 64bit supports into a single patch, which should
put both on par with respect to the maintenance effort (e.g. we may not
release the 32bit side while the 64bit one is lagging behind anymore, so
we now have a pretty good incentive to keep the 64bit side in shape).

The 1.7 series is a backport of the flat interrupt log and cache
footprints optimizations to 2.6.20/32bit, so that people having deployed
the older I-pipe series/Xenomai don't have to upgrade to 2.6.22+ to get
those improvements.

> Is Xenomai 2.4-rc3 supposed to work as good on both series ?

Yes. I have tested 2.6.22-DENX over two Freescale boards, namely mpc52xx
and mpc8548, using this very same setup. Btw, you will need to pick
2.0-01 which landed today in the repo, since I fixed a couple of issues
(one being serious) there.

> And is the DENX patch specific to DENX tree or can it be applied/used
> from vanilla kernel tree ?
> 

It should apply to the vanilla tree without too much fuss, but the
reference tree for the I-pipe/powerpc work is the DENX one, AFAIC.

> Regards,
> 
> Ben
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



