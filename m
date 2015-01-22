Date: Thu, 22 Jan 2015 10:56:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150122095635.GB20360@hermes.click-hack.org>
References: <1537147.Wm9AbiuW5D@soho> <2769633.cTWk055Sma@soho>
 <20150122085701.GA20360@hermes.click-hack.org>
 <2271076.0trCLgX2Zk@soho>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2271076.0trCLgX2Zk@soho>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-3 booting problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

On Thu, Jan 22, 2015 at 10:52:31AM +0100, Leopold Palomo-Avellaneda wrote:
> El Dijous, 22 de gener de 2015, a les 09:57:01, Gilles Chanteperdrix va 
> escriure:
> > On Thu, Jan 22, 2015 at 09:34:11AM +0100, Leopold Palomo-Avellaneda wrote:
> > > El Dijous, 22 de gener de 2015, a les 08:54:29, Gilles Chanteperdrix va
> > > 
> > > escriure:
> > > > On Thu, Jan 22, 2015 at 08:47:24AM +0100, Leopold Palomo-Avellaneda 
> wrote:
> > > > > Hi,
> > > > > 
> > > > > 
> > > > > I have compiling a Cobalt kernel. I have followed the web "wikipress"
> > > > > [1];-) recommendations. However, my box (a normal desktop computer -
> > > > > Dell
> > > > > Optiplex 7010 -) doesn't boot. It throws a message like:
> > > > > ....
> > > > > timer doesn't work through interrup-remapped IO-apic
> > > > > 
> > > > > ...
> > > > > 
> > > > > enabling noapic in the boot options I'm able to boot. But, I have not
> > > > > make
> > > > > any test by now. Some interesting messages:
> > > > > 
> > > > > $ dmesg | grep -i xenomai
> > > > > [    0.000000] Linux version 3.16.0-xenomai-3.0.0 (root@soho) (gcc
> > > > > version
> > > > > 4.9.1 (Debian 4.9.1-19) ) #1 SMP Wed Jan 21 16:29:36 UTC 2015
> > > > > [    0.000000] Command line:
> > > > > BOOT_IMAGE=/boot/vmlinuz-3.16.0-xenomai-3.0.0
> > > > > root=UUID=15cfac82-1127-421f-9aed-eaf48247ed4e ro quiet noapic
> > > > > [    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-3.16.0-
> > > > > xenomai-3.0.0 root=UUID=15cfac82-1127-421f-9aed-eaf48247ed4e ro quiet
> > > > > noapic [    0.705071] [Xenomai] scheduling class idle registered.
> > > > > [    0.705072] [Xenomai] scheduling class rt registered.
> > > > > [    0.705090] [Xenomai] disabling automatic C1E state promotion on
> > > > > Intel
> > > > > processor
> > > > > [    0.705104] [Xenomai] SMI-enabled chipset found, but SMI workaround
> > > > > disabled
> > > > > 
> > > > >           (see xenomai.smi parameter). You might encounter
> > > > > 
> > > > > [    0.705284] I-pipe: head domain Xenomai registered.
> > > > > [    0.717986] [Xenomai] Cobalt v3.0-rc2 (Exact Zero) [DEBUG]
> > > > > [    0.897726] usb usb1: Manufacturer: Linux 3.16.0-xenomai-3.0.0
> > > > > xhci_hcd
> > > > > [    0.898617] usb usb2: Manufacturer: Linux 3.16.0-xenomai-3.0.0
> > > > > xhci_hcd
> > > > > [    0.914114] usb usb3: Manufacturer: Linux 3.16.0-xenomai-3.0.0
> > > > > ehci_hcd
> > > > > [    0.930109] usb usb4: Manufacturer: Linux 3.16.0-xenomai-3.0.0
> > > > > ehci_hcd
> > > > > *** RTnet for Xenomai v3.0-rc2 ***
> > > > > 
> > > > > 
> > > > > So, can avoid to pass the noapic parameter to the kernel to boot?
> > > > 
> > > > Please post the full boot logs, and the kernel configuration.
> > > 
> > > Attached.
> > > 
> > > > Does the
> > > > kernel work with exactly the same .config but without Xenomai?
> > > 
> > > I don't know. It's a similar kernel configuration than debian ships with
> > > jessie.
> > 
> > Ok. If you have compiled Xenomai 2.6 git with Linux 3.16.0, why do
> > you not use the same configuration ?
> 
> I used the same file. I attached the 2.6.4 config. However, there's some small 
> differences. For instance, IPIPE_LEGACY is disabled in xenomai-3, not in 2.
>  
> > What about the ARCH problem with make-kpkg, is it solved ?
> 
> As I said yesterday [1], there's a question of the ARCH var, used in the 
> prepare-kernel script.

No, yesterday you said that the prepare-kernel script probably was
not the problem because you can compile the prepared kernel
manually. Or did I misunderstand?

> 
> Any idea to solve this?

As I already said, you have to execute what make-kpkg does, by hand,
step by step, to understand which step goes wrong.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150122/487368b1/attachment.sig>
