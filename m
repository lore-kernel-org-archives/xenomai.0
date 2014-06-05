MIME-Version: 1.0
Date: Thu, 5 Jun 2014 14:12:04 +0530
Message-ID: <CAC66z96GX9uNm_cgzV_RSPQbep4RnwMaTwUW7qLsvfofweBkMw@mail.gmail.com>
From: yogesh garg <yogesh.garg1983@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] System hangs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Everyone,
I am using rt_heap_create() in my init_module(). rt_heap_create is
returning 0(success).
But after this API my system gets hang.

something like
#include <native/heap.h>
RT_HEAP heap_desc;
int init_module (void)
{
   int ret;

    ret = rt_heap_create (&heap_desc, "MyHeap", 4*1024, H_SINGLE | H_FIFO);
    if (ret) {
        printk ("MY_MODULE: Error rt_heap_create: %d\n", ret);
    }
    printk ("MY_MODULE: heap memory created, name: MyHeap\n");
    return ret;
}

when I am running insmod command to insert it dmesg prints
"MY_MODULE: heap memory created, name: MyHeap"
but system hangs after that.

Please someone suggest me what could be the problem.
-- 
Regards,
Yogesh Garg
