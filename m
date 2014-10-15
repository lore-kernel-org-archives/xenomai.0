MIME-Version: 1.0
Date: Wed, 15 Oct 2014 18:42:50 +0300
Message-ID: <CABaOOZ2YOda_cUS-tskNxDZ6sNekMqnPnbu6p8Qp4kvjRzDMyA@mail.gmail.com>
From: Stratiyenko Roman <picoworm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Manual context switch from userspace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

hello,

Can anyone suggest how to solve next problem?

I need to use the context switch (ucontext.h glibc function) in xenomai
task. But the problem is the swapcontext() make a kernel call that switches
system to secondary mode, so I can't achive hard real time.

What can I do to switch context without switch to secondary mode?
Thanks in advance

Best regards,
Roman
