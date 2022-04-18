MIME-Version: 1.0
From: Yunjie Gu <yunjie.gu1@gmail.com>
Date: Tue, 19 Apr 2022 00:21:09 +0100
Message-ID: <CAKcohPyu6ywryC6qS+6WBFxuBUnmw0sDKuN9Sqbh-O2ktxV8og@mail.gmail.com>
Subject: hard_preempt_disable inconsistent
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi All,

I'm trying to use xenomai on linux 5.4. I previously used xenomai 3.0 on
linux 4.9 and xenomai 3.1 on linux 4.19 and both were fine. However when I
use xenomai 3.2.1 on linux 5.4 there are errors in compile. One of the
errors says
expected expression before ')' token (__flags) = hard_preempt_disable();
for the macro below in fpsimd.c:
#define get_cpu_fpsimd_context(__flags) \ do { \ (__flags) =
hard_preempt_disable(); \ __get_cpu_fpsimd_context(); \ } while (0)

hard_preempt_disable is also a macro defined in preempt.h:
#define hard_preempt_disable() \ ({ \ unsigned long __flags__; \ __flags__
= hard_local_irq_save(); \ if (__ipipe_root_p) \ preempt_disable(); \
__flags__; \ })

It is clear that hard_preempt_disable() should be a function-like macro but
is actually not. It seems to me that there are inconsistencies in the ipipe
patch I used. I used ipipe-core-5.4.72-arm64-0.patch. Anyone has a
suggestion on I can I resolve this issue?

Best Regards,
Yunjie
