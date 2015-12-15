Date: Tue, 15 Dec 2015 18:19:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151215171941.GB5162@hermes.click-hack.org>
References: <uilidxdi7i7s3a3vwg8fck63.1450082790936@email.android.com>
 <20151214223224.GC16627@hermes.click-hack.org>
 <6a938112.13b59.151a50746f4.Coremail.flyingfox_hu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a938112.13b59.151a50746f4.Coremail.flyingfox_hu@163.com>
Subject: Re: [Xenomai] Question on linux+xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Guoquan Hu <flyingfox_hu@163.com>
Cc: xenomai@xenomai.org

On Tue, Dec 15, 2015 at 05:44:56PM +0800, Guoquan Hu wrote:
> Thank Gilles very much!
> 
> You are right, I don't find CONFIG_XENO_OPT_WATCHDOG in xenomai 2.5.4 configure file.

You are probably not looking in the right place, this is a kernel
configuration and it is indeed present in xenomai 2.5:
https://git.xenomai.org/xenomai-2.5.git/tree/ksrc/nucleus/Kconfig#n321

> 
> I have additional questions as follow, would you please have a look and give some advices?
> 
> 1. I don't understand yet how the watchdog work to kill real time
> thread which occupied too much memory or CPU time, the real time
> thread run too slow to feed the watchdog?

The the option explanation in the above link. The watchdog does not
kill real-time threads which occupy too much memory.

> 
> 2. I know linux kernel have a mechanism called oom-killer, would it cause real time thread killed?

Real-time processes, yes.

> 
> 3. sometime I got message " BUG: soft lockup - CPU#x stuck for xxs! "on my environment, and it print out some register value, such as:
> 
> RIP: 0010:[<ffffffff813ad762>]  [<ffffffff813ad762>] _spin_lock+0x21/0x2a
> RSP: 0018:ffff88021dd1bdb8  EFLAGS: 00000297
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffffff8100c58e R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f13e8663700(0000) GS:ffff88044e480000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 00007f140b2b6f60 CR3: 000000043c92e000 CR4: 00000000000406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> 
> Any clue can be found from these messages? how to debug for
> spin_lock issue?

The important part of the message is the backtrace which follows the
registers dump. It should show you which spinlock is the problem. In
order to get a full backtrace, please make sure to enable all
relevant options: verbose bug support, and maybe frame pointers
support.

> 
> 4. Is there any limit on the number of real time thread? if more
> than 20 real time threads are created, will they cause the xenomai
> unstable?

No, if you create too many threads, you may exhaust a pool, so a
thread creation would fail, that is all. If your application does
not check for possible failures, and continues running, then yes,
the system may become unstable, with such nasty things as infinite
loops in primary mode, but that is your application making the
system unstable, not Xenomai.

> 
> 5. Process MUST wait for all real time threads it created exit
> safely, then can it exit?

A process may call exit at any time it pleases, Xenomai will
destroyed the threads, and all the objects allocated by the process.

> 
> BTW, I want to update linux to 3.16.7, which close to the kernel
> version of debian 8.2.0, and update xenomai to 3.0.1, what do you
> think about stability  of linux(3.16.7)+xenomai(3.0.1)? Any
> problem reported on this xenomai 3.0.1?

Linux 3.16 is EOL, it is a bad choice, since you are going to
recompile a kernel anyway, you have no reason to use the same kernel
version as Debian, you can use a more recent one such as Linux 3.18.

Regards.

-- 
					    Gilles.
https://click-hack.org

