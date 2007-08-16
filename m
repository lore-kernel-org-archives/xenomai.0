Message-ID: <35505.194.114.62.68.1187280844.squirrel@domain.hid>
In-Reply-To: <2ff1a98a0708160837l697d34c8xa2ad0e87b4f996f8@domain.hid>
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
	<2ff1a98a0708160837l697d34c8xa2ad0e87b4f996f8@domain.hid>
Date: Thu, 16 Aug 2007 18:14:04 +0200 (CEST)
From: "Nadym Salem" <Kaiman@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, August 16, 2007 17:37, Gilles Chanteperdrix wrote:

>> >> >> > Aha, this probably means that your chipset is not supporte,
>> could
>> >> you
>> >> >> > run lspci and send us the output ?
>> >> >> it is attached.
>> >> > Could you try to apply the attached patch to xenomai sources ? Yo=
u
>> >> > will then have to recompile your xenomai-patched kernel.
>> >> Done, and it changes something, it got even worse.
>> >> Before there was a latency of something around 6 ms...not it's 10.
>> > Do you get the message in the kernel logs saying that SMI workaround
>> > is enabled ?
>> > Could you send us your kernel .config ?
>> it found the SMI enabled chipset, but SMI workaround failed.
>> Kernel config attached.
> I am afraid you are out of luck. The only place where the SMI
> workaround could be authorized is in the BIOS settings.
> There is one last thing you can try, in your kernel configuration
> ENABLE ACPI, except the ACPI processor module, and be sure to load the
> usb hci modules. Because when enabling these, the legacy stuff
> emulation gets disabled.

I'm afraid I'm completely out of luck.
With ACPI the system doesn't boot up at all, it just hangs completely,
even the power switch is out of use (!)

Ok, I'll kill our IT and try to live with it for the moment. Since I have
to get finished I will keep it like that and then there has to be a
different machine later.

The only thing I'm wondering about, as a RTnet Master it's more than fast
enough for cycle times of 2 ms and less, as a slave it only does 400ms.

Thanks a lot for your support,

greets, Nadym


