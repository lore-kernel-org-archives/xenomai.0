Message-ID: <448F2A93.6010601@domain.hid>
Date: Tue, 13 Jun 2006 23:13:55 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Breakage in trunk
References: <200606132257.00974.niklaus.giger@domain.hid>
In-Reply-To: <200606132257.00974.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

Niklaus Giger wrote:
> Hi 
> 
> I noticed that, eg.  
> http://ngiger.dyndns.org/buildbot/hcu3/builds/80/step-mk_xeno/0
> there are build failures. It tells me
> Making install in vrtx
> make[4]: Entering directory 
> `/mnt/data.ng/buildslave/buildbot/quick-hcu3/build/hcu/src/skins/vrtx'
> make[4]: *** No rule to make target `event.c', needed by 
> `libvrtx_la-event.lo'.  Stop.
> 
> Last successfull build for hcu3 was with Revision: 1195
> 
> tqm860 still failes as  shown in
> http://ngiger.dyndns.org/buildbot/tqm860/builds/97/step-mk_kernel/0
> with
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I/home/buildslave/buildbot/quick-tqm860/build/linuxppc_2_4_devel-2006-04-06-1735/arch/ppc -o 
> scripts/split-include scripts/split-include.c
> make: *** No rule to make target `include/linux/autoconf.h', needed by 
> `include/config/MARKER'.  Stop.
> 
> Could someone looking at these failures, please?

I forgot to commit two new files. Fixed, thanks.

-- 

Philippe.


