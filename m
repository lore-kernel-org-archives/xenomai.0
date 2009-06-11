From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4A30D969.6080501@domain.hid>
References: <4A30CB83.5080504@domain.hid> <4A30CF49.8010007@domain.hid>
	<4A30D3CD.8050908@domain.hid>  <4A30D969.6080501@domain.hid>
Content-Type: text/plain
Date: Thu, 11 Jun 2009 12:37:15 +0200
Message-Id: <1244716635.7890.134.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] ksrc: respect struct proc_dir_entry
	changes in 2.6.30
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2009-06-11 at 12:16 +0200, Jan Kiszka wrote:
> Vladimir Zapolskiy wrote:
> > Hi Jan,
> > I observed that LINUX_VERSION_CODE comparisons are common enough in
> > Xenomai code. Do you propose to make a separate header, which is
> > included from nucleus, drivers and arch files?
> 
> Yes, it's common, but we also keep a lot of wrapping in asm-*/wrappers.h.
> 

No, it's not that common actually. Most of them are used in the HAL,
half of those in assembly files because we don't have assembly-level
wrappers, and the remaining spots are located in a few RT drivers
(namely serial, CAN and irqbench).

So the canonical way to fix this is indeed to add the proper wrapper to
include/asm-generic/wrappers.h. TIA,

> Jan
> 
> PS: Please avoid top-posts.
> 
-- 
Philippe.



