MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17507.17429.111733.818694@domain.hid>
Date: Thu, 11 May 2006 16:03:01 +0200
Subject: Re: [Xenomai-core] [RFC][patch] per-process data.
In-Reply-To: <446333C7.1070406@domain.hid>
References: <17502.13773.674199.219762@domain.hid>
	<17503.16072.557355.759746@domain.hid>
	<445F4CC5.20301@domain.hid>
	<17504.54807.68153.142769@domain.hid>
	<44611320.8040909@domain.hid>
	<17505.58508.240692.324238@domain.hid>
	<446333C7.1070406@domain.hid>
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
 > > The attached version of the patch do that.
 > 
 > Fine with me, please merge as you see fit. Details follow:
 > 
 > > +++ include/nucleus/ppd.h	2006-05-10 14:27:11.000000000 +0200
 > > @@ -0,0 +1,26 @@
 > > +#ifndef PPD_H
 > > +#define PPD_H
 > > +
 > 
 > Given that ppds are shadow-specific, I would move ppd.h's contents to 
 > shadow.h directly.

I tried, but it is not possible, shadow.h is included in asm/system.h
and thus can not include nucleus/queue.h.

 > 
 > > +static unsigned
 > > +xnppd_lookup_inner(xnqueue_t **pq, xnppd_holder_t **pholder, xnppd_key_t *key)
 > > +{
 > > +    unsigned bucket = jhash2((uint32_t *)&key->mm,
 > > +                             sizeof(key->mm)/sizeof(uint32_t), 0);
 > 
 > GCC is likely going to wine on 64-bit archs for attempting to forge a 
 > type-punned pointer.

How do I write this then ? It is a copy of some code in posix/syscall.c

-- 


					    Gilles Chanteperdrix.

