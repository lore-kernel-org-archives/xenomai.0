Date: Thu, 26 Mar 2015 17:40:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150326164026.GX15125@hermes.click-hack.org>
References: <CAJT0owE7vtJDWM289=4cNR_LuUqPWAO60nvg9D0NiTQWeN9Xbg@mail.gmail.com>
 <20150326143151.GM15125@hermes.click-hack.org>
 <CAJT0owEumqaqe+Kd2cRN+cqxx1ZzA905MYE_wbeGv2t61OkNkQ@mail.gmail.com>
 <20150326145437.GR15125@hermes.click-hack.org>
 <CAJT0owFNyAPqyu4hRAU1SFdXZQjQkukvWi5sgwHoMijGxO17kQ@mail.gmail.com>
 <20150326154402.GU15125@hermes.click-hack.org>
 <CAJT0owF97KT-VMmK7ofB45mU_esXAJH7J3ge0RBYwHJHoAMFuw@mail.gmail.com>
 <20150326160002.GV15125@hermes.click-hack.org>
 <CAJT0owG6X2P7XUfu7d88VCam4Wd+TzXbJow4driZKR1GWyLfTw@mail.gmail.com>
 <20150326163548.GW15125@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150326163548.GW15125@hermes.click-hack.org>
Subject: Re: [Xenomai] Xenomai 3.0-rc3 Interruption on Arietta G25
 (AT91SAM9G25 chip)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tianchi Huang <gz.eddie.htc@gmail.com>
Cc: xenomai@xenomai.org

On Thu, Mar 26, 2015 at 05:35:48PM +0100, Gilles Chanteperdrix wrote:
> On Thu, Mar 26, 2015 at 05:26:57PM +0100, Tianchi Huang wrote:
> > eddie@eddie-VirtualBox:~/Desktop/xenomai-3/linux-3.14.17/arch/arm/mach-at91$
> > objdump -t *.o | grep gpio_irq_handler -H
> > (standard input):0000c17c l     F .text 000000d4 gpio_irq_handler
> > (standard input):0018db84 l     F .text 000000d0 gpio_irq_handler
> > eddie@eddie-VirtualBox:~/Desktop/xenomai-3/linux-3.14.17/arch/arm/mach-at91$
> > objdump -t *.o > log
> 
> Look for the symbol gpio_irq_handler in the vmlinux file, then run
> addr2line to see where the symbol comes from.

Actually you already have the address of the problematic
gpio_irq_handler in the backtrace you sent. If you did not change
any kernel option, it is still valid, so you just need to run
addr2line against the vmlinux binary to find where the function is
defined. 

-- 
					    Gilles.

