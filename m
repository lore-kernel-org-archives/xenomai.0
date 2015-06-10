MIME-Version: 1.0
Date: Tue, 9 Jun 2015 23:44:33 -0700
Message-ID: <CA+K1mPEsWRfYyjxac5dGiH0DuUHWGZ2H-jxvNC_YuyfN15O=+w@mail.gmail.com>
From: C Smith <csmithquestions@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Does Xenomai export shared memory keys to Linux kernel?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I have been developing a set of shared memory applications.
The first is a real time Xenomai kernelspace app which creates a block of
shared memory. This uses shm_open(), mmap() of the POSIX skin.

Once created, the shared memory shows up OK in /proc/xenomai/heap
$ cat /proc/xenomai/heap
    TOTAL      USED  PAGESZ  NAME
  ...
    12288     12288    4096  posix shm: /shared_data_unique

I can then successfully mmap() this shared memory from a userspace app
which includes xenomai headers and is linked to the xenomai libraries.
Here is how I compiled the userspace app for xenomai:
gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__
-I/usr/xenomai/include/posix -Xlinker -rpath -Xlinker /usr/xenomai/lib
userspace-shmem.c  -Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib
-lpthread_rt -lxenomai -lpthread -lrt  -lrtdm -L/usr/xenomai/lib -lxenomai
-lpthread -lrt -o userspace-shmem

The problem is that if I compile the userspace app without xenomai, with
paths to regular Linux headers, the app cannot get the shared memory
segment.
Here is how I compiled the userspace app without xenomai:
gcc -o userspace-shmem userspace-shmem.c -lrt

The call to shm_open() in the userspace app returns -1 and errno is set to
2 : No such file or directory.

Also,
ipcs -m
doesnt show the existence of my shared memory key.

Does xenomai export its shared memory segments to the Linux kernel? Does
the Linux kernel know about them such that a plain linux app (with no
xenomai linkage) would be able to access shared memory created by a xenomai
kernelspace driver?

-CSmith
