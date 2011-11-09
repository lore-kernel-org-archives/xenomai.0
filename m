Message-ID: <4EBAA089.2050607@domain.hid>
Date: Wed, 09 Nov 2011 16:47:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEhuWcW0RS=r-U1W3Ciyw7Wmpvdp3A4GBJzvxa_qV7xmyNPgDw@domain.hid>
	<CAEhuWcWJ39Zqk-BvUT0ix5qxVRa-K=bSmJS=7CVVORMEFf4DYg@domain.hid>
In-Reply-To: <CAEhuWcWJ39Zqk-BvUT0ix5qxVRa-K=bSmJS=7CVVORMEFf4DYg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Fwd: problem in installing xenomai on arm
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xinxin wei <weixinxin63@domain.hid>
Cc: xenomai@xenomai.org

On 11/09/2011 03:07 PM, xinxin wei wrote:
> ./configure     --build=i686-pc-linux-gnu  --host=arm-linux 
> --enable-arm-mach=omap4430
> 
> it can  configure  successfull
> but  when  i make  install
> 
> make DESTDIR=/opt/nfs/angstrom_minimal-fs/usr/xenomai  install
>   
> 
> the  result is  error:
> 
> In file included from ../../../src/include/asm/xenomai/atomic.h:26,
>                  from ../../../include/nucleus/system.h:26,
>                  from ../../../src/include/asm/xenomai/system.h:247,
>                  from ../../../include/nucleus/types.h:36,
>                  from ../../../include/nucleus/thread.h:25,
>                  from assert_context.c:24:
> ../../../src/include/asm/xenomai/features.h:73:2: error: #error "Could
> not find current ARM architecture"

I missed that.

Please show us the result of the following command on your system:
arm-none-linux-gnueabi-gcc -dM -x c -E /dev/null | grep ARCH

-- 
					    Gilles.

