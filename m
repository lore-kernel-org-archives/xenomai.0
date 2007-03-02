Message-ID: <bc4264770703020154n673663daxbe930c0f6cfdec0a@domain.hid>
Date: Fri, 2 Mar 2007 09:54:29 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] problems installing peak CAN dongle
In-Reply-To: <45E7F01D.2080304@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770703020023o4e15cdafh6e254fff4b225e8a@domain.hid>
	<45E7E49C.2000005@domain.hid>
	<bc4264770703020123s28450a37n60bb1e49798f32b8@domain.hid>
	<45E7F01D.2080304@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

Hi,

> OK ==> the device cannot be accessed. Either the I/O address "0x378" and
> partport type "epp" is incorrect (you did not answer my question on
> that) or the parallel port is not operational (power off, etc.).
> Please check what is actually selected in the BIOS of your system.

I will check the BIOS.


>
> >> How do you have configured the parport in the kernel? Are there modules
> >> loaded (check /proc/modules)? Retry after removing lp and parport_pc:
> >
> > Have looked can't see any. Have attached the output of /proc/modules
> >
> >
> >>
> >>    $ rmmod lp
> >>    $ rmmod parport_pc
> >
> > I get a message that it cannot find these modules in /proc/modules
>
> Try "modporbe parport". If the module does not exists, configure and
> rebuild your kernel with parport support.

Modprobe parport  tells me the module does not exist. Are you sure its
called parport?

Will reconfigure the kernel.

Regards,

Roland.



>
> In the meantime I'm going to apply the fix Jan mentioned.
>
> Wolfgang.
>
>

