Message-ID: <525E7D85.9020307@xenomai.org>
Date: Wed, 16 Oct 2013 13:50:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <525DC044.6090201@steinkuehler.net> <525E73FB.4060809@xenomai.org>
	<525E7ABF.8040403@steinkuehler.net>
In-Reply-To: <525E7ABF.8040403@steinkuehler.net>
Content-Type: text/plain; charset=UTF-8
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

On 10/16/2013 01:38 PM, Charles Steinkuehler wrote:
> On 10/16/2013 6:09 AM, Gilles Chanteperdrix wrote:
>> Could you do the simple "sleep 10" test to verify that Linux 
>> timer is running correctly?
> 
> Yes, sleep 10 works fine.  Other than the SD card problem (which is
> very rare), the system is perfectly normal.
> 
>> Could you attach: - the full boot logs - the kernel
>> configuration - the result of cat /proc/interrupts, cat
>> /proc/xenomai/irq, cat /proc/timer_list, cat /proc/xenomai/timer
> 
> Attached.  I didn't know if you wanted the serial boot log or 
> dmesg, so you get both.
> 
> Thanks!
> 

Ok, so the MMC irq is a gpio irq. And its counter is 0, which does not
seem to be normal if the root filesystem in on MMC. Is it 0 too when
you boot an unpatched kernel?

Do you run a vanilla kernel or a vendor kernel with additional patches
to drivers/gpio/gpio-omap.c, or maybe a beaglebone specific GPIO
driver in drivers/gpio ?

-- 
                                                                Gilles.

