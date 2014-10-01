MIME-Version: 1.0
Date: Thu, 2 Oct 2014 00:27:34 +0300
Message-ID: <CANgF67Q+ZneJM-osJT07NS45AWaZEPetHjUL5EBc5SvW0Dc7rQ@mail.gmail.com>
From: agnes jurek <agnessjurek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] nucleus/sched.h: No such file or directory
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I tried to write simple code myself using xenomai rtdm module. When I added
"
#include <xenomai/rtdm/rtdm.h>", compilation  was ok. But when I added "
#include <xenomai/native/task.h>", I got an error message. It said that
"/usr/include/xenomai/native/task.h:25:27: fatal error: nucleus/sched.h: No
such file or directory
compilation terminated."
