Message-ID: <46029E6F.1080303@domain.hid>
Date: Thu, 22 Mar 2007 16:19:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <032220071428.1288.4602928900017779000005082216557996070E0301020A98@domain.hid>
In-Reply-To: <032220071428.1288.4602928900017779000005082216557996070E0301020A98@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Xenomai-help] New install of Xenomai 2.3 for
 2.6.17 kernel.... Various problems
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@domain.hid
Cc: xenomai@xenomai.org

xenomai@domain.hid wrote:
> Thanks for the quick response.

You are welcome, but please do not drop the mailing list from the CC.

> I ended up completely rebuilding
> the system so as to better understand what is on the system.
> (This is my laptop).  I installed OpenSUSE 10.2, downloaded
> the latest stable kernel (2.6.20.3), and downloaded Xenomai 2.31.
> Installation was a little smoother this time.  I did have to select
> Core 2 for processor type in order to see the options under Real Time
> in the kernel config as 686 wouldnt show them.

So, if I use your config and select CONFIG_M686, I should not see the
real-time menu in kernel config ? Well, I select CONFIG_M686
(Pentium-Pro) and am still able to select everything in the Real-time
submenu.
If I select CONFIG_M586 I see a message:
"Note: Xenomai conflicts with PC speaker support.
(menu Device Drivers/Input device support/Miscellaneous devices)"

So, I go in the Device Drivers/Input device support/Miscellaneous
devices menu, unselect "PC speaker support", and am still able to see
the Real-time subsystem menu again.

> TSC and IPIPE were
> selected automatically.  I built the kernel both with HPET

HPET is suspected not to work with Xenomai. But if you do not have a
real HPET, this option should be harmless. Check the boot logs to know
if the HPET is used.

> and SMI work around both enabled and disabled with no change in
> performance.  Xenomai was built with x86-sep, x86-tsc, and smp.
> I did have to edit a couple files in the linux distro after the
> patch to add an include reference to ipipe.h as others have had
> to do.

Could you tell us precisely what reference is missing in what file ?


>  All built and installed fine.  When running I still see the wierd
> latencies and for some reason I can not do anything with the network
> card.  It is detected, and did get a DHCP address and can be pinged
> from a remote system.  No getting in or out though.

I can not tell what network card you have, since you enabled all of them
in your kernel configuration. Another usual suspect in such a case is
CONFIG_PCI_MSI. Try disabling it and please tell us the outcome.

-- 
                                                 Gilles Chanteperdrix

