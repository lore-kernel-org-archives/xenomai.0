From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [xenomai-images][PATCH 1/1][REV 2] Enable RTDM SPI on BeagleBone
 Black
References: <30F08CB9-A6E9-4C78-B40F-D6454048E786@gmail.com>
 <0403b386-7c15-b32d-f009-25c49d105dcc@siemens.com>
 <C4D04183-55E9-482C-8BCB-93930CC36A53@gmail.com>
Message-ID: <2c136fec-777c-5982-4055-87636429350c@siemens.com>
Date: Thu, 12 Nov 2020 17:56:21 +0100
MIME-Version: 1.0
In-Reply-To: <C4D04183-55E9-482C-8BCB-93930CC36A53@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Deniz_U=c4=9fur?= <deniz343@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 12.11.20 09:25, Deniz Uğur wrote:
>> This is not place to put some kind or "versioning" info. It's rather the
>> place to put your commit message, explaining *why* we want this change.
> 
> I wish it was possible to delete the previous mail, otherwise I wouldn’t
> write that.
> 
>> Why do we need to *enable* overlays first...
>>
>>> +echo "disable_uboot_overlay_video=1" >> /boot/uEnv.txt
>>
>> ...in order to disable a specific one?
> 
> I’ve tried every combination but without these, BBB doesn’t seem to be
> booting.
> 

I don't have the code around, but this is possibly *selecting* an
overlay (rather than excluding one) that disables the otherwise enabled
video function.

>> How can non-matching drivers be in conflict? Most of those below do not
>> match on any of the DT entries on the BBB.
> 
> I took the liberty of trying every combination again but just disabling
> CONFIG_SPI_SPIDEV wasn’t enough. In every other case, driver wasn’t
> loading and dumping stack trace to kernel logs.

I would have suspected that CONFIG_SPI_OMAP24XX=n and
CONFIG_SPI_SPIDEV=n is enough. Would likely be worth to look at the back
traces eventually.

Jan
-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


