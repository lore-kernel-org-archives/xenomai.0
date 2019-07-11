MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 11 Jul 2019 10:15:24 +0200
Message-ID: <CAFLxGvyW2aXNScNQb6rCQtS5AXd_NYYrw+qcjax_H_xiByL8WQ@mail.gmail.com>
Subject: Question on deleting a locked RT_MUTEX
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

Hi!

doc/asciidoc/MIGRATION.adoc states:
- For consistency with the standard glibc implementation, deleting a
  RT_MUTEX object in locked state is no longer a valid operation.

I'm not sure how this affects my Xenomai 2 application which is being
ported to Xenomai 3.

If I have a mutex m1 and a misbehaving RT_TASK rt1 which exits right after
acquiring mutex m1, what is the recommended way to get the lock back into a
well defined state?

-- 
Thanks,
//richard

