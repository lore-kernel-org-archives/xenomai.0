Message-ID: <OF8AF7B8AE.31B3D7A5-ONC12574AC.004DF0CC-C12574AC.004E0846@domain.hid>
From: juergen.lanner@domain.hid
Date: Thu, 21 Aug 2008 16:12:05 +0200
MIME-Version: 1.0
Content-type: multipart/alternative; 
	Boundary="0__=4EBBFE3FDFDE765C8f9e8a93df938690918c4EBBFE3FDFDE765C"
Content-Disposition: inline
Subject: [Xenomai-help] problems patching the kernel 2.6.25.11 with xenomai
	2.4.4 under ubuntu
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

--0__=4EBBFE3FDFDE765C8f9e8a93df938690918c4EBBFE3FDFDE765C
Content-type: text/plain; charset=US-ASCII



Hi gentlemen!

I am trying to set up xenomai along the
http://www.xenomai.org/index.php/Xenomai_quick_build_quide
using exactly the same packages as described (2.6.25.11 linux and 2.4.4
xenomai)

.. but failed so far :-(

I did all the following as superuser:

cd /usr/src
wget http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.25.11.tar.bz2
wget http://download.gna.org/xenomai/stable/xenomai-2.4.4.tar.bz2
tar xfj xenomai-2.4.4.tar.bz2
tar xfj linux-2.6.25.11.tar.bz2
cd /usr/src/xenomai-2.4.4
scripts/prepare-kernel.sh
            keyed in: /usr/src/linux-2.6.25.11
cd /usr/src/linux-2.6.25.11
cp /boot/config-2.6.24-16-generic  .config
make menuconfig

When calling make menuconfig I see the following in the "Real-time
sub-system" menu


*** WARNING! You enabled APM, CPU Frequency scaling or ACPI 'processor'
*** option. These options are known to cause troubles with Xenomai.
*** NOTE: Xenomai conflicts with PC speaker support.
*** (menu Device Drivers/Input device support/Miscellaneous devices)
*** NOTE: Xenomai needs either X86_LOCAL_APIC enabled or HPET_TIMER
disabled.
*** (menu Processor type and features)

The section in .config looks like this:

#
# Real-time sub-system
#

#
# WARNING! You enabled APM, CPU Frequency scaling or ACPI 'processor'
#

#
# option. These options are known to cause troubles with Xenomai.
#

#
# NOTE: Xenomai conflicts with PC speaker support.
#

#
# (menu Device Drivers/Input device support/Miscellaneous devices)
#

#
# NOTE: Xenomai needs either X86_LOCAL_APIC enabled or HPET_TIMER disabled.
#

#
# (menu Processor type and features)
#
CONFIG_XENO_GENERIC_STACKPOOL=y


Shouldn't there be all the xenomai specific settings there?
What went wrong?
How do they usually come into the .config file?


Thanx

juergen
--0__=4EBBFE3FDFDE765C8f9e8a93df938690918c4EBBFE3FDFDE765C
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><font face="Arial"><br>
</font><font face="Arial">Hi gentlemen!</font><br>
<br>
<font face="Arial">I am trying to set up xenomai along the </font><font face="Arial"><a href="http://www.xenomai.org/index.php/Xenomai_quick_build_quide">http://www.xenomai.org/index.php/Xenomai_quick_build_quide</a></font><br>
<font face="Arial">using exactly the same packages as described (2.6.25.11 linux and 2.4.4 xenomai)</font><br>
<br>
<font face="Arial">.. but failed so far :-(</font><br>
<br>
<font face="Arial">I did all the following as superuser:</font><br>
<br>
<font face="Courier">cd /usr/src<br>
wget </font><a href="http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.25.11.tar.bz2"><u><font color="#0000FF" face="Courier">http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.25.11.tar.bz2</font></u></a><br>
<font face="Courier">wget </font><a href="http://download.gna.org/xenomai/stable/xenomai-2.4.4.tar.bz2"><u><font color="#0000FF" face="Courier">http://download.gna.org/xenomai/stable/xenomai-2.4.4.tar.bz2</font></u></a><br>
<font face="Courier">tar xfj xenomai-2.4.4.tar.bz2<br>
tar xfj linux-2.6.25.11.tar.bz2</font><br>
<font face="Courier">cd /usr/src/xenomai-2.4.4<br>
scripts/prepare-kernel.sh</font><br>
<font face="Courier">		keyed in: /usr/src/linux-2.6.25.11</font><br>
<font face="Courier">cd /usr/src/linux-2.6.25.11<br>
cp /boot/config-2.6.24-16-generic  .config<br>
make menuconfig</font><br>
<br>
<font face="Arial">When calling make menuconfig I see the following in the &quot;Real-time sub-system&quot; menu</font><br>
<br>
<br>
<font face="Courier">*** WARNING! You enabled APM, CPU Frequency scaling or ACPI 'processor'</font><br>
<font face="Courier">*** option. These options are known to cause troubles with Xenomai.</font><br>
<font face="Courier">*** NOTE: Xenomai conflicts with PC speaker support.</font><br>
<font face="Courier">*** (menu Device Drivers/Input device support/Miscellaneous devices)</font><br>
<font face="Courier">*** NOTE: Xenomai needs either X86_LOCAL_APIC enabled or HPET_TIMER disabled.</font><br>
<font face="Courier">*** (menu Processor type and features)</font><br>
<br>
<font face="Arial">The section in .config looks like this:</font><br>
<br>
<font face="Courier">#</font><br>
<font face="Courier"># Real-time sub-system</font><br>
<font face="Courier">#</font><br>
<br>
<font face="Courier">#</font><br>
<font face="Courier"># WARNING! You enabled APM, CPU Frequency scaling or ACPI 'processor'</font><br>
<font face="Courier">#</font><br>
<br>
<font face="Courier">#</font><br>
<font face="Courier"># option. These options are known to cause troubles with Xenomai.</font><br>
<font face="Courier">#</font><br>
<br>
<font face="Courier">#</font><br>
<font face="Courier"># NOTE: Xenomai conflicts with PC speaker support.</font><br>
<font face="Courier">#</font><br>
<br>
<font face="Courier">#</font><br>
<font face="Courier"># (menu Device Drivers/Input device support/Miscellaneous devices)</font><br>
<font face="Courier">#</font><br>
<br>
<font face="Courier">#</font><br>
<font face="Courier"># NOTE: Xenomai needs either X86_LOCAL_APIC enabled or HPET_TIMER disabled.</font><br>
<font face="Courier">#</font><br>
<br>
<font face="Courier">#</font><br>
<font face="Courier"># (menu Processor type and features)</font><br>
<font face="Courier">#</font><br>
<font face="Courier">CONFIG_XENO_GENERIC_STACKPOOL=y</font><br>
<br>
<br>
<font face="Arial">Shouldn't there be all the xenomai specific settings there?</font><br>
<font face="Arial">What went wrong? </font><br>
<font face="Arial">How do they usually come into the .config file?</font><br>
<br>
<font face="Arial"><br>
Thanx</font><br>
<br>
<font face="Arial">juergen</font></body></html>
--0__=4EBBFE3FDFDE765C8f9e8a93df938690918c4EBBFE3FDFDE765C--


