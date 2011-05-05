Message-ID: <4DC2A315.8030707@domain.hid>
Date: Thu, 05 May 2011 19:16:05 +0600
From: Alexey Galakhov <agalakhov@domain.hid>
MIME-Version: 1.0
References: <4DC2962B.9060802@domain.hid> <4DC299F2.40700@domain.hid>
In-Reply-To: <4DC299F2.40700@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] mini2440: ipipe kernel stuck in idle loop after
 xenomai init
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

On 05/05/2011 06:37 PM, Gilles Chanteperdrix wrote:
> You should make sure that pm_idle == default_idle. In this case,
> __ipipe_halt_root is called instead of arch_idle, and everything should
> work.
May it be caused by the following code from plat-samsung/time.c ?

static inline void set_dec(unsigned long reload)
{
        __raw_writel(reload, S3C2410_TCNTB(4)); /* <-------- In fact,
TCNT is 16-bit, so what if reload > 0xffff and reload & 0xffff == 0 ??? */

--
Alex

