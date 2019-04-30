From: Florent Legendre <florent.legendre@live.fr>
Subject: RE: Analogy: analogy_config freezes computer
Date: Tue, 30 Apr 2019 14:00:08 +0000
Message-ID: <PR1PR02MB474898400BAE6B59A24A30F8863A0@PR1PR02MB4748.eurprd02.prod.outlook.com>
References: <VI1PR02MB4749FFC72B59123C0A44297E86230@VI1PR02MB4749.eurprd02.prod.outlook.com>,
 <ae7e55e6-224c-3590-471b-f1dbf49a81d5@xenomai.org>
In-Reply-To: <ae7e55e6-224c-3590-471b-f1dbf49a81d5@xenomai.org>
Content-Language: fr-FR
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jorge Ramirez <jro@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

Thanks a lot for your reply and sorry for the delay.

You are right, it's NI PCI-6259. (sorry, typing mistake)

Currently, l don't have time to go deeper in this problem, other priorities=
 came up. But I will very soon be back on this topic.

Thanks again, I wish you a great day !

Best regards,
Florent

________________________________
De : Jorge Ramirez <jro@xenomai.org>
Envoy=E9 : jeudi 25 avril 2019 17:09
=C0 : Florent Legendre; xenomai@xenomai.org
Objet : Re: Analogy: analogy_config freezes computer

On 4/24/19 15:44, Florent Legendre via Xenomai wrote:
> Hello everyone !
>
> I'm new to Xenomai and I encounter some problem. I wondered if someone co=
uld give me some help. :)
>
> I am trying to use Analogy to handle a NI PCI-5269 and I am having troubl=
es to make it works. My computer freezes when I try to use the analogy_conf=
ig command.


what is the device id for this board? can you check lspci ?

I dont see it as being one of the supported boards (are you sure it is
not PCI-6259)?

if it is not in that list [1] It might require a little bit of work to
add support...

can you share a kernel log?

I maintained this subsystem for a little bit but Analogy has been
without a true maintainer for too long so if anyone wants to volunteer
to pick it up I believe that would be awesome (Philippe raised this same
issue on his RFC on the 21/11/2017 btw. maybe it is time to address it?)

thanks


[1] kernel/drivers/analogy/national_instruments/pcimio.c

> I tried different variations in the kernel configuration, two different k=
ernels and I still end up with the same problem. So I suppose that somethin=
g is wrong in my .config or maybe there is something that I didn't understo=
od about Analogy, or both.
>
>
> First of all, I installed Xenomai using the following protocol:
>
> >From a fresh and updated Ubuntu 18.04 installation:
> I patch the kernel 4.14.111 found there: https://mirrors.edge.kernel.org/=
pub/linux/kernel/v4.x/
> Using the ipipe patch "ipipe-core-4.14.111-x86-3.patch" found there: http=
s://xenomai.org/downloads/ipipe/v4.x/x86/
> And using the Xenomai version 3.0.8 found there: https://xenomai.org/down=
loads/xenomai/stable/
>
> 1: Extract the Linux kernel and the Xenomai sources in /usr/src/
>
> 2: Install the need package to build the kernel:
> sudo apt-get install libncurses5 libncurses5-dev build-essential kernel-p=
ackage fakeroot libssl-dev
>
> 3: From the Xenomai folder prepare the kernel:
>
> sudo /usr/src/xenomai-3.0.8/scripts/prepare-kernel.sh --linux=3D/usr/src/=
linux-4.14.111 --ipipe=3D/usr/src/ipipe-core-4.14.111-x86-3.patch --arch=3D=
x86_64
>
> 4: From the Linux folder, configure the compilation following the indicat=
ions found there : https://gitlab.denx.de/Xenomai/xenomai/wikis/Configuring=
_For_X86_Based_Dual_Kernels
>
>
> sudo make menuconfig
>
> In short, the modification to the default configuration are the following=
:
> In "Processor type and features":
> - Select the right processor family: "Core 2/newer Xeon". My processor is=
 an Intel i7-4770. It's an old processor, I don't know if it can impact Xen=
omai .
> - In order to disable the "CPU Frequency scaling" (CONFIG_CPU_FREQ), unch=
eck "Multi-core scheduler support" (CONFIG_SCHED_MC) , "ScaleMP vSMP" (CONF=
IG_X86_VSMP) and "Linux guest support" (CONFIG_HYPERVISOR_GUEST).
> - Also uncheck "Enable Maximum number of SMP Processor and NUMA Nodes" (C=
ONFIG_MAXSMP) because if not the boot freeze after "Loading initial ramdisk=
".
>
> In "Power management and ACPI options":
> - Uncheck "CPU idle PM support" (CONFIG_CPU_IDLE)
> - Uncheck "CPU Frequency scaling" (CONFIG_CPU_FREQ)
> - Uncheck "Processor" (CONFIG_ACPI_PROCESSOR)
>
> In "Device driver":
> - Uncheck "PC Speaker support" (CONFIG_INPUT_PCSPKR)
>
> Since I want to use Analogy, I also enable it in the Xenomai menu and che=
ck "NI PCIMIO driver" (XENO_DRIVERS_ANALOGY_NI_PCIMIO) and "Analogy debug t=
race" (XENO_DRIVERS_ANALOGY_DEBUG)
>
> The resulting .config is attached to the email.
>
> 5: Build the kernel and install it:
> sudo make bzImage modules -j4
> sudo make modules_install
> sudo make install
>
> 6: Update the grub to disable hiding and update the default.
> sudo nano /etc/default/grub
> sudo update-grub
>
> 7: I reboot on the new kernel.
>
> 8: From the Xenomai folder, create a build folder:
> sudo mkdir build_root
>
> 9: Configure the Xenomai compilation:
> cd build_root
> sudo /usr/src/xenomai-3.0.8/configure --with-core=3Dcobalt --enable-smp -=
-enable-pshared
>
> 10: Build and install the Xenomai libraries:
> sudo make install
>
> 11: Reboot.
>
>
> At this point, Xenomai seems to work well.
> I run:
> - The autotune program: sudo /usr/xenomai/sbin/autotune
> - The latency test: sudo /usr/xenomai/bin/latency
> - The xeno-test program: sudo /usr/xenomai/bin/xeno-test
>
> Everything seems fine.
>
>
> In order to configure the NI PCI-5269, I notice that I need to blacklist =
the driver "ni_pcimio". If not, the "comedi" module auto-configure the PCI =
and I didn't find a solution to take it back. The comedi_config command per=
mit to unconfig the PCI, but Analogy still can't see it.
> I can then run the following command to configure the PCI:
> sudo /usr/xenomai/sbin/analogy_config analogy0 analogy_ni_pcimio 0x5,0
>
> At this stage, I can configure the PCI. I tried several times, after seve=
ral reboots.
>
> But after a while, the previous analogy command begin to crash the comput=
er randomly. The screen freezes and I have to shut down the computer manual=
ly.
>
> The PCI is found at startup and can be seen in the system log. So the pro=
blem seems to be when Analogy try to attach the driver.
>
> Obviously, something is happening in the kernel, but I don't know what.
> I tried to use a different configuration using kernel 4.4.166 on a ubuntu=
 16.04, but I had the exact same problem. I also tried to switch the proces=
sor family back to "Generic-x86-64", still the same.
>
> Maybe I am missing something obvious, I am not a expert of Linux.
>
>
> Next to that, it seems that there is also some troubles with Ethernet con=
nections. My computer have two Ethernet ports, one on the motherboard and o=
ne on a PCIe card, and the connection doesn't seems to be well detected, qu=
ite randomly too.
>
>
> Finally, I use Qt to run my program and it seems to have a problem with t=
he debug.h file in /usr/xenomai/include/copperplate, in particular with thi=
s line.
> #define debug(fmt, args...)  do { } while (0)
>
> It can compile when the line is commented, but I don't know if it might i=
mpact the rest of xenomai.
>
>
>
> I tried to give a maximum details. If someone have any suggestions, pleas=
e feel free to speak out. :)
>
> Thanks a lot for your great work, I wish you all a nice day !
>
> Best regards,
> Florent
>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: configXenomai.config
> Type: application/octet-stream
> Size: 212140 bytes
> Desc: configXenomai.config
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20190424/9ccfe37b/=
attachment.obj>
>

