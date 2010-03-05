Message-ID: <4B90F2D3.8020508@domain.hid>
Date: Fri, 05 Mar 2010 13:02:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B90ED0A.40101@domain.hid>
In-Reply-To: <4B90ED0A.40101@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH] Allow for deregistering current
 mode user space address
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> This adds __xn_sys_drop_u_mode, a syscall to deregister the u_mode user
> space address passed on shadow creation for the current thread. We need
> this in order to safely shut down a thread that wants to release its
> u_mode memory (either malloc'ed or TLS-allocated). So far, the kernel
> might have touched this memory even after the release which caused
> subtle corruptions.
> 
> After we released u_mode, we can no longer make reliable decisions based
> on it. For the fast mutex use case, we then assume the worst case, ie.
> we enforce syscall-based acquisitions unconditionally. For the
> assert_nrt case, we simply acquire the required information via
> __xn_sys_current_info.

As usual, you are firing patches too fast:
- you are lacking the exit syscall trap.
- the patch is not correct and will cause kernel-space addresses to be
passed to put_user, which probably yields bugs when the kernel is
compiled with proper debug flags;
- I do not see the point where the new syscall is called with __thread,
but I am not sure it is missing, and if it is missing, you will get the
rightfull warning when hitting the exit syscall.
- the user-space users of the function to get current_mode are still
cluttered with special cases to handle the invalid state. And
illustrating nicely the deficiency of this approach, you have forgot one
user.

I am not going to make my version before tomorrow, so you have plenty of
time to send me an at least correct version which would take into
account all of our discussions.

Please also consider that your "patch machinegun" way of working is not
really sane. When there are so many often untested patches to review
coming from you, we sometime let some errors slip through. And from a
user point of view, seeing so many buggy patches refused is not really
reassuring.

-- 
					    Gilles.

