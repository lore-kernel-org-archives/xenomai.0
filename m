Message-ID: <51488665.3010505@wanadoo.fr>
Date: Tue, 19 Mar 2013 16:38:13 +0100
From: Thierry Bultel <thierry.bultel@wanadoo.fr>
MIME-Version: 1.0
References: <51482868.5020206@wanadoo.fr> <51483887.4020504@xenomai.org>
	<514854E3.2070707@xenomai.org>
In-Reply-To: <514854E3.2070707@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Limited kernel size for booting ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Really many thanks. This works like a charm.

I also add to hack into arch/arm/kernel/sleep.S,
because the "cpu_resume" is located in .data, and it had a 24bits jump 
to cpu_do_resume
that could not be relocated and led to a linker error.
I have simply removed the line, because I am not insterested in cpu 
suspend for my application anyway.

FYI, the freescale rel_imx_3.0.35_12.09.01 tag version of that file is 
closed enough to
the committed patch for being taken as is.

Also, this is not related, but I have been a little confused by failing 
attempts, because I had forgotten the "rootwait" bootarg,
which is mandatory with that kernel.

Cheers
Thierry

Le 19/03/2013 13:06, Gilles Chanteperdrix a écrit :
> On 03/19/2013 11:05 AM, Gilles Chanteperdrix wrote:
>
>> On 03/19/2013 09:57 AM, Thierry Bultel wrote:
>>
>>> Hi Gilles,
>>>
>>> First, I apologize for posting such a question that is sincerely not
>>> really related to xenomai.
>>> But I am using the kernel from ipipe-gch.git, branch ipipe-3.0-imx6q
>>>
>>> The issue I have is that it is not booting when using a really big
>>> built-in initramfs(about 60 Mo)
>>> It does not seem to reach "start_kernel", there is nomore log after
>>> Uboot says "Starting kernel"
>>>
>>> I have payed attention to address zones, and even tried to use an
>>> uncompressed kernel
>>> in the uImage container, to skip and discriminate the gzip phase. Same
>>> result.
>>>
>>> I do not have an operational Jtag probe yet, thus I only would like to
>>> get your opinion on
>>> this. To your mind, is this assumed to work ?
>>
>> No, the maximum size of initramfs is limited, you need to change the
>> linker script to put the initramfs at the end of the memory used by the
>> kernel, a patch exists to do that on the linux arm kernel mailing list
>> and has been merged in recent kernels.
>>
>>
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=3835d69a6c7048a28d0aea3cb8403d5e83a0f867
>

