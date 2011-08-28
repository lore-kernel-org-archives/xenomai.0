Message-ID: <4E5A294C.1060205@domain.hid>
Date: Sun, 28 Aug 2011 13:41:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKvQZ_06JKNPsiGeXOC1PEnc1Je5zSDSnX9AdOHT4eraggv7Eg@domain.hid>
In-Reply-To: <CAKvQZ_06JKNPsiGeXOC1PEnc1Je5zSDSnX9AdOHT4eraggv7Eg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] CPU frequency of 0 in a Vmware with Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Willy Lambert <lambert.willy@domain.hid>
Cc: xenomai@xenomai.org

On 08/28/2011 12:28 PM, Willy Lambert wrote:
> Hi all,
> 
> I am trying to make xenomai running into a Debian Squeeze 32b with a custom
> 2.6.38.8 kernel with xenomai among other things. I am running this into a
> Vmware for testing this before going on my real target.
> 
> I have a "CPU frequency of 0" Error at boot, which I think is "classic" with
> Vmwares :
> http://comments.gmane.org/gmane.linux.real-time.xenomai.devel/6632
> 
> ard@domain.hid:~$ dmesg | grep Xenomai
> [    0.559923] Xenomai has detected a CPU frequency of 0. Aborting.
> [    0.560923] Xenomai: system init failed, code -19.
> [    0.560923] Xenomai: native skin init failed, code -19.
> [    0.560923] Xenomai: starting POSIX services.
> [    0.561923] Xenomai: POSIX skin init failed, code -19.
> [    0.561923] Xenomai: RTDM skin init failed, code -19.
> 
> But search didn't help me for this. See inclosed my .config (sorry it's a
> default-full option with initrd because I am failing on the "allnoconfig"
> little kernel for now). See below some extra informations about my system

Well, there is not much we can do except telling you to use another
emulator than vmware. Such as qemu-kvm.

You can try passing hardcoded frequencies to xenomai too, for instance,
passing on the kernel command line:

xeno_hal.clockfreq=1600000000 xeno_hal.cpufreq=1600000000

But I doubt it will work unless you pass the exact frequency vmware is
simulating.

> 
> -----------------------------------------------------------------------------------------------
> I read this :
> http://www.xenomai.org/index.php/Configuring_x86_kernels
> Here is some results. I didn't found the "Usb legacy Emulation", but as I
> don't have the proof it is disable, please let me know if you have a precise
> CONFIG name option.

All these options have nothing to do with the fact that cpu frequency is
null with vmware.

"Usb legacy emulation", is done by the bios, not the kernel.

> Power management disabled :
> ard@domain.hid$ cat .config | grep APM
> # CONFIG_APM is not set
> ard@domain.hid$ cat .config | grep ACP
> # Power management and ACPI options
> # CONFIG_ACPI is not set
> # CONFIG_PNPACPI is not set

You want CONFIG_ACPI enabled, only CONFIG_ACPI_PROCESSOR should be disabled.


-- 
                                                                Gilles.

