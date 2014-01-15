Message-ID: <52D6AF12.8070709@xenomai.org>
Date: Wed, 15 Jan 2014 16:53:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1389793982-18114-1-git-send-email-sr@denx.de>
 <52D6980B.3080605@xenomai.org> <52D69D86.4060403@denx.de>
In-Reply-To: <52D69D86.4060403@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v2] hal/arm: Add Zynq v3.5.7 patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stefan Roese <sr@denx.de>
Cc: xenomai@xenomai.org

On 01/15/2014 03:39 PM, Stefan Roese wrote:
> On 15.01.2014 15:15, Gilles Chanteperdrix wrote:
>> On 01/15/2014 02:53 PM, Stefan Roese wrote:
>>> Xilinx Zynq is already supported in the mainline Xenomai git repository.
>>> This patch adds support for the v3.5.7 Linux Kernel with the latest
>>> arm-6 i-pipe patch additionally to the already present v3.8 support.
>>>
>>> Signed-off-by: Stefan Roese <sr@denx.de>
>>> ---
>>> v2:
>>> - Base pre-patch on top of a different git reopsitory based on v3.5.7
>>> - Remove defconfig and other board specific stuff from post-patch
>>> - All this leads to minimal pre- and post- patches as requested
>>>     by Gilles
>>
>> Hi Stefan,
>>
>> this looks fine to me, except:
>>
>>
>>> +diff --git a/arch/arm/kernel/ipipe.c b/arch/arm/kernel/ipipe.c
>>> +index ff4ad1a..cf5f29b 100644
>>> +--- a/arch/arm/kernel/ipipe.c
>>> ++++ b/arch/arm/kernel/ipipe.c
>>> +@@ -574,8 +574,6 @@ EXPORT_SYMBOL_GPL(__ipipe_serial_debug);
>>> +
>>> + EXPORT_SYMBOL_GPL(do_munmap);
>>> + EXPORT_SYMBOL_GPL(show_stack);
>>> +-EXPORT_SYMBOL_GPL(init_mm);
>>> +-EXPORT_SYMBOL_GPL(cpu_architecture);
>>> + #ifndef MULTI_CPU
>>> + EXPORT_SYMBOL_GPL(cpu_do_switch_mm);
>>> + #endif
>>
>> If you need to remove these two lines, they should be removed from the
>> I-pipe patch itself, not in the Zynq-specific patch. But, why do you
>> need to remove them?
>
> Its a long time since I implemented this patch. I just rechecked and
> without this removal, I get the following compilation/linking error:
>
> ...
>    LINK    vmlinux
>    LD      vmlinux.o
> mm/built-in.o: In function `__crc_init_mm':
> migrate.c:(*ABS*+0x3d9f9d12): multiple definition of `__crc_init_mm'
> make: *** [vmlinux] Error 1
>
> Any other (recommended) way to solve this?

Could you send me your .config?


-- 
					    Gilles.

