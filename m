References: <77f54229.2964.1644403f006.Coremail.v907240791@163.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d8e6a576-fb31-92ed-a304-eb9f57c38f87@xenomai.org>
Date: Thu, 28 Jun 2018 09:59:27 +0200
MIME-Version: 1.0
In-Reply-To: <77f54229.2964.1644403f006.Coremail.v907240791@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Some Problem with build sam5d36 IMAGE
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?MTDlubQ=?= <v907240791@163.com>, xenomai@xenomai.org

On 06/28/2018 03:31 AM, 10年 wrote:
> ./prepare-kernel.sh --arch=arm --adeos=/usr/src/linux/ipipe-core-4.14.36-arm-1.patch --linux=/usr/src/linux/linux-4.14.36
> make menuconfig     ----and I load file in /usr/src/linux/linux-4.14.36/arch/arm/configs/sama5_defconfig   --and save in /usr/src/linux/linux-4.14.36/.config
> 
> make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- bzImage modules
> 
> That's all I do, while building, some errors coming that :
> 
> 
>  AS      arch/arm/xenomai/switch.o
>   CC      arch/arm/xenomai/syscall.o
> In file included from arch/arm/xenomai/include/asm/xenomai/syscall.h:29:0,
>                  from arch/arm/xenomai/syscall.c:22:
> ./include/asm-generic/xenomai/syscall.h: In function 'cobalt_copy_from_user':
> ./include/asm-generic/xenomai/syscall.h:49:3: error: implicit declaration of function '__copy_from_user_inatomic' [-Werror=implicit-function-declaration]
>    __xn_copy_from_user(dst, src, size)) ? -EFAULT : 0;
>    ^
> ./include/asm-generic/xenomai/syscall.h: In function 'cobalt_copy_to_user':
> ./include/asm-generic/xenomai/syscall.h:56:3: error: implicit declaration of function '__copy_to_user_inatomic' [-Werror=implicit-function-declaration]
>    __xn_copy_to_user(dst, src, size)) ? -EFAULT : 0;
>    ^
> cc1: some warnings being treated as errors
> scripts/Makefile.build:328: recipe for target 'arch/arm/xenomai/syscall.o' failed
> make[1]: *** [arch/arm/xenomai/syscall.o] Error 1
> Makefile:1040: recipe for target 'arch/arm/xenomai' failed
> make: *** [arch/arm/xenomai] Error 2
> 
> 
> 
> 
> Can any body help me ?
> 

Support for kernel 4.14 was introduced in Xenomai 3.0.7.

-- 
Philippe.

