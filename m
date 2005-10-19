From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-core] Cosmetic changes to script xeno-config + man page
Date: Wed, 19 Oct 2005 17:42:11 +0900
References: <1CFEB358338412458B21FAA0D78FE86D4F0E2E@rennsmail02.eu.thmulti.com>
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D4F0E2E@rennsmail02.eu.thmulti.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510191742.12489.rlenglet@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

> > > >I will look into making a xenomai.pc file.
> > >
> > > Make it a xenomai.pc.in file   ;-)

Yes, that's what I considered doing.

> > I am not sure we want to depend on pkg-config...
>
> Gilles, put it the other way around. Xenomai won't depend on
> pkg-config, but applications using Xenomai, will happily
> depend on it, if they choose this option. To me, pkg-config
> shouldn't be a replacement, but an alternative choice to
> xeno-config.

I agree, it considered that as an alternative.


Unfortunately, it is not that simple.
It would be necessary to create several *.pc.in files, one for 
each set of config parameters, cf. the output of xeno-config:
- xenomai-kernel.pc.in <-> --kernel-*
- xenomai-native.pc.in <-> --xeno-*
- xenomai-posix.pc.in <-> --posix-*
- xenomai-uvm.pc.in <-> --uvm-*

Beware that me must "merge" the *-cflags and *-ldflags config 
info, because pkg-config splits them a-posteriori, cf. the 
--cflags, --libs-only-L and --libs-only-l options of pkg-config.
That separation is different from that of Xenomai's xeno-config.


And the xeno-config script would still be necessary for some 
parameters, such as:
    xeno-config --module-dir
and:
    xeno-config --config
pkg-config is too limited regarding the information that we can 
put into .pc files...


Anyway, Stephane, if you want to write the four *.pc.in, go on 
please! :)

-- 
Romain Lenglet

