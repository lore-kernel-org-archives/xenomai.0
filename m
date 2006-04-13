Message-ID: <443DFDA5.4080909@domain.hid>
Date: Thu, 13 Apr 2006 09:28:37 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] BuildBot progress for sim, tqm860 with RTnet
References: <200604130659.23223.niklaus.giger@domain.hid>
In-Reply-To: <200604130659.23223.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
> Hi
> 
> I was busy improving the buildbot setup and achieved the following:
> - added build slave for simulator
> - added a buildbot for a TQM860L with Denx PPC 2.4 kernel. Cannot yet build 
> the RTnet code.
> - patched buildbot to show names for shell build steps instead of the commands
> - Hacked buildbot to improve the displayed names of the build step
>   (e.g. "configure_xenomai" instead of "configure 2". 
> 
> I will look at Philippe's idea about collecting xenomai statistics later, 
> because it demands more time and effort to implement.
> 
> The following details are probably only of interest for people interested in 
> TQM860 and/or RTnet.
> 
> My setup for the TQM860 was the following:
> - Got Dan Kegel crosstool 0.42
> - Compiled/installed the demo-ppc860 (gcc-3.4.1-glibc-2.3.3)
> - Used linuxppc_2_4_devel-2006-04-06-1735.tar.bz whith a TQM860L_defconfig
>   plus XENOMAI extensions
> - Got RTnet trunk via SVN
> 
> Could the interested parties please comment, whether this is a good 
> combination or whether they prefer something different? If you follow the 
> logs you are able to see each step and configuration option (except building 
> the crosstool).

Looks good.

> configure rtnet fails with the following message:
> checking for 
> RT-extension... /home/buildslave/bin/linuxppc_2_4_devel-2006-04-06-1735 
> (Xenomai 2.0.x)
> checking for Xenomai version... configure: error: *** Unsupported Xenomai 
> version 2.1.50 in /home/buildslave/bin/linuxppc_2_4_devel-2006-04-06-1735
> Is the error correct? Or should I build only against Xenomai 2.0?

For Xenomai 2.1.x I configure, build and install RTnet as shown:

$ export CROSS_COMPILE=ppc_8xx-
$ ./configure 
--with-linux=/temp/rt/test/linuxppc_2_4_devel-2006_03_26_1343 
--host=ppc-linux --prefix=/root/xeno4rtnet --enable-fec-enet 
--enable-scc-enet
$ make
$ export DESTDIR=/opt/eldk/ppc_8xx
$ make install

Wolfgang.



