MIME-Version: 1.0
From: Andreas Glatz <andi.glatz@gmail.com>
Date: Fri, 8 Dec 2017 13:14:16 +0000
Message-ID: <CAKJ14Nccx5_Up-7dDK1U1Meu_vQA5TgxoHkyML8dcFDZMdbYwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] mode switch caused by __lll_lock_wait_private()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi

We're testing our application now by running it continuously over
weeks. I randomly reports the following mode switches in the log:

<SIGXCPU: MSW(invoked syscall) BT(4): 0x2ade5bc8 0x2af95840 0x2b03a420 0x93980 >

With the process memory map from /proc/<pid>/maps:

...
2af68000-2b084000 r-xp 00000000 00:0d 22235 /lib/libc-2.14.1.so
...

and output from <cross-arm>-objdump -d /lib/libc-2.14.1.so

I could figure out that 0x2b03a420 corresponds to glibc's
__lll_lock_wait_private() function, which seems to cause SIGXCPU.

Before digging any deeper did anyone else see Xenomai mode switches
caused by this glibc function (google says that it's e.g. used for
managing concurrent access to rand())?

Cheers,

A.

