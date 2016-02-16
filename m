Date: Tue, 16 Feb 2016 10:25:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160216092500.GA17780@hermes.click-hack.org>
References: <20160216074217.895C2C80639@webmail.sinamail.sina.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160216074217.895C2C80639@webmail.sinamail.sina.com.cn>
Subject: Re: [Xenomai] How can I use Xenomai with Firefly RK3288?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?B?546L5a6H6amw?= <wangyuchi1017@sina.com>
Cc: xenomai <xenomai@xenomai.org>

On Tue, Feb 16, 2016 at 03:42:17PM +0800, 王宇驰 wrote:
> Hi, everyone! I need a real-time platform now, and I have a board:
> Firefly RK3288.Board: Firefly RK3288;Soc: RK3288 (rockchip);Core:
> A17;Architecture: armv7. I can get the kernel source here:
> https://github.com/mmind/linux-rockchip.v3.14, v3.16 v4.1 are all
> good to be patched with
> ipipe-core-3.14-arm-1.patch,ipipe-core-3.16-arm-4.patch,
> ipipe-core-4.1-arm-1.patch respectively.But when I run make
> bzImage after make firefly-rk3288_defconfig and make menuconfig,it
> shows that "implicit declaration of function
> '__ipipe_mach_update_tsc()' in smp.c"Can anyone tell me what I
> should do next, do I need to port Xenomai to RK3288 or just find a
> new board?An advice please, I am new to practical embedded
> programming. Thank you very much!

Hi,

The list of supported embedded processors may be found here:
https://xenomai.org/embedded-hardware/

If you want to port Xenomai to a new ARM board, you should follow
this guide:
https://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/

Though it may be a bit hard if you have no experience in kernel
programming.

Regards.

-- 
					    Gilles.
https://click-hack.org

