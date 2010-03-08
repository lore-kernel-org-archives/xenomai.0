Message-ID: <4B95253E.3030303@domain.hid>
Date: Mon, 08 Mar 2010 17:26:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] u_mode and condvar fixes.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>


Hi,

I pushed the changes fixing the u_mode (taken from Jan, slightly
modified) and condvar stuff (not entirely taken from Jan's changes), as
well as the modifications coming from Philippe's branch.

However, two questions remain open:
- as in Jan's original patch, the u_mode stuff tests the presence of the
new syscall by testing whether it returns -ENOSYS. Now that we have the
vdso, I wonder if we should not use a vdso bit for this. This would give
us a systematic way of testing such syscalls extension.
- the condvar fix only fixes the general case, using errno, it does not
add any new syscall. I am not entirely convinced we really need to add
new syscalls. In fact we could use special values in the existing ones.
Or have access in kernel-space to the a process' vdso flags, allowing to
adapt according to these flags. I am simply wondering what is the
cleanest way.

What do you think?
Thanks in advance.

-- 
					    Gilles.

