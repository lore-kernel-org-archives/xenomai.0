Message-ID: <48B2DCCC.4010303@domain.hid>
Date: Mon, 25 Aug 2008 18:24:44 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200808251743.26012@domain.hid>
In-Reply-To: <200808251743.26012@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_queue_delete returns -EBUSY
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai@xenomai.org

Petr Cervenka wrote:
> Hello,
> I tried xenomai 2.4.5, hoping that my problems with real-time queue will disappear. But there is another (perhaps very trivial) error.
> Function call rt_queue_delete always returns -EBUSY (at least for me). You don't have to bind it from another task or use it at all.
> I hope that I have used it in the right way.

Classic chicken-and-egg issue. Ok, will fix.

> Petr Cervenka
> 
> Simple example:
> 
> #include <stdlib.h>
> 
> #include <sys/mman.h>       // mlockall
> #include <native/task.h>
> #include <native/queue.h>
> 
> RT_TASK  main_task;
> RT_QUEUE queue;
> 
> int main(int argc, char** argv) {
>     int res;
>     
>     mlockall(MCL_CURRENT | MCL_FUTURE);
>     
>     res = rt_task_shadow(&main_task, "MAIN_TASK", 5, T_FPU);
>     if (res < 0) {
>         fprintf(stderr, "rt_task_shadow() failed: %d (%s)\n", res, strerror(-res));
>         goto cleanup_end;
>     }
>     
>     res = rt_queue_create(&queue, "QUEUE", 1024, Q_UNLIMITED, Q_FIFO | Q_SHARED);
>     if (res < 0) {
>         fprintf(stderr, "rt_queue_create() failed: %d (%s)\n", res, strerror(-res));
>         goto cleanup_task;
>     }
>     
> cleanup_queue:
>     res = rt_queue_delete(&queue);
>     if (res < 0) {
>         fprintf(stderr, "rt_queue_delete() failed: %d (%s)\n", res, strerror(-res));
>     }
> cleanup_task:
> cleanup_end:
>     return res;
> } 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

