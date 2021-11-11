MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Wed, 10 Nov 2021 23:33:16 -0800
Message-ID: <CA+K1mPFj0B28UNzcM-uF1Z6BPHVXO5sdceuyHhQEijU=qEwNNw@mail.gmail.com>
Subject: access errno in Xeno 3.1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai List <xenomai@xenomai.org>

I can compile a rtdm kernel module OK with Xenomai 3.1 but I can't
seem to get my module to see errno.

In several Xenomai example sources I see :
#include <errno.h>
but when I put that in my rtdm code I must also add to my Makefile:
-I/usr/src/linux/. Is that the right include path?

Even once I do all that, when I compile I get:
error: =E2=80=98errno=E2=80=99 undeclared (first use in this function)
          rtdm_printk("warning, munmap returned errno: %d\n", errno);

This is what I get when I do xeno-config:
/usr/xenomai/bin/xeno-config --skin=3Drtdm --cflags --ldflags
-I/usr/xenomai/include/cobalt -I/usr/xenomai/include -m32
-D_FILE_OFFSET_BITS=3D64 -D_GNU_SOURCE -D_REENTRANT
-fasynchronous-unwind-tables -D__COBA$
-Wl,--no-as-needed -Wl,@/usr/xenomai/lib/cobalt.wrappers
-Wl,@/usr/xenomai/lib/modechk.wrappers
/usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=3D$
(yes I built xenomai for 32 bit userspace apps)

What is the proper way to access errno?

thanks, -C Smith

