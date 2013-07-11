Message-ID: <51DF2814.5000404@gmail.com>
Date: Thu, 11 Jul 2013 23:48:04 +0200
From: Sagar Behere <sagar.behere@gmail.com>
MIME-Version: 1.0
References: <51DD7302.2010809@gmail.com> <51DEF7EA.4030606@xenomai.org>
In-Reply-To: <51DEF7EA.4030606@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] failing compile of kernel-3.8 on arm
Reply-To: sagar.behere@gmail.com
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

On 07/11/2013 08:22 PM, Gilles Chanteperdrix wrote:
> On 07/10/2013 04:43 PM, Sagar Behere wrote:
>
>> Hello,
>>
>> I patched the vanilla linux-3.8 kernel sources with
>> ipipe-core-3.8-arm-1.patch. The patch was applied cleanly, but while
>> compiling the kernel, I get two problems
>>
>> Problem 1: This is the same as
>> http://www.mail-archive.com/xenomai@xenomai.org/msg02719.html
>>
>> Problem 2: The compilation halts with
>
>
>> include/asm-generic/xenomai/syscall.h: In function
>> ‘__xn_safe_strncpy_from_user’:
>> include/asm-generic/xenomai/syscall.h:147: error: implicit declaration
>> of function ‘__strncpy_from_user’
>> make[3]: *** [kernel/xenomai/nucleus/bufd.o] Error 1
>> make[2]: *** [kernel/xenomai/nucleus] Error 2
>> make[1]: *** [kernel/xenomai] Error 2
>> make: *** [kernel] Error 2
>>
>> ----
>>
>> compiler is: arm-linux-gnueabi-gcc (Debian 4.4.5-8) 4.4.5
>>
>> Any ideas how to fix these issues? I'll be running this kernel on the
>> gumstix overo, if that matters..
>
>
> Please use xenomai git current head instead of xenomai 2.6.2.1 release.
> Xenomai 2.6.2.1 only supports I-pipe patches up to Linux 3.5 on ARM.
> (in general, the latest I-pipe patch supported by a Xenomai version is
> the one it ships with).

Oh! I did not know that.

I now did: git clone git://git.xenomai.org/xenomai-head.git

and everything compiled properly in the subsequent steps.

Thanks,
Sagar

