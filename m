Date: Sat, 14 Nov 2015 06:38:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151114053841.GF1820@hermes.click-hack.org>
References: <BLU436-SMTP777DC6298F62C65606DFEF0100@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLU436-SMTP777DC6298F62C65606DFEF0100@phx.gbl>
Subject: Re: [Xenomai] [PATCH] IPIPE patch for BCM2709/RPI2.
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

On Fri, Nov 13, 2015 at 09:31:23PM -0800, Mathieu Rondonneau wrote:
> From 6f985ebdd2c99257fb3873b9cb83ba6572dff60a Mon Sep 17 00:00:00 2001
> From: Mathieu Rondonneau <mathieu.rondonneau@gmail.com>
> Date: Fri, 13 Nov 2015 20:59:49 -0800
> Subject: [PATCH] IPIPE patch for BCM2709.
> 
>  - kernel: https://github.com/raspberrypi/linux (rpi-3.18.y)
>    - 1bb18c8f721ef674a447f3622273f2e2de7a205c

As explained here:
http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/#Working_with_vendor_forks

If the patch is not for mainline Linux it should be sent as a couple
of pre and post patches.

-- 
					    Gilles.
https://click-hack.org

