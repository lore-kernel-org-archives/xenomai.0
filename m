Date: Mon, 28 Mar 2005 12:44:04 +0300 (EEST)
From: "Rus V. Brushkoff" <rus@domain.hid>
In-Reply-To: <Pine.LNX.4.53.0503281139180.20969@domain.hid>
Message-ID: <Pine.LNX.4.53.0503281237020.21474@domain.hid>
References: <Pine.LNX.4.53.0503281139180.20969@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Adeos-main] Adeos-2.6.11 glitch [more info]
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
To: adeos-main@gna.org

On Mon, 28 Mar 2005, Rus V. Brushkoff wrote:

: After booting the system do not receive any ICH interrupt (no working
:mouse/usb/sound/eth0 ) :

[...]

: System is Intel D865PERL P4 based system. If I pass "pci=routeirq" kernel
:parameter - ICH begin to work again.

 With the "pci=routeirq" parameter - the kernel locks up solid in
rc.hotplug scripts. If adeos is compiled as module - all is working
fine until the adeos module inserted - the kernel locks up while moving
the mouse. Tested with preeemt=on/off and msi=on/off - result the same,
except that the kernel compiled with preempt=on issuing an "stack
overflow in do_IRQ()" message while rc.hotplug script is running - kernel,
compiled without preempt, only freezes.
 Can supply any additional info if requested.

:

		Rus

