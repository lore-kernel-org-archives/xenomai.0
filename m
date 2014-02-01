Message-ID: <52ED3BA0.4040105@xenomai.org>
Date: Sat, 01 Feb 2014 19:23:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] RTDM rework
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

I have started working on rebasing RTDM on the common fd implementation
(xnfd). Before I start changing the drivers, the current state of the
changes follow as patches. These patches are based on the commits in the
"for-forge" branch in xenomai-gch repository. Please do not pull from
this branch just yet, it is probably going to be rebased.

The thing which I know we will discuss, even before you read the patches:
- struct xnfd appears instead of struct rtdm_dev_context in callbacks,
we already discussed that, you prefer rtdm typedefs, the thing is, in
forge, the habit to typedef structs seems gone, and typedef struct xnfd
rtdm_dev_contex_t would be confusing since struct rtdm_dev_context still
exists, albeit is no longer exported to drivers;
- the xnfd structure is defined in cobalt, and not cobalt/posix, this
was made so that both rtdm and posix can use it, but maybe it makes more
sense to move it to posix (after all, file descriptors are a posix
thing), and get rtdm to use it anyway;
- doc is probably out of sync, this will be arranged in later commits
- maybe select should be moved to fd.c now, posix/select.c contains 3
functions, and it now supports xnfds exclusively;
- context_flags are gone, since the two flags it used are no longer
used, since driver have a private structure, drivers can move their
flags to their private structure if they want;
- handling -EAGAIN in the close callback is gone, the close callback now
returns void, it is possible to delay file descriptor destruction by
using rtdm_lock/rtdm_unlock, so the -EAGAIN return value was IMO redundant.

Regards.

-- 
                                                                Gilles.

