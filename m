Message-ID: <4247DCE9.8070407@domain.hid>
Date: Mon, 28 Mar 2005 12:31:05 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Adeos-2.6.11 glitch [more info]
References: <Pine.LNX.4.53.0503281139180.20969@domain.hid> <Pine.LNX.4.53.0503281237020.21474@domain.hid>
In-Reply-To: <Pine.LNX.4.53.0503281237020.21474@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: "Rus V. Brushkoff" <rus@domain.hid>
Cc: adeos-main@gna.org

Hi Rus,

Rus V. Brushkoff wrote:
> On Mon, 28 Mar 2005, Rus V. Brushkoff wrote:
> 
> : After booting the system do not receive any ICH interrupt (no working
> :mouse/usb/sound/eth0 ) :
> 
> [...]
> 
> : System is Intel D865PERL P4 based system. If I pass "pci=routeirq" kernel
> :parameter - ICH begin to work again.
>

Are we talking about the r9 available from the download area?

>  With the "pci=routeirq" parameter - the kernel locks up solid in
> rc.hotplug scripts. If adeos is compiled as module - all is working
> fine until the adeos module inserted - the kernel locks up while moving
> the mouse. Tested with preeemt=on/off and msi=on/off - result the same,
> except that the kernel compiled with preempt=on issuing an "stack
> overflow in do_IRQ()" message while rc.hotplug script is running - kernel,
> compiled without preempt, only freezes.
>

Looks like an IRQ acknowledge issue. Like for the previous MSI bug, it's 
all a matter of being able to put my hands on a box that exhibits the 
problem.

   Can supply any additional info if requested.
> 

Does the box still freeze with CONFIG_ADEOS_MODULE-CONFIG_HOTPLUG, 
before or after the Adeos module is pushed?

> :
> 
> 		Rus
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 

Philippe.

