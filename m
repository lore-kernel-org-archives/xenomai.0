From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4717C642.6030002@domain.hid>
References: <4717C642.6030002@domain.hid>
Content-Type: text/plain
Date: Fri, 19 Oct 2007 05:27:03 +0200
Message-Id: <1192764423.6252.4.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] xnsched_resched_p test in hisyscall
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
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2007-10-18 at 22:46 +0200, Jan Kiszka wrote:
> Hi Philippe,
> 
> what's the point about
> 
> 	if (xnsched_resched_p())
> 		xnpod_schedule();
> 
> at the beginning of do_hisyscall_event() [1]? Could you provide a
> comment for the background of this hunk? Or can we even remove it?

No, we can't. It's a Blackfin-specific thing in disguise actually, so we
may make this code conditional through some arch-dependent wrapper
though.
http://www.rts.uni-hannover.de/xenomai/lxr/source/include/asm-blackfin/bits/pod.h#141

> 
> Jan
> 
> [1]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/shadow.c?v=SVN-trunk#1870
> 
-- 
Philippe.



