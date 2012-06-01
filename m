Message-ID: <4FC8F8EE.4010901@xenomai.org>
Date: Fri, 01 Jun 2012 19:16:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] x86_32 mayday
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>


Hi,

with the current tip of xenomai 2.6 branch, the "sigdebug" test testing
the "mayday" code ends up with a segfault on x86_32. I tried to have a
look at it, but could not really understand what happens: the register
on return from the syscall are ok, but the segfault happens after return
from the signal handler, when returning from the interrupted function.
It looks like either ebp, or the function return adress are wrong.

If anyone wants to have a look at it... Jan maybe?

Regards.

-- 
					    Gilles.

