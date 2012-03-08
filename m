Message-ID: <4F58788F.5070103@domain.hid>
Date: Thu, 08 Mar 2012 10:14:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <001501ccfcd9$67d9ede0$378dc9a0$@q@domain.hid>
In-Reply-To: <001501ccfcd9$67d9ede0$378dc9a0$@q@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai stop working
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ?? <ma.q@domain.hid>
Cc: xenomai@xenomai.org

On 03/08/2012 04:13 AM, ?? wrote:
> Hi
> 
>   I have installed xenomai-2.5.6 on imx53 quick start board with Linux
> 2.6.35, it works well but stop working when I do some kernel real time task.
> 
>   When it stop working, system is not totally down, it will be recovered
> after about 8~9 minutes, which comes

This usually means that the hardware timer is programmed for a too short
delay and wraps instead of ticking right away. You need to increase, in
__ipipe_mach_set_dec for the cpu you use, the minimum delay for which an
irq is triggered.

-- 
                                                                Gilles.

