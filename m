From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-core] rtdm over x86_64
Date: Sat, 3 Feb 2007 23:32:09 +0000
References: <200702031313.20104.paul_c@domain.hid> <45C4A580.3000904@domain.hid>
In-Reply-To: <45C4A580.3000904@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702032332.09067.paul_c@domain.hid>
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

On Saturday 03 February 2007 15:08, Jan Kiszka wrote:
> Yeah, when looking at this issue with 64-bit glasses, this urgently
> needs fixing (I wonder why ia64 didn't stumble yet?).

Perhaps different compiler and/or warning flags ?
 Using gcc-4.1 at the moment..

> init/Kconfig:572: can't open file "arch/x86_64/xenomai/Kconfig"
>
> Anyone any idea? Is something missing, or is the prepare script broken?

I must admit, saw the first of the commits announced on 
http://cia.navi.cx/stats/project/xenomai and butchered a tree to see what 
else was needed.. I'll wait for Philippe to finish his commits before 
preempting him again.

> PS: Once we have in-tree RTDM services and drivers running, are you
> interested in a RTnet excursion over x64? I should be able to make this
> compile, but for testing...

RTnet across a local net and/or a machine in your lab via the internet - Could 
be fun :)
 If you have some ready to run code, I can set aside an afternoon to run some 
tests - Perhaps even set up an ssh session so that you can monitor the 
results.


Regards, Paul.



