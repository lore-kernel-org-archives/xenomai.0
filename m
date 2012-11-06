Message-ID: <509927B2.7010305@xenomai.org>
Date: Tue, 06 Nov 2012 16:07:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50991915.7050500@basystemes.fr>
In-Reply-To: <50991915.7050500@basystemes.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] pthread_set_name_np
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jean-Baptiste Tredez <jean-baptiste.tredez@basystemes.fr>
Cc: xenomai@xenomai.org

On 11/06/2012 03:05 PM, Jean-Baptiste Tredez wrote:
> Hello,
> 
> I have some issues when I change the name of a task (created with the 
> native skin) with the posix skin (pthread_set_name_np) on xenomai 2.6.1 
> (kernel 2.6.38.8). This is a task created by a external library and we 
> can not set the right name at the first place.
> pthread_set_name_np seems to work only on tasks created with the posix skin.

Yes, pthread_set_name_np only works for posix skin threads, I do not 
think we have a simple way of retrieving the native skin thread 
associated with a given pthread_t identifier.

We have some way of doing it that will only work for pthread_self().

> 
> Here is a test program (that worked with linux 2.6.38.8 + xenomai-2.6.0 
> and crash with linux 2.6.38 + xenomai 2.6.1) :

I doubt very much it has ever worked. It did not crash, but did not do 
anything (and returned ESRCH by the way). Anyway, we can try the 
following patch, that should restore pthread_set_name_np as a nop for 
non-posix threads as in 2.6.0:

diff --git a/ksrc/skins/posix/syscall.c b/ksrc/skins/posix/syscall.c
index 9b1c266..6c78244 100644
--- a/ksrc/skins/posix/syscall.c
+++ b/ksrc/skins/posix/syscall.c
@@ -435,9 +435,11 @@ static int __pthread_set_name_np(struct pt_regs *regs)
 	hkey.u_tid = __xn_reg_arg1(regs);
 	hkey.mm = current->mm;
 	k_tid = __pthread_find(&hkey);
-	p = xnthread_user_task(&k_tid->threadbase);
-	strncpy(p->comm, name, sizeof(p->comm));
-	p->comm[sizeof(p->comm) - 1] = '\0';
+	if (k_tid) {
+		p = xnthread_user_task(&k_tid->threadbase);
+		strncpy(p->comm, name, sizeof(p->comm));
+		p->comm[sizeof(p->comm) - 1] = '\0';
+	}
 
 	return -pthread_set_name_np(k_tid, name);
 }

If you want to set a thread name for display in top or ps, you should use
prctl(PR_SET_NAME). If you want to set the thread name for display in 
/proc/xenomai/stat or /proc/xenomai/sched, you have no other choice than
using the native API for native skin threads.

-- 
					    Gilles.

