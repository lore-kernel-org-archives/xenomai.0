Date: Thu, 27 Aug 2009 12:29:35 +0300 (EEST)
From: "Rus V. Brushkoff" <rus@domain.hid>
In-Reply-To: <1251365020.3052.6.camel@domain.hid>
Message-ID: <Pine.LNX.4.64.0908271228110.4210@domain.hid>
References: <Pine.LNX.4.64.0908271144200.1424@domain.hid>
	<1251365020.3052.6.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Xenomai-help] Xenomai-head and 2.6.30.5
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 27 Aug 2009, Philippe Gerum wrote:

:>   Have problems with this kernel :
:>   - adeos-ipipe-2.6.30-x86-2.4-05.patch fails on arch/x86/include/asm/irqflags.h
:This hunk can be fixed manually; there seems to be annoying whitespace
:changes in the way. 

Yes there are added comments and a little code change that confuse patch.

:>   - kernel compiled with stack protector panics in __schedule while trying
:>  	to run any latency test. Backtrace is :
:Our task switch code does not support CC_STACKPROTECTOR yet; since we
:don't update the switch canary word, the vanilla checks likely choke on
:our switches. You may want to disable this option for running
:Xenomai/x86.

Thanks, I will do this.


		Rus

