Message-ID: <4BF1D6F0.2030305@domain.hid>
Date: Tue, 18 May 2010 01:53:20 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid><245373446233674495BCA5CA2FC1EB17378D01593B@RCexchangeSVR1.ruggedcom.local>	<4BED2910.6020105@domain.hid>
	<181804936ABC2349BE503168465576460EBD6239@domain.hid>
	<4BF17464.5090100@domain.hid>
	<181804936ABC2349BE503168465576460EBD62C8@domain.hid>
	<4BF1794A.6050207@domain.hid>
	<181804936ABC2349BE503168465576460EBD6778@domain.hid>
In-Reply-To: <181804936ABC2349BE503168465576460EBD6778@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Question about getting system time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Andreas Glatz <AndreasGlatz@domain.hid>, "Mauerer,
	Wolfgang" <wolfgang.mauerer@domain.hid>, xenomai@xenomai.org

Steve Deiters wrote:
> Even more of a problem is how I am supposed to know which calls are
> similar to this.  I would expect I could call any Linux service without
> causing a deadlock/livelock situation, although in a nondeterministic
> manner.  If I understood your explanation correctly, this is hanging
> whenever the Xenomai task tries to spin on the same lock as the kernel.
> However, I don't see how this is not a problem in general for acquiring
> any spinlock from a Xenomai task.  I would expect once you introduce a
> priority based scheduler any spinlock becomes unsafe.

The set of services which you can call from a real-time thread without
loosing determinism are those found in the Xenomai posix skin documentation:
http://www.xenomai.org/documentation/xenomai-2.5/html/api/group__posix.html

Other than that, any service emitting a syscall causes a switch to
secondary mode. What remains are services not emitting syscalls, and for
these ones, all bets are off.

-- 
					    Gilles.

