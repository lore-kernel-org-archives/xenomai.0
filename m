Message-ID: <4DFDCBEA.6010905@domain.hid>
Date: Sun, 19 Jun 2011 12:14:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DDA66CF.2010307@domain.hid>
In-Reply-To: <4DDA66CF.2010307@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PULL] native: Fix msendq fastlock leakage
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 05/23/2011 03:53 PM, Jan Kiszka wrote:
> The following changes since commit aec30a2543afa18fa7832deee85e187b0faeb1f0:
> 
>   xeno-test: fix reference to @XENO_TEST_DIR@ (2011-05-15 21:20:41 +0200)
> 
> are available in the git repository at:
>   git://git.xenomai.org/xenomai-jki.git for-upstream
> 
> Jan Kiszka (1):
>       native: Fix msendq fastlock leakage
> 
>  include/native/task.h    |    5 +++++
>  ksrc/skins/native/task.c |   13 ++++++-------
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> ------8<------
> 
> When a native task terminates without going through rt_task_delete, we
> leaked the fastlock so far. Fix it by moving the release into the delete
> hook. As the ppd is already invalid at that point, we have to save the
> heap address in the task data structure.

I am working on this ppd cleanup issue again, I am asking for help to
find a fix in -head for all cases where the sys_ppd is needed during
some cleanup.

The problem is that when the ppd cleanup is invoked:
- we have no guarantee that current is a thread from the Xenomai
application;
- if it is, current->mm is NULL.

So, associating the sys_ppd to either current or current->mm does not
work. What we could do is pass the sys_ppd to all the other ppds cleanup
handlers, this would fix cases such as freeing mutexes fastlock, but
that does not help when the sys_ppd is needed during a thread deletion hook.

I would like to find a solution where simply calling xnsys_ppd_get()
will work, where we do not have an xnsys_ppd_get for each context, such
as for instance xnsys_ppd_get_by_mm/xnsys_ppd_get_by_task_struct,
because it would be too error-prone.

Any idea anyone?

-- 
                                                                Gilles.

