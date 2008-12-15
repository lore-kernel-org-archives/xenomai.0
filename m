Message-ID: <4946A913.1000201@domain.hid>
Date: Mon, 15 Dec 2008 18:59:31 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BAY135-W17043C9D8D088770CB0748C6F40@domain.hid>	<49468135.6060602@domain.hid>
	<BAY135-W2875D734AB22FC0E2FD238C6F40@domain.hid>
In-Reply-To: <BAY135-W2875D734AB22FC0E2FD238C6F40@domain.hid>
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
Cc: jan.kiszka@domain.hid, xenomai@xenomai.org

Thomas Schaefer wrote:
> Hi,
> 
>> Date: Mon, 15 Dec 2008 17:09:25 +0100
>> From: jan.kiszka@domain.hid
>> To: thomas_schaefer_canada@domain.hid
>> CC: xenomai@xenomai.org
>> Subject: Re: BUG: soft lockup
>>
>> Hi,
>>
>> please don't post HTML mails, they are not parsable unless one switches
>> HTML mode on for mail reading (which at least I dislike to do).
>>
>  
> Sorry about that.
> 
>> Thomas Schaefer wrote:
>>> Hi,
>>>
>>> I am trying to use kernel version 2.6.27.8 and the latest stable version
>>> of xenomai 2.4.6.1 on a quad core xeon 5400.
>>>
>>> The kernel seems to load OK.
>>> [ 1.306673] I-pipe: Domain Xenomai registered.
>>> [ 1.311242] Xenomai: hal/x86_64 started.
>>> [ 1.316744] Xenomai: real-time nucleus v2.4.6 (Bamboo) loaded.
>>> [ 1.322786] Xenomai: starting native API services.
>>> [ 1.327580] Xenomai: starting POSIX services.
>>> [ 1.331973] Xenomai: starting RTDM services.
>>>
>>> But as soon as init starts the PC hangs in an endlass loop and I get:
>>> [ 69.793501] BUG: soft lockup - CPU#3 stuck for 61s! [init:1]
>>> [ 69.793501] Modules linked in:
>>> [ 69.793501] CPU 3:
>>> [ 69.793501] Modules linked in:
>>> [ 69.793501] Pid: 1, comm: init Not tainted 2.6.27.8 #1
>>> [ 69.793501] RIP: 0010:[] []
>>> native_flush
>>> _tlb_others+0xa5/0xe0
>>> [ 69.793501] RSP: 0000:ffff88007f849c58 EFLAGS: 00000202
>>> [ 69.793501] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
>>> 0000000000000000
>>> [ 69.793501] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
>>> 0000000000000000
>>> [ 69.793501] RBP: ffff88007f840000 R08: 0000000000000000 R09:
>>> 0000000000000000
>>> [ 69.793501] R10: 0000000000000000 R11: 0000000000000000 R12:
>>> 0000000000000000
>>> [ 69.793501] R13: 0000000000000000 R14: 0000000000000000 R15:
>>> 0000000000000000
>>> [ 69.793501] FS: 00007fbcbf7486e0(0000) GS:ffff88007f806a80(0000)
>>> knlGS:00000
>>> 00000000000
>>> [ 69.793501] CS: 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>>> [ 69.793501] CR2: 0000000000672b08 CR3: 000000007eb84000 CR4:
>>> 00000000000006e0
>>> [ 69.793501] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>>> 0000000000000000
>>> [ 69.793501] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
>>> 0000000000000400
>>> [ 69.793501]
>>> [ 69.793501] Call Trace:
>>> [ 69.793501]
>> Really no Stack trace available?
>>
> 
> Yes that's all there is.
> 
>>> The kernel runs fine without the Xenomai patch.
>>> I also tried the version in the current svn repository with the same result.
>>> Please let me know you what I can do to help to fix this or what
>>> additional info I should provide.
>> Does this problem also occurs when you
>> - disable CONFIG_XENOMAI?
>> - boot with maxcpus=2, and then maxcpus=1?
>  
> Disabling CONFIG_XENOMAI doesn't help but using maxcpus=2 or maxcpus=1 makes it boot again.

Could you try the following patch?

--- linux/include/asm-x86/irq_vectors.h~	2008-12-09 18:05:38.000000000 +0100
+++ linux/include/asm-x86/irq_vectors.h	2008-12-15 19:48:53.000000000 +0100
@@ -80,7 +80,7 @@
 #ifdef CONFIG_IPIPE
 #define INVALIDATE_TLB_VECTOR_END	0xf2
 #define INVALIDATE_TLB_VECTOR_START	0xf0	/* f0-f2 used for TLB flush */
-#define NUM_INVALIDATE_TLB_VECTORS	4	/* f3-f7 used by I-pipe */
+#define NUM_INVALIDATE_TLB_VECTORS	3	/* f3-f7 used by I-pipe */
 #else /* !CONFIG_IPIPE */
 #define INVALIDATE_TLB_VECTOR_END	0xf7
 #define INVALIDATE_TLB_VECTOR_START	0xf0	/* f0-f7 used for TLB flush */

-- 
                                                 Gilles.

