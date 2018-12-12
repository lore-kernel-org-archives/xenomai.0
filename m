Subject: Re: ipipe-arm64 kernel issue
References: <8C8014A3-6A93-4E44-B753-49AC9FA313A3@korgrd.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <58308e88-38d2-e4ea-232e-8f84dfe1fbd4@xenomai.org>
Date: Wed, 12 Dec 2018 11:21:36 +0100
MIME-Version: 1.0
In-Reply-To: <8C8014A3-6A93-4E44-B753-49AC9FA313A3@korgrd.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve Pavao <stevep@korgrd.com>, xenomai@xenomai.org

On 12/11/18 10:25 PM, Steve Pavao via Xenomai wrote:
> I have 2 different, basic apps that oops in a very similar way on ipipe-arm64 running on R Pi 3B.  One of them is rpm, another is my own program.
> 
> Here is the partial backtrace for the ‘rpm’ oops.  The backtrace for my other program is almost identical.  (I’ve left out interim calls to keep this email concise.)
> 
> [  124.816179] [<ffffff8008260480>] __find_get_block+0x2a0/0x400
> ...
> [  124.816311] [<ffffff8008778b88>] do_page_fault+0x268/0x4e0
> [  124.816320] [<ffffff8008778e6c>] do_translation_fault+0x6c/0x7c
> [  124.816330] [<ffffff80080814ec>] do_mem_abort+0x54/0xc8
> 
> The BUG finally occurs at line 1279 of buffer.c:
> 
> static inline void check_irqs_on(void)
> {
> #ifdef irqs_disabled
> 	BUG_ON(irqs_disabled());   //  <———— here
> #endif
> }
> 
> The above BUG happens during the page fault recovery process.  (FYI, some of the calls between do_page_fault_and __find_get_block are ext4 calls.)
> 
> In both apps, the oops happens around the time of file creation on the SD card:  For rpm, it is during an install of a valid rpm package, for the other app, it occurs at the time a sqlite database is opened.  This is basic stuff that should just work.
> 
> I am looking for ideas about what could be wrong with the setup/configuration of my ipipe-arm64 system, such that some apps that read/write to the SD card are oopsing this way when doing page fault recovery.

This is a bug in the I-pipe layer. Assuming you are still running kernel
4.9, please try 4.14 from [1], it fixes several issues which still exist
in the 4.9 pipeline.

[1] https://gitlab.denx.de/Xenomai/ipipe-arm64/commits/stable/4.14.71-arm64


-- 
Philippe.

