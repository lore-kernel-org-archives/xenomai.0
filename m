MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Sat, 20 Nov 2021 00:10:49 -0800
Message-ID: <CA+K1mPFYLvrxSSnFqZ8DAbaCbDRX47OfAmgKQBJBwAdC3=6JsA@mail.gmail.com>
Subject: posix blocking in gdb
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai List <xenomai@xenomai.org>

I am debugging a Cobalt userspace real time app (using posix/alchemy
skins) on Xenomai 3.1, X86 platform. I have a problem with my process
blocking when I am single-stepping in gdb (although the process does
not block when it is run full speed). This happens with ioctl(),
write() or read() of a rtdm device.

If the code does an ioctl() for instance, this is invoked:
in rtdm.c
COBALT_IMPL(int, ioctl, (int fd, unsigned int request, ...))
   ret = do_ioctl(fd, request, arg);
which calls
 static int do_ioctl(int fd, unsigned int request, void *arg)
   ret = XENOMAI_SYSCALL3(sc_cobalt_ioctl, fd, request, arg);

 and my process blocks on the call to XENOMAI_SYSCALL3() so I cannot
step over this code. If I interrupt gdb, it says:
  0xf7fceb69 in __kernel_vsyscall ()Which basically means my process
was blocked.

I imagine the problem is caused by a difference between
primary/secondary modes and their ability to access the Cobalt posix
wrappers? The problem is that I need to step over
read()/write()/ioctl() while in gdb. Is there any way to do so ?

thanks, -C Smith

