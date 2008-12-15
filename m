Message-ID: <49468135.6060602@domain.hid>
Date: Mon, 15 Dec 2008 17:09:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <BAY135-W17043C9D8D088770CB0748C6F40@domain.hid>
In-Reply-To: <BAY135-W17043C9D8D088770CB0748C6F40@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] BUG: soft lockup
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas Schaefer <thomas_schaefer_canada@domain.hid>
Cc: xenomai@xenomai.org

Hi,

please don't post HTML mails, they are not parsable unless one switches
HTML mode on for mail reading (which at least I dislike to do).

Thomas Schaefer wrote:
> Hi,
>  
> I am trying to use kernel version 2.6.27.8 and the latest stable version
> of xenomai 2.4.6.1 on a quad core xeon 5400.
>  
> The kernel seems to load OK.
> [    1.306673] I-pipe: Domain Xenomai registered.
> [    1.311242] Xenomai: hal/x86_64 started.
> [    1.316744] Xenomai: real-time nucleus v2.4.6 (Bamboo) loaded.
> [    1.322786] Xenomai: starting native API services.
> [    1.327580] Xenomai: starting POSIX services.
> [    1.331973] Xenomai: starting RTDM services.
>  
> But as soon as init starts the PC hangs in an endlass loop and I get:
> [   69.793501] BUG: soft lockup - CPU#3 stuck for 61s! [init:1]
> [   69.793501] Modules linked in:
> [   69.793501] CPU 3:
> [   69.793501] Modules linked in:
> [   69.793501] Pid: 1, comm: init Not tainted 2.6.27.8 #1
> [   69.793501] RIP: 0010:[<ffffffff8021de25>]  [<ffffffff8021de25>]
> native_flush
> _tlb_others+0xa5/0xe0
> [   69.793501] RSP: 0000:ffff88007f849c58  EFLAGS: 00000202
> [   69.793501] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> 0000000000000000
> [   69.793501] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000000
> [   69.793501] RBP: ffff88007f840000 R08: 0000000000000000 R09:
> 0000000000000000
> [   69.793501] R10: 0000000000000000 R11: 0000000000000000 R12:
> 0000000000000000
> [   69.793501] R13: 0000000000000000 R14: 0000000000000000 R15:
> 0000000000000000
> [   69.793501] FS:  00007fbcbf7486e0(0000) GS:ffff88007f806a80(0000)
> knlGS:00000
> 00000000000
> [   69.793501] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [   69.793501] CR2: 0000000000672b08 CR3: 000000007eb84000 CR4:
> 00000000000006e0
> [   69.793501] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [   69.793501] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
> 0000000000000400
> [   69.793501]
> [   69.793501] Call Trace:
> [   69.793501]

Really no Stack trace available?

> 
> The kernel runs fine without the Xenomai patch.
> I also tried the version in the current svn repository with the same result.
> Please let me know you what I can do to help to fix this or what
> additional info I should provide.

Does this problem also occurs when you
 - disable CONFIG_XENOMAI?
 - boot with maxcpus=2, and then maxcpus=1?

Additionally, could you provide your .config?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 26
Corporate Competence Center Embedded Linux

