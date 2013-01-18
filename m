Message-ID: <50F9A9A3.8040003@xenomai.org>
Date: Fri, 18 Jan 2013 20:59:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CALJOq=VtrBhMzCaT=7omDVN9hnnwZ+cmM1_1eff9DTS-fvLjaw@mail.gmail.com>
In-Reply-To: <CALJOq=VtrBhMzCaT=7omDVN9hnnwZ+cmM1_1eff9DTS-fvLjaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] GPIO Interrupts problem with RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pierre LE COZ <peter.le.coz@gmail.com>
Cc: xenomai@xenomai.org

On 01/18/2013 04:15 PM, Pierre LE COZ wrote:

> Hi all,
> 
> I have simple program to manage the GPIO of my raspberry Pi using RTDM.
> 
> I use :
> "rtdm_irq_request(& irq_exemple, num_irq, exemple_handler,
> RTDM_IRQTYPE_SHARED | RTDM_IRQTYPE_EDGE, "MyProgram", NULL);"
> in order to detect interrupts.
> 
> After repeated presses on a pushbutton linking my input GPIO to 3,3v, I run
> :
> # cat /proc/xenomai/irq
> IRQ CPU0
> 3: 1134 [timer]
> 108: 0 MyProgram
> 259: 0 [virtual]
> 
> No interrupt is taken into account.
> 
> Please, does anyone can help?


The Raspberry PI code is not part of the I-pipe kernel maintained by 
the Xenomai project, so, basically, what it does is not really under 
the control of this list. However, I would bet you are missing the GPIO 
demuxing:

http://xenomai.org/index.php/I-pipe-core:ArmPorting#GPIOs_as_interrupt_sources

-- 
                                                                Gilles.

