Date: Thu, 26 Mar 2015 17:57:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150326165710.GY15125@hermes.click-hack.org>
References: <20150326143151.GM15125@hermes.click-hack.org>
 <CAJT0owEumqaqe+Kd2cRN+cqxx1ZzA905MYE_wbeGv2t61OkNkQ@mail.gmail.com>
 <20150326145437.GR15125@hermes.click-hack.org>
 <CAJT0owFNyAPqyu4hRAU1SFdXZQjQkukvWi5sgwHoMijGxO17kQ@mail.gmail.com>
 <20150326154402.GU15125@hermes.click-hack.org>
 <CAJT0owF97KT-VMmK7ofB45mU_esXAJH7J3ge0RBYwHJHoAMFuw@mail.gmail.com>
 <20150326160002.GV15125@hermes.click-hack.org>
 <CAJT0owG6X2P7XUfu7d88VCam4Wd+TzXbJow4driZKR1GWyLfTw@mail.gmail.com>
 <20150326163548.GW15125@hermes.click-hack.org>
 <CAJT0owG00wy+ePmaS-45ioziRDbTtRQ0vtc=upUGpAKiz+UBQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJT0owG00wy+ePmaS-45ioziRDbTtRQ0vtc=upUGpAKiz+UBQA@mail.gmail.com>
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

On Thu, Mar 26, 2015 at 05:56:05PM +0100, Tianchi Huang wrote:
> eddie@eddie-VirtualBox:~/Desktop/xenomai-3/linux-3.14.17$
> arm-linux-gnueabi-objdump -t vmlinux | grep gpio_irq_handler
> c0014d7c l     F .text 000000d4 gpio_irq_handler
> c0196784 l     F .text 000000d0 gpio_irq_handler
> eddie@eddie-VirtualBox:~/Desktop/xenomai-3/linux-3.14.17$
> arm-linux-gnueabi-addr2line 0xc0194784 -e vmlinux -f
> $d
> pinctrl-utils.c:?
> eddie@eddie-VirtualBox:~/Desktop/xenomai-3/linux-3.14.17$
> arm-linux-gnueabi-addr2line 0xc0014d7c -e vmlinux -f
> gpio_irq_handler
> gpio.c:?
> 
> *I found nothing in pinctrl-utils.c*

Please enable compilation with debug symbols.

-- 
					    Gilles.

