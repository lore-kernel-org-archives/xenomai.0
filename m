Message-ID: <525E8A43.5090601@xenomai.org>
Date: Wed, 16 Oct 2013 14:44:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <525DC044.6090201@steinkuehler.net>
	<525E73FB.4060809@xenomai.org>	<525E7ABF.8040403@steinkuehler.net>
	<525E7D85.9020307@xenomai.org> <525E81CD.6000603@steinkuehler.net>
	<525E8665.8000705@steinkuehler.net>
In-Reply-To: <525E8665.8000705@steinkuehler.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Hung task on Xenomai patched ARM 3.8.13 BeagleBone
 Kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: xenomai@xenomai.org

On 10/16/2013 02:28 PM, Charles Steinkuehler wrote:
> On 10/16/2013 7:08 AM, Charles Steinkuehler wrote:
>> On 10/16/2013 6:50 AM, Gilles Chanteperdrix wrote:
>>> Ok, so the MMC irq is a gpio irq. And its counter is 0, which does not
>>> seem to be normal if the root filesystem in on MMC. Is it 0 too when
>>> you boot an unpatched kernel?
>>>
>>> Do you run a vanilla kernel or a vendor kernel with additional patches
>>> to drivers/gpio/gpio-omap.c, or maybe a beaglebone specific GPIO
>>> driver in drivers/gpio ?
>>
>> It's a BeagleBone specific kernel with a list of patches as long as my
>> arm...and I have pretty long arms!
>>
>> https://github.com/cdsteinkuehler/linux-dev/blob/3.8.13-bone28-xenomai/patch.sh
>>
>> I'm not sure about the GPIO interrupt.  I'll see what happens with the
>> non-xenomai kernel, and review the board setup.
>
> Both the BeagleBone and the Xenomai kernels behave the same way.  The
> GPIO mmc interrupt is stuck at zero, and the 80: INTC mmc interrupt
> count increases on access to the filesystem.
>
Maybe the GPIO interrupt is for the "Card detect signal", do you see it 
increasing if you remove and re-insert the SD card?

-- 
					    Gilles.

