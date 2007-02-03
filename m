Subject: Re: [Xenomai-core] rtdm over x86_64
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45C4A580.3000904@domain.hid>
References: <200702031313.20104.paul_c@domain.hid> <45C4A580.3000904@domain.hid>
Content-Type: text/plain
Date: Sat, 03 Feb 2007 16:45:57 +0100
Message-Id: <1170517558.8282.4.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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

On Sat, 2007-02-03 at 16:08 +0100, Jan Kiszka wrote:

> But first I need some build environment. A quick shot ended here when
> trying to configure a patch and prepared 2.6.19 kernel:
> 
> # make ARCH=x86_64 CC="gcc -m64" oldconfig
> ...
> init/Kconfig:572: can't open file "arch/x86_64/xenomai/Kconfig"
> 
> Anyone any idea? Is something missing, or is the prepare script broken?

It's a bit early for building the x86_64 stack; you may want to fix the
compilation issues over ppc64 or ia64. I'm working on the missing x86_64
bits (task switching and a few other details) before even starting to
fix the build issues.

-- 
Philippe.



