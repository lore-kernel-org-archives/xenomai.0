MIME-Version: 1.0
Date: Thu, 15 Jul 2010 11:39:41 +0000
Message-ID: <AANLkTilAdUGrkep3tlofYpRYxEOto2XpM29NWA_F4_7g@domain.hid>
From: PREMRAJ SV <svprem20@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd23f0ee2a855048b6b8ef1
Subject: [Xenomai-help] Xenomai Compilation error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--000e0cd23f0ee2a855048b6b8ef1
Content-Type: text/plain; charset=ISO-8859-1

Dear all,
              I was installing Xenomai and follwing error occured..
    On my dual core processor
1. I am using Cent OS 5.5
2. I tarred Linux-2.6.28 and Xenomai-2.4.6 in my /usr/src/kernels
3. Patched Xenomai Adeos Patch to linux source
4. make menuconfig
5. I have followed an Intel Document For Xenoimai on Cent OS for Testing and
options follows,
    Processor Types and Features->i686 arch
    Disabled SMI
    Power mAnagement-> disabled
    Frequency scaling-> disabled
    CPU Idle PM Support-> Disable
    High Resolution Timer->Enabled
    Check for thermal Throttling-> Disabled
    Toshiba laptop support->Disabled
    Dell laptop support-> Disabled
    Enabled RTAI Emulator, Testing Drivers, IRQ
    HPET-> Disabled
    Bus options-> PCI Express Hotplug driver-> disabled
                            MSI-> Disabled
                            PCCCard Support-> Disabled

And While make,

CC kernel/Xenomai/arch/generic/
hal.o
In file included from include/asm/Xenomai/hal.h :73
>From Kernel/Xenomai/arch/generic/hal.c :47
include /asm/Xenomai/hal_32.h:62
Error:#error"Xenomai needs a working LAPIC-if your machine has a bad
one,you"
Error:"should disable CONFIG_X86_LOCAL_APIC in your kernel configuration"


There was no options in Processor Types like APIC...DOnt know where to find
it and Disable...I have tried editing .config file but no luck..Guidance
Please....

--000e0cd23f0ee2a855048b6b8ef1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear all,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 I was installing Xenom=
ai and follwing error occured.. <br>=A0=A0=A0 On my dual core processor<br>=
1. I am using Cent OS 5.5<br>2. I tarred Linux-2.6.28 and Xenomai-2.4.6 in =
my /usr/src/kernels<br>3. Patched Xenomai Adeos Patch to linux source<br>

4. make menuconfig<br>5. I have followed an Intel Document For Xenoimai on =
Cent OS for Testing and options follows,<br>=A0=A0=A0 Processor Types and F=
eatures-&gt;i686 arch<br>=A0=A0=A0 Disabled SMI<br>=A0=A0=A0 Power mAnageme=
nt-&gt; disabled<br>

=A0=A0=A0 Frequency scaling-&gt; disabled<br>=A0=A0=A0 CPU Idle PM Support-=
&gt; Disable<br>=A0=A0=A0 High Resolution Timer-&gt;Enabled<br>=A0=A0=A0 Ch=
eck for thermal Throttling-&gt; Disabled<br>=A0=A0=A0 Toshiba laptop suppor=
t-&gt;Disabled<br>=A0=A0=A0 Dell laptop support-&gt; Disabled<br>

=A0=A0=A0 Enabled RTAI Emulator, Testing Drivers, IRQ <br>=A0=A0=A0 HPET-&g=
t; Disabled<br>=A0=A0=A0 Bus options-&gt; PCI Express Hotplug driver-&gt; d=
isabled<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 MSI-&gt; Disabled<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PCCCard Support-&gt; Disab=
led<br>

<br>And While make,<br><br>CC kernel/Xenomai/arch/generic/<div id=3D":1a9" =
class=3D"ii gt">hal.o<br>In file included from include/asm/Xenomai/hal.h :7=
3<br>From Kernel/Xenomai/arch/generic/hal.c :47<br>include /asm/Xenomai/hal=
_32.h:62<br>
Error:#error&quot;Xenomai needs a working LAPIC-if your machine has a bad o=
ne,you&quot;<br>
Error:&quot;should disable CONFIG_X86_LOCAL_APIC in your kernel configurati=
on&quot;<br><br><br>There
was no options in Processor Types like APIC...DOnt know where to find
it and Disable...I have tried editing .config file but no
luck..Guidance Please....</div>

--000e0cd23f0ee2a855048b6b8ef1--

