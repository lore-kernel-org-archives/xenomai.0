MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17996.20586.564091.503622@domain.hid>
Date: Thu, 17 May 2007 14:54:02 +0200
In-Reply-To: <464C4DE4.1040402@domain.hid>
References: <17996.15540.824415.263562@domain.hid>
	<464C4DE4.1040402@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [PATCH] Use tsc for implementation of
	clock_gettime.
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Hi,
 > > 
 > > here comes, for review, a patch which reduces the overhead of
 > > clock_gettime by directly reading the tsc in user-space for
 > > architectures that support it.
 > 
 > Highly welcome. But I have one concern: How and when do you propagate
 > wallclock_offset changes to user space?

Since clock_settime is not implemented, never, but if clock_settime was
implemented, clock_settime would re-issue the __xn_sys_info syscall.

 > 
 > I think we need some vsyscall-alike approach for this, some read-only
 > page that is mapped into every RT process, containing things like a
 > regularly updated offset (seqlock fashioned) or other read-only
 > information (shadow mode? cpu id?).

As I said yesterday, having a page mapped at a different address in
kernel-space and user-space is not an option on ARM, because each
mapping of this page would have a separated cache.

-- 


					    Gilles Chanteperdrix.

