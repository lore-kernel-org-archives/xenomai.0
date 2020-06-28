MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Sun, 28 Jun 2020 14:04:38 +0800
Message-ID: <CAAvDm6Yqpo8uPbxLzVQvPcj0zYTgyeZ75z=tEaeqoyv70mZ46g@mail.gmail.com>
Subject: Despite memory size, is there some limitation on how many realtime
 processes or threads that could run in parallel?
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi, list
       I am using xenomai-v3.1+linux4.19.
       I saw the error message below when I have successfully created 123
processes(i.e. execute "/usr/xenomai/cyclictest" ). There is still plenty of
memory(i.e.more than 5GB) on the platform when it occurs.
       And I could only successfully created 82 processes(i.e. execute
 "/usr/xenomai/cyclictest -t 3").
       Is there some limitation on how many realtime processes or threads
could run in parallel?
      Since 2*123 is equivalent to 3*82 and they both a little less than 256,
so I guess there are at most 256 realtime threads that could run in parallel
on the same platform.
      When I am writing this email, I remember that I have seen the related
code snippet somewhere that leads to the said limitation, but I could not
find it out right now.
      If my guess is right, I wonder why I can only create 246 realtime threads
other than 256?

      Here is the error message:
      /usr/xenomai/demo/cyclictest
      # /dev/cpu_dma_latency set to 0us
      FATAL: failed to create thread 0: Resource temporarily unavailable

     /usr/xenomai/demo/xddp-label
     pthread_create: Resource temporarily unavailable

Thank you for your attention to this matter.
Look forward to hearing from you.
Best Regards.

