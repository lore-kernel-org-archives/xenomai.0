MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17552.19474.627969.835402@domain.hid>
Date: Wed, 14 Jun 2006 19:49:06 +0200
Subject: Re: [Xenomai-core] /proc/xenomai broken...
In-Reply-To: <44903E3B.3050405@domain.hid>
References: <17552.12922.452992.652848@domain.hid>
	<44903432.3070905@domain.hid>
	<17552.13951.428423.915304@domain.hid>
	<4490381F.6030309@domain.hid> <449039EC.7070404@domain.hid>
	<17552.15676.790202.422989@domain.hid>
	<44903E3B.3050405@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > Gilles Chanteperdrix wrote:
 > > Philippe Gerum wrote:
 > >  > This said, the other option would be to move the call to 
 > >  > xnshadow_mount() from the xnarch_init() to __xeno_sys_init() in a 
 > >  > kernel-only section, just after xnpod_init_proc() has returned. There is 
 > >  > nothing done in the arch-layer for any architecture that would prevent 
 > >  > this. Btw, I'd say that "core" would be better than "xenomai" to name 
 > >  > this internal interface.
 > > 
 > > Ok for renaming. But no thread is ever bound to this interface, so the
 > > count is always 0. 
 > > 
 > 
 > xnshadow_sys_bind()/unbind() would be the proper place to track a 
 > cumulated count. I'm not sure that this is going to be that useful now, 
 > but at some point in the future, maybe we could get a benefit from 
 > having a uniform way of talking to any interface using procfs, including 
 > to the core one.

Commit 1205 does what you suggested.

-- 


					    Gilles Chanteperdrix.

