From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [y2038][RFC PATCH 0/2] Pattern for implementing y2038 syscalls 
Date: Thu,  4 Mar 2021 12:36:51 +0100
Message-Id: <20210304113653.45432-1-florian.bezdeka@siemens.com>
In-Reply-To: <87v9a7z0xh.fsf@xenomai.org>
References: <87v9a7z0xh.fsf@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com, rpm@xenomai.org, chensong@kylinos.cn

Hi!

A small RFC series for establishing / discussing a pattern for the 
implementation of y2038 syscalls. 

"The Linux pattern":
Convert the time_t related data structures to time64_t directly in the
syscall handler and pass it to the time64_t based internal APIs. 

We can follow this pattern, which allows us to re-use most of the code
that is needed for all the syscall implementations, including the
compat or ia32 / x32 ones. 

But: Some of the syscalls are calling cobalt_copy_from_user() just 
before using the value the first time. As some syscalls (like 
sc_cobalt_sem_timedwait) might not need the value in all code paths
we would end up with a couple of instructions that were "wasted". 
Would that be acceptable for us? 

If we can not follow this pattern I guess we have to duplicate all the
helpers in use to get time_t as well as time64_t support. Mainly because
we share a single syscall table between different entry points on x86.


"The syscall integration topic":
We need:
 - a new native syscall for each time_t affected syscall
 - a new compat/emulation syscall to get 32 bit applications running on 
   64 bit kernels done (so far only x86 is implemented)

As 64 bit kernels are currently using the same syscall tables as 32 bit
kernels we would end up with one superflous entry in the table for 64
bit kernels. Is that acceptable?


"The syscall naming topic":
My proposal is adding "_time64" to all y2038 safe syscalls. We can't
really use "_time32" for the "affected" ones because for 64i bit kernels
they are y2038 safe already. Further ideas?

Best regards,
Florian

Florian Bezdeka (2):
  y2038: Fixing the sem_timedwait syscall for 32 bit systems
  y2038: Adding sem_timedwait_time64

 include/cobalt/uapi/syscall.h   |  1 +
 kernel/cobalt/posix/sem.c       | 49 +++++++++++++++++----------------
 kernel/cobalt/posix/sem.h       | 10 ++++---
 kernel/cobalt/posix/syscall32.c | 23 ++++++++++++++--
 kernel/cobalt/posix/syscall32.h |  6 +++-
 5 files changed, 59 insertions(+), 30 deletions(-)

-- 
2.29.2


