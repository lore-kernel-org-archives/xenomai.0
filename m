MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Thu, 16 Apr 2020 20:45:06 +0800
Message-ID: <CAAvDm6azJWrtUeOsiwB3F4AJtGJCAs=vV=NBenocR4zw4jy0TA@mail.gmail.com>
Subject: Could give me some guideline on how to locate the source code of the
 xenomai system calls.
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

     Could give me some guideline on how to locate the source code of
the xenomai system calls.

     I confirm that there is corresponding binary file after compiling
the source code which include xenomai and linux.You can see the log
listed below for detail.

     What puzzled me is that i could not locate the corresponding source
code.

    For example.
    The log to locate the system call named as cobalt_sched_yield.
    $ grep -inr cobalt_sched_yield
    Binary file kernel/xenomai/built-in.o matches
    Binary file kernel/xenomai/posix/xenomai.o matches
    Binary file kernel/xenomai/posix/syscall.o matches
    Binary file kernel/xenomai/posix/sched.o matches
    Binary file kernel/xenomai/posix/built-in.o matches
    Binary file kernel/built-in.o matches
    Binary file vmlinux matches
    Binary file .tmp_vmlinux2 matches
    $ #log end

    Look forward to hearing from you.
    Best regards.
