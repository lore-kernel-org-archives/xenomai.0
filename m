From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4576842B.1090203@domain.hid>
References: <4576842B.1090203@domain.hid>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 10:41:56 +0100
Message-Id: <1165398116.7218.31.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Adeos-main] [RFC] type-based spinlock op
	selection
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org, xenomai-core <xenomai@xenomai.org>

On Wed, 2006-12-06 at 09:49 +0100, Jan Kiszka wrote:
> Hi,
> 
> reading through the I-pipe patch I noticed that there are quite a few
> spin_lock->spin_lock_hw and similar conversions. Having the conversion
> mechanism of the -rt patch in mind, I wrote the attached I-pipe cleanup
> that applies a similar pattern on this issue. Gives more than 10k patch
> size reduction for x86 and a bit more safety against minor variations of
> the patched code. Still, review of the lock usages keeps on being
> required as the lock user could assume running IRQs off while I-pipe may
> not guarantee this.
> 
> The required patch for Xenomai is attached as well.
> 

I definitely like this. Queued for testing, thanks.

-- 
Philippe.



