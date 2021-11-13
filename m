MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Fri, 12 Nov 2021 23:49:46 -0800
Message-ID: <CA+K1mPFKAZUUwv_rA1msEThhBQa8oVrPLMkc2fYkorW=zcQ+3w@mail.gmail.com>
Subject: native message queue API in rtdm
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai List <xenomai@xenomai.org>

Can I call rt_queue_create() and rt_queue_read() from an rtdm kernel module ?
This used to work OK in Xenomai 2 but now in Xeno3.1 when I attempt to
#include <native/queue.h> in my rtdm code I get this error:
In file included from /usr/xenomai/include/alchemy/queue.h:21,
                 from /usr/xenomai/include/trank/native/queue.h:21,
                 from /home/csmith/src/my_app.c:16:
/usr/lib/gcc/x86_64-redhat-linux/8/include/stdint.h:9:26: error: no
include path in which to search for stdint.h
 # include_next <stdint.h>

thanks, -C Smith

