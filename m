References: <mailman.3.1647601201.30395.xenomai@xenomai.org>
 <CAESnvfPvby7Wi5ncyB-KZQgR69pQ1p+6Xh5uVxMJUnKpQPaHqg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Xenomai Digest, Vol 119, Issue 50
Date: Fri, 22 Apr 2022 11:23:47 +0200
In-reply-to: <CAESnvfPvby7Wi5ncyB-KZQgR69pQ1p+6Xh5uVxMJUnKpQPaHqg@mail.gmail.com>
Message-ID: <87a6cda2sr.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ashwik John <johnashwik994@gmail.com>
Cc: xenomai@xenomai.org


Ashwik John via Xenomai <xenomai@xenomai.org> writes:

> Hi,
>
> I have the same problem when running #evl test.
>
> basic-xbuf: OK
> clock-timer-periodic: OK
> clone-fork-exec: OK
> detach-self: OK
> duplicate-element: OK
> element-visibility: OK
> fault: OK
> fpu-preload: OK
> fpu-stress: OK
> heap-torture: OK
> mapfd: OK
> monitor-deadlock: OK
> monitor-event: OK
> monitor-flags: OK
> monitor-pi: OK
> monitor-pi-deadlock: OK
> monitor-pp-dynamic: OK
> monitor-pp-lower: OK
> monitor-pp-nested: OK
> monitor-pp-pi: OK
> monitor-pp-raise: OK
> monitor-pp-tryenter: OK
> monitor-pp-weak: OK
> monitor-steal: OK
> monitor-wait-multiple: OK
> observable-hm: OK
> observable-inband: OK
> observable-master: OK
> observable-onchange: OK
> observable-oob: OK
> observable-race: OK
> observable-thread: OK
> poll-close: OK
> poll-flags: OK
> poll-many: OK
> *** stack smashing detected ***: <unknown> terminated
> Aborted (core dumped)
> ** poll-multiple: BROKEN
>
>
> (gdb) run
> Starting program: /usr/evl/tests/poll-multiple
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> [New Thread 0x7ffff7ff0700 (LWP 18985)]
> [New Thread 0x7ffff7fd7700 (LWP 18988)]
> [Thread 0x7ffff7ff0700 (LWP 18985) exited]
> *** stack smashing detected ***: <unknown> terminated
> [Thread 0x7ffff7fd7700 (LWP 18988) exited]
>
> Thread 1 "poll-multi:1898" received signal SIGABRT, Aborted.
> __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:51
> 51 ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
> (gdb) backtrace
> #0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:51
> #1  0x00007ffff75f67f1 in __GI_abort () at abort.c:79
> #2  0x00007ffff763f837 in __libc_message (action=action@entry=do_abort,
> fmt=fmt@entry=0x7ffff776c869 "*** %s ***: %s terminated\n") at
> ../sysdeps/posix/libc_fatal.c:181
> #3  0x00007ffff76eab31 in __GI___fortify_fail_abort
> (need_backtrace=need_backtrace@entry=false, msg=msg@entry=0x7ffff776c847
> "stack smashing detected") at fortify_fail.c:33
> #4  0x00007ffff76eaaf2 in __stack_chk_fail () at stack_chk_fail.c:29
> #5  0x0000555555401d27 in main ()
>
> Thank you for your support to solve this issue.
>

Fixed by this commit:

https://source.denx.de/Xenomai/xenomai4/linux-evl/-/commit/c6475a83706167e60ddf2c303f136b97a8f25c59

-- 
Philippe.

