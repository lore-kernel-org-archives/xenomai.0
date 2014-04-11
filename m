Message-ID: <5347F5AD.1030201@xenomai.org>
Date: Fri, 11 Apr 2014 16:01:17 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1396783490.22359.YahooMailNeo@web171604.mail.ir2.yahoo.com>
In-Reply-To: <1396783490.22359.YahooMailNeo@web171604.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Race condition between threadobj_unlock and
 threadobj_free in t_resume
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/06/2014 01:24 PM, Matthias Schneider wrote:
> The following minimal program
>
> http://pastebin.com/JdnnXwsF
>
> seems to lead to a race condition between threadobj_unlock
> and threadobj_free as indicated by valgrind (xenomai-forge
> and mercury):
>
> ==9573== Invalid read of size 4
> ==9573==    at 0x403F214: threadobj_unlock (threadobj.h:407)
> ==9573==    by 0x403FAD2: put_psos_task (task.c:151)
> ==9573==    by 0x4040E9F: t_resume (task.c:419)
> ==9573==    by 0x80486F9: main (task-2.c:20)
> ==9573==  Address 0x42a20c4 is 172 bytes inside a block of size 664 free'd
> ==9573==    at 0x4029C88: free (vg_replace_malloc.c:446)
> ==9573==    by 0x40641B6: pvfree (heapobj.h:156)
> ==9573==    by 0x406425A: xnfree (heapobj.h:421)
> ==9573==    by 0x406460C: threadobj_free (threadobj.h:285)
> ==9573==    by 0x4068C6B: finalize_thread (threadobj.c:1239)
> ==9573==    by 0x40B5AE5: __nptl_deallocate_tsd (pthread_create.c:157)
> ==9573==    by 0x40B5CFE: start_thread (pthread_create.c:318)
> ==9573==    by 0x41C2C3D: clone (clone.S:131)
> ==9573==
>
> I am not sure on how to fix this, any ideas? I do admit
> that the use case is neither typical nor very useful on its own,
> but it is used in my test environment.
>
> It seems that when resuming a thread that already is in
> its finalizer may lead to that thread's heap already being freed
> when it is about to being unlocked by the resume function.

I could not reproduce this issue with your test code (it's likely too 
timing-dependent), but looking at the backtrace above a bit closer, this 
patch should help:

diff --git a/include/boilerplate/lock.h b/include/boilerplate/lock.h
index dce1ff0..4819b34 100644
--- a/include/boilerplate/lock.h
+++ b/include/boilerplate/lock.h
@@ -177,9 +177,9 @@ int __check_cancel_type(const char *locktype);

  #define __do_unlock_safe(__lock, __state)				\
  	({								\
-		int __ret;						\
+		int __ret, __restored_state = __state;			\
  		__ret = -__RT(pthread_mutex_unlock(__lock));		\
-		pthread_setcancelstate(__state, NULL);			\
+		pthread_setcancelstate(__restored_state, NULL);		\
  		__ret;							\
  	})

-- 
Philippe.

