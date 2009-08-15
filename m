From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <alpine.DEB.2.00.0908151512440.7626@domain.hid>
References: <Pine.LNX.4.62.0908141030170.14595@domain.hid>
	<4A853707.10509@domain.hid>
	<Pine.LNX.4.62.0908141206480.14595@domain.hid>
	<1250244831.3019.17.camel@domain.hid>
	<Pine.LNX.4.62.0908141226340.14595@domain.hid>
	<1250262328.2933.0.camel@domain.hid>
	<alpine.DEB.2.00.0908151512440.7626@domain.hid>
Content-Type: text/plain
Date: Sat, 15 Aug 2009 16:10:54 +0200
Message-Id: <1250345454.2933.91.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] T_WARNSW ignored?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org

On Sat, 2009-08-15 at 15:14 +0200, Waschk,Kolja wrote:
> Hi,
> 
> well my guess was correct, the quickly increasing MSW without SIGXCPU was just
> due to a forced mode switch with rt_task_set_mode... how silly, sorry for
> bothering!

No problem. I'm rather concerned by the fact that
rt_task_set_mode(...T_PRIMARY...) is still being used for the wrong
purpose, but this bug is mine originally. The point is that there should
be no valid reason to switch modes explicitly in any user level code,
Xenomai knows better in any case, and only does it internally when
required.

Explicit switching is currently required by a few skin libraries for
internal purpose, I should have exported some hidden syscall to provide
this anti-feature, instead of crippling the rt_task_set_mode() interface
with the wacky T_PRIMARY mode bit. Anyway...

The xnshadow_relax() issue on Blackfin led to use it the wrong way as a
workaround; please report this kind of bug before applying any
workaround, so that a proper fix could be found in parallel. TIA,

> 
> Kolja
> 
> 
-- 
Philippe.



