Message-ID: <49E0C40E.1050509@domain.hid>
Date: Sat, 11 Apr 2009 18:23:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49DF102B.4030107@domain.hid> <1239359009.7007.127.camel@domain.hid>
In-Reply-To: <1239359009.7007.127.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Git pull request.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Fri, 2009-04-10 at 11:23 +0200, Gilles Chanteperdrix wrote:
>> Hi Philippe,
>>
>> I got some changes ready for head. What we want to include in the stable
>> branch remains to be discussed, once we agree, I will prepare another
>> branch for v2.4.x patches.
>>
> 
> No objection to merge back FPU fixes to 2.4.x before we close that
> branch, when 2.5 is out. This would give us some time to make sure
> everything is fine while running the -rc series.
> 
>> The following changes since commit bbbaec33689d8e82b604745bb55209a83d79a4bc:
>>   Philippe Gerum (1):
>>         Test for self-deletion in a safer way
>>
>> are available in the git repository at:
>>
>>   git://git.xenomai.org/xenomai-gch.git for-upstream
>>
>> Gilles Chanteperdrix (4):
>>       Improve switchtest coverage.
>>       x86 FPU fixes
>>       Optimize x86 fpu switches.
>>       Fix rt_task_trampoline and rt_task_shadow error paths.
> 
> I'm generally ok with the patches, but the last one still leaves an
> issue open: if the child thread dies upon -ENOMEM, the creator won't be
> unblocked from pending on the completion sync in rt_task_create(). We
> could live with this for a while (lacking memory at that point is a
> clear sign that things are going to turn ugly very soon anyway), but
> would we want to fix this, we would have to either fire the
> __rt_task_create syscall with some NULL args and let it notice them,
> then signal the completion block with an error status, or have something
> like __xn_sys_sigcompletion to unblock the waiter directly from
> userland.

Ok. The new branch for-head should contain an implementation of the 
first idea. From now on, my proposed fixes should go in that branch.
Fixes for the 2.4 branch should go in the for-2.4 branch.

The following changes since commit 9a9c8bbcc5a5439396d593b250510d89a1584957:
  Philippe Gerum (1):
        Update baseline information

are available in the git repository at:

  git://git.xenomai.org/xenomai-gch.git for-head

Gilles Chanteperdrix (5):
      Improve switchtest coverage.
      x86 FPU fixes
      Optimize x86 fpu switches.
      Fix rt_task_shadow error paths.
      Fix rt_task_trampoline error path.

 include/asm-arm/fptest.h              |   14 +-
 include/asm-blackfin/fptest.h         |   10 +
 include/asm-powerpc/fptest.h          |   34 +++
 include/asm-x86/bits/pod_32.h         |   41 ++---
 include/asm-x86/bits/pod_64.h         |   39 ++--
 include/asm-x86/fptest.h              |   31 +++
 include/rtdm/rttesting.h              |    8 +-
 ksrc/drivers/testing/switchtest.c     |  385 +++++++++++++++++++++------------
 ksrc/skins/native/syscall.c           |    5 +
 src/skins/native/task.c               |   55 +++--
 src/testsuite/switchtest/switchtest.c |  239 ++++++++++++++------
 11 files changed, 578 insertions(+), 283 deletions(-)

-- 
					    Gilles.

