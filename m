Message-ID: <4E01C55B.8070603@domain.hid>
Date: Wed, 22 Jun 2011 12:35:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTik5jJ826WBUao92ktP8SccKhfoTfA@mail.gmail.com>
In-Reply-To: <BANLkTik5jJ826WBUao92ktP8SccKhfoTfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] reg arm.s
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: suresh reddy <sureshreddy.balijepalli@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 06/22/2011 12:11 PM, suresh reddy wrote:
> Dear Giles,
> 
> If i use the omap2plus-defconfig and remove that smp option then my building
> uimage worked as follows.

I have sent you a mail with a link to the .config I use, use this one,
it has SMP enabled. I would recommend against using omap2plus_defconfig,
because:
- I did not test it
- if it works, you will not get good latencies.

> and  i have a question regarding modules. there are 3 modules in my build
> directory (not in lib )
> 
> modules.symvers , modules.builtin , modules.order
> 
> these are the 3 modules that i have place in my rootfs of sd card (including
> usr and dev directories) and Iam using the mlo and uboot.bin files that were
> already on sd card ,Iam just replacing uImage.

You say you have a question, but I do not see any here.

-- 
                                                                Gilles.

