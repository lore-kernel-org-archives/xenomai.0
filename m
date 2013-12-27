Message-ID: <52BD3D0E.3010802@xenomai.org>
Date: Fri, 27 Dec 2013 09:40:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] reworking rtdm
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>, Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>


Hi Jan, Philippe,

The xnfd support is taking shape, and I think it is time to start
rebasing rtdm on it. However, looking at rtdm, I have some questions first:

_rt/_nrt callbacks: the open_rt, close_rt, socket_rt callbacks have been
deprecated for some time now, would not it make sense to remove them
completely from -forge?

syscall flags: this is an issue which was discussed some time ago, the
syscall flags for rtdm callback which would make most sense are
__xn_exec_conforming|__xn_exec_adaptive, for reasons of compatibility
(if I understood correctly), rtdm still uses
__xn_exec_current|__xn_exec_adaptive, with an "emulation" of
__xn_exec_conforming in analogy code relying on rtdm_is_rt_capable.
Would not it make sense to change the syscall flags now, and remove the
hack from analogy? If you have not changed your mind, would changing
__xn_exec_conforming so that secondary mode is preferred for threads
with the XNWEAK flag help?

rtdm_user_info: with the switch to xnfd, a file descriptor will be, by
construction, either an application file descriptor, or a kernel file
descriptor. The information can be retrieved from the mm it is attached
to. This makes the rtdm_user_info_t arguments passed to the callbacks
essentially redundant. Besides, despite the fact that this information
is passed to a lot of rtdm services, only a few of them actually use it.
So, there are several possibilities.

Either we remove the rtdm_user_info_t completely from the fd callbacks,
and from the services like rtdm_copy_from_user which do not use it. For
the few services which need it, they can be offered an accessor giving
this information either from the xnfd pointer of from the driver "priv"
pointer (the latter makes more sense, since analogy only passes its priv
pointer down the driver functions, and it currently resorts to saving
the user_info pointer in its private structure so as to be able to
retrieve it anywhere in the driver). This solution is the cleanest, the
drawback is that it breaks the drivers API, so out-of-tree drivers which
want to be compatible with xenomai classic and xenomai forge will have a
hard time. We can help them by providing macros both in forge and 2.x to
cope with the differences.

Or rtdm keeps its callbacks separated from xnfd callbacks, and rtdm file
descriptors get xnfd callbacks which cascade to rtdm callbacks. The
drawback of this solution is the added cost of cascading function
pointers. We can mitigate this by having to "ops" members in the rtdm
driver structure, a "legacy_ops" with the cascaded legacy callbacks, and
an "ops" where the xnfd callbacks are implemented directly. If ops is
there it is used, otherwise the cascading version is used.

Or finally, we byte the bullet, and add the rtdm_user_info_t argument to
xnfd callback.

Now seems like the good time for some cleanup.

Regards.

-- 
                                                                Gilles.

