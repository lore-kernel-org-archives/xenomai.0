Date: Mon, 28 Mar 2005 13:38:31 +0300 (EEST)
From: "Rus V. Brushkoff" <rus@domain.hid>
Subject: Re: [Adeos-main] Adeos-2.6.11 glitch [more info]
In-Reply-To: <4247DCE9.8070407@domain.hid>
Message-ID: <Pine.LNX.4.53.0503281333010.21926@domain.hid>
References: <Pine.LNX.4.53.0503281139180.20969@domain.hid>
 <Pine.LNX.4.53.0503281237020.21474@domain.hid>
 <4247DCE9.8070407@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org

On Mon, 28 Mar 2005, Philippe Gerum wrote:

	Hi.

:Are we talking about the r9 available from the download area?

Yes ;)

:>  With the "pci=routeirq" parameter - the kernel locks up solid in
:> rc.hotplug scripts. If adeos is compiled as module - all is working
:> fine until the adeos module inserted - the kernel locks up while moving
:> the mouse. Tested with preeemt=on/off and msi=on/off - result the same,
:> except that the kernel compiled with preempt=on issuing an "stack
:> overflow in do_IRQ()" message while rc.hotplug script is running - kernel,
:> compiled without preempt, only freezes.
:>
:
:Looks like an IRQ acknowledge issue. Like for the previous MSI bug, it's
:all a matter of being able to put my hands on a box that exhibits the
:problem.

 Hmm, this is my usual working and testing system - P4 3.0Ghz on the Intel
ICH5/ICH5R chipset - the only thing that I'm doing for Adeos test - is
disabling SMP/Hyperthreading in the kernel.

:
:   Can supply any additional info if requested.
:>
:
:Does the box still freeze with CONFIG_ADEOS_MODULE-CONFIG_HOTPLUG,
:before or after the Adeos module is pushed?

The box begin to freeze only after the module is loaded.

:
:

		Rus

