MIME-Version: 1.0
Date: Sat, 23 Nov 2013 17:56:04 +0330
Message-ID: <CAKKWdtdkR9QieGJ53owbkWD6fjO8ATep8BMMD7g1C2y3anWknQ@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] some questions: domains and user/kernel code
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

I wonder if any one can answer the following questions:

1) Some native functions like rt_cond_bind(), make a task switch to
primary mode. If i have a regular linux task (not a xenomai task!) and
i use the above function, will it become a Xenomai task which is
running in the primary mode?

2) If i define a heap in user sapce, can a kernel-space code bind to
that heap to read its data?

