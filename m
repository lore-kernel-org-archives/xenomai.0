Message-ID: <4E0217CC.7000307@domain.hid>
Date: Wed, 22 Jun 2011 18:26:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTimKq+oq5oG3d9H+TWs1S0HVCXaPLQ@mail.gmail.com>	<4E01E4D1.2090601@domain.hid>
	<BANLkTim268o3835dTxxbCccf-vM1Z9=NYg@domain.hid>
In-Reply-To: <BANLkTim268o3835dTxxbCccf-vM1Z9=NYg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] booting on pandaboard
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

On 06/22/2011 05:58 PM, suresh reddy wrote:
> On 22 June 2011 14:49, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> On 06/22/2011 02:33 PM, suresh reddy wrote:
>>> console=ttyS2,115200n8
>>
>> console is ttyO2, not ttyS2.
>>
> 
> 
> Dear Giles ,
> that is not problem because of ttys2 or O2 settings . I followed
> http://omappedia.org/wiki/Minimal-FS_Booting
> 
> that and  the below bootargs
> 
> fatload mmc 0:1 0x80000000 uImage
> setenv bootargs ro elevator=noop vram=32M
> mem=460M@0x80000000mem=256M@0xA0000000root=/dev/mmcblk0p2
> console=ttyO2,115200n8 fixrtc earlyprintk  bootm
> 0x80000000
> 
> 
> still i did not saw anything on my terminal . then only i sent a mail to
> xenomai help mailing list .

Then there is probably something wrong in your configuration. Please try
the configuration I pointed you to.

http://sisyphus.hd.free.fr/~gilles/omap4_panda_config

-- 
					    Gilles.

