Subject: Re: [Xenomai-help] Kernel Oops with latest SVN Xenomai
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <7803102.1167838186182.JavaMail.ngmail@domain.hid>
References: <7803102.1167838186182.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 17:19:20 +0100
Message-Id: <1167841160.18647.24.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-01-03 at 16:29 +0100, M. Koehrer wrote:
> Hi all,
> 
> using the latest SVN version of Xenomai and the integrated patches on a 2.6.19 kernel

Which means? 1.6-03 + the tasklist_lock fix?

> I get a kernel Oops with my application and the system freezes.
> Here is the oops:
> ------------[ cut here ]------------
> kernel BUG at fs/buffer.c:1233!

> [__user_walk_fd+48/66] __user_walk_fd+0x30/0x42
> [vfs_stat_fd+30/82] vfs_stat_fd+0x1e/0x52
> [__handle_mm_fault+1686/1810] __handle_mm_fault+0x696/0x712
> [<e0a03096>] schedule_event+0x0/0x13c [xeno_nucleus]

[...]

At first sight, the backtrace is close to meaningless, and in any case,
really weird. Either the kernel badly misses unwinding information, or
you have a real build problem pending. Try enabling CONFIG_DEBUG_KERNEL
if not already done to get full backtracing support, and don't forget to
reinstall all modules if any.

> Unfortunately I have no idea, what causes this oops.
> Is there anybody that has some hints on this oops?

It's always more efficient to compile all Xenomai support statically
into the kernel instead of using modules when debugging: virtual address
mapping to symbolic info is much easier.

-- 
Philippe.



