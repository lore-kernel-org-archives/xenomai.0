Message-ID: <2ff1a98a0708160837l697d34c8xa2ad0e87b4f996f8@domain.hid>
Date: Thu, 16 Aug 2007 17:37:30 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <14127.194.114.62.68.1187278264.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <61839.194.114.62.68.1187258167.squirrel@domain.hid>
	<56493.194.114.62.68.1187265227.squirrel@domain.hid>
	<2ff1a98a0708160639k555fbb48p98a13892e30e5b02@domain.hid>
	<21067.194.114.62.68.1187272557.squirrel@domain.hid>
	<2ff1a98a0708160701w17dcf324jb9cb31843d69ca60@domain.hid>
	<4760.194.114.62.68.1187274071.squirrel@domain.hid>
	<2ff1a98a0708160731k5eefd6b2i417b05b6d329e481@domain.hid>
	<51845.194.114.62.68.1187277636.squirrel@domain.hid>
	<2ff1a98a0708160827v6475e569v5a3982eceb93a1ab@domain.hid>
	<14127.194.114.62.68.1187278264.squirrel@domain.hid>
Subject: Re: [Xenomai-help] latency problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nadym Salem <Kaiman@domain.hid>
Cc: xenomai@xenomai.org

On 8/16/07, Nadym Salem <Kaiman@domain.hid> wrote:
> On Thu, August 16, 2007 17:27, Gilles Chanteperdrix wrote:
>
> >> >> > Aha, this probably means that your chipset is not supporte, could
> >> you
> >> >> > run lspci and send us the output ?
> >> >> it is attached.
> >> > Could you try to apply the attached patch to xenomai sources ? You
> >> > will then have to recompile your xenomai-patched kernel.
> >> Done, and it changes something, it got even worse.
> >> Before there was a latency of something around 6 ms...not it's 10.
> > Do you get the message in the kernel logs saying that SMI workaround
> > is enabled ?
> > Could you send us your kernel .config ?
>
> it found the SMI enabled chipset, but SMI workaround failed.
> Kernel config attached.

I am afraid you are out of luck. The only place where the SMI
workaround could be authorized is in the BIOS settings.

There is one last thing you can try, in your kernel configuration
ENABLE ACPI, except the ACPI processor module, and be sure to load the
usb hci modules. Because when enabling these, the legacy stuff
emulation gets disabled.

-- 
                                               Gilles Chanteperdrix

