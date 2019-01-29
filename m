MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 29 Jan 2019 23:14:58 +0100
Message-ID: <CAFLxGvwZ6=4cKsDF68MA2Whv-HVwOVmcFSb0UtupbDyshUYM6w@mail.gmail.com>
Subject: [Xenomai] bad syscall <0x15b> on x86_64
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

When running a ia32 application on x86_64 I get bad syscall errors.
This happens with ipipe-core-4.14.89-x86-2.patch and xenomai 3.0.8.

The problem seems to be that both ipipe_handle_syscall() and
handle_head_syscall()
check for syscall-nr being >= NR_syscalls.
On ia32 the syscall table is larger and therefore the check is wrong.

So the code has to check the TS_COMPAT flag and then compare either to
NR_syscalls or IA32_NR_syscalls.
I gave this already a short try and things seem to work better.

-- 
Thanks,
//richard

