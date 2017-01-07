From: Peter <linux@p-p-it.de>
Message-ID: <b49315df-4843-107f-d25f-50731a862e6c@p-p-it.de>
Date: Sat, 7 Jan 2017 09:44:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] rtdm task documentation bug
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I set up a simple test for a rtdm task and followed the example on the
bottom of the "Task Services" documentation. I think, there is a
rtdm_wait_complete call missing on the producer side in order to release
the waiting side out of the waiting condition.

I'm on the stable-3.0.x branch, but the same applies for the master
branch.

Patch:

diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
index 1a79121..930c79a 100644
--- a/kernel/cobalt/rtdm/drvlib.c
+++ b/kernel/cobalt/rtdm/drvlib.c
@@ -393,6 +393,7 @@ int rtdm_task_busy_wait(bool condition, nanosecs_rel_t spin_ns,
  *    wc = rtdm_wait_get_context(task);
  *    wait_context_ptr = container_of(wc, struct some_wait_context, wc);
  *    wait_context_ptr->output_value = 12;
+ *    rtdm_wait_complete(wc);
  * }
  * rtdm_waitqueue_broadcast(&wq);
  * @endcode

