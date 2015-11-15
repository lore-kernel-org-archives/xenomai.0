Date: Sun, 15 Nov 2015 20:04:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151115190454.GY1820@hermes.click-hack.org>
References: <BLU437-SMTP72A29E46372946E95D6CFAF01F0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLU437-SMTP72A29E46372946E95D6CFAF01F0@phx.gbl>
Subject: Re: [Xenomai] [PATCH] IPIPE patch for BCM2709/RPI2 (version #3)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Cc: xenomai@xenomai.org

On Sun, Nov 15, 2015 at 08:53:14AM -0800, Mathieu Rondonneau wrote:
> From 2aa9fa2759a6bfafdac5b3355d2e827cee7c200f Mon Sep 17 00:00:00 2001
> From: Mathieu Rondonneau <mathieu.rondonneau@gmail.com>
> Date: Fri, 13 Nov 2015 20:59:49 -0800
> Subject: [PATCH] IPIPE patch for BCM2709.
> 
>  - kernel: https://github.com/raspberrypi/linux (rpi-3.18.y)
>    - 1bb18c8f721ef674a447f3622273f2e2de7a205c
>  - xenomai: git://git.xenomai.org/xenomai-3.git (stable-3.0.x)
>    - cb72996a06ae4f29e403e3397324069f1983145e
> ---
>  arch/arm/mach-bcm2709/armctrl.c                  |  4 ++++
>  arch/arm/mach-bcm2709/bcm2708_gpio.c             |  6 ++++--
>  arch/arm/mach-bcm2709/bcm2709.c                  |  9 +++++++++
>  arch/arm/mach-bcm2709/include/mach/entry-macro.S | 12 ++++++++++--
>  4 files changed, 27 insertions(+), 4 deletions(-)

The patch looks good to me.

-- 
					    Gilles.
https://click-hack.org

