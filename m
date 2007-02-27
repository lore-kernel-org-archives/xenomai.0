Subject: Re: [Xenomai-core] x86_64 - missing header
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200702272106.30750.paul_c@domain.hid>
References: <200702272106.30750.paul_c@domain.hid>
Content-Type: text/plain; charset="utf-8"
Date: Tue, 27 Feb 2007 23:47:25 +0100
Message-Id: <1172616446.10171.36.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
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
To: Paul <paul_c@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, 2007-02-27 at 21:06 +0000, Paul wrote:
> Hi Philippe
> 
> Trying very hard to keep up with the rate of commits - The latest 1.0-05 patch 
> in conjuntion with r2264 fails with the error:
> 
> arch/x86_64/xenomai/hal.c:51:22: error: mach_ipi.h: No such file or directory
> arch/x86_64/xenomai/hal.c: In function ‘rthal_broadcast_to_local_timers’:
> arch/x86_64/xenomai/hal.c:104: warning: implicit declaration of 
> function ‘send_IPI_all’
> 
> Looks like mach_ipi.h is missing from my 2.6.19 tree, but the function is 
> declared in asm/mach_apic.h - The attached patch resolves this minor problem.
> 

Merged, thanks.

Btw, I'm keeping an eye on the MTRR issue, which also happens over ia32
when starting X. This problem might have ramifications outside of the
mtrr driver code though. This definitely needs more investigations.

The urgent issue that remains to be fixed so far in the x86_64 patch
concerns the pipelining of the debug exceptions, so that GDB could be
usable with Xenomai apps in user-space. I'm on it.

-- 
Philippe.



