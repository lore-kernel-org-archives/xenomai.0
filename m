Date: Mon, 25 Aug 2008 17:43:59 +0200
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200808251743.26012@domain.hid>
Content-Type: text/plain; charset="windows-1250"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] rt_queue_delete returns -EBUSY
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,
I tried xenomai 2.4.5, hoping that my problems with real-time queue will disappear. But there is another (perhaps very trivial) error.
Function call rt_queue_delete always returns -EBUSY (at least for me). You don't have to bind it from another task or use it at all.
I hope that I have used it in the right way.
Petr Cervenka

Simple example:

#include <stdlib.h>

#include <sys/mman.h>       // mlockall
#include <native/task.h>
#include <native/queue.h>

RT_TASK  main_task;
RT_QUEUE queue;

int main(int argc, char** argv) {
    int res;
    
    mlockall(MCL_CURRENT | MCL_FUTURE);
    
    res = rt_task_shadow(&main_task, "MAIN_TASK", 5, T_FPU);
    if (res < 0) {
        fprintf(stderr, "rt_task_shadow() failed: %d (%s)\n", res, strerror(-res));
        goto cleanup_end;
    }
    
    res = rt_queue_create(&queue, "QUEUE", 1024, Q_UNLIMITED, Q_FIFO | Q_SHARED);
    if (res < 0) {
        fprintf(stderr, "rt_queue_create() failed: %d (%s)\n", res, strerror(-res));
        goto cleanup_task;
    }
    
cleanup_queue:
    res = rt_queue_delete(&queue);
    if (res < 0) {
        fprintf(stderr, "rt_queue_delete() failed: %d (%s)\n", res, strerror(-res));
    }
cleanup_task:
cleanup_end:
    return res;
} 


