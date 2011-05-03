Message-ID: <4DC03D39.2040305@domain.hid>
Date: Tue, 03 May 2011 19:36:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTikzGAMXZ--TaxmxXZDsoYJSesC26g@domain.hid>
In-Reply-To: <BANLkTikzGAMXZ--TaxmxXZDsoYJSesC26g@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] reading/writing registers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Aurele Traynard <aurele.traynard@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 05/03/2011 02:07 PM, Aurele Traynard wrote:
> hello,
> 
> I am writing a little test. I put all my RT things in a module : one ISR and
> one RT task.
> in init_module I call :
> 
> drv->data.regs = ioremap(0x04000000, 64*1024*1024);
> drv->data.gpio = ioremap(0x40E00000, 64*1024*1024);
> this is to acces registers
> 
> rthal_irq_request(8, my_rt_isr, NULL, &(drv->data));
> rthal_irq_enable(8);
> for the ISR
> 
> in my interrupt routine I use : writel(1, data->gpio + 0x48); for hardware
> interrupt acknowledge
> 
> but when my interrupt routine is called linux is freezing so i think that I
> am never going out of the ISR (I am 99.9% sure).
> I am not sure but I think that It is due to the hardware interrupt
> aknoledge...
> 
> my question is :
> can I call "writel(1, data->gpio + 0x48);" in my ISR?
> is it good or not?
> is there an other way to access registers?
> 
> thanks for your answers.
> 
> PS firstly I was calling : "GEDR0 = 0x1;" but in RT task this macro doesn't
> work

Why is that? What are the symptoms?

Other than that, have a look at:
http://www.xenomai.org/index.php/Request_for_information

-- 
                                                                Gilles.

