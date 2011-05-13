Message-ID: <4DCD0DFC.7050506@domain.hid>
Date: Fri, 13 May 2011 12:54:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <294B28951EBE8146839AF99A61CB5FCE6B3F1A7999@domain.hid>
In-Reply-To: <294B28951EBE8146839AF99A61CB5FCE6B3F1A7999@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.5.X - 32 bit X86 is not running on
	newer Kernel Versions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Benner Bernd (MH/EES)" <B.Benner@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2011-05-13 11:55, Benner Bernd (MH/EES) wrote:
> Hi,
> 
>    we have a well running X86 Realtime system with Kernel 2.6.29 and xenomai-2.4.10. The system is able to boot from a stick and runs on all our computers.
>  To fix some X11- problems with newer graphic chipsets, we try to upgrade to a newer Kernel version.
> 
>    We are starting with Kernel 2.6.34.5 and xenomai-2.5.5.2 using the latest ADEOS-patches. This system works on some test machines, but on some Core 2 Duo 3 GHz systems with Intel Desktop Chipset ( Lenovo and HP ) the system freeze and/or produces strange console outputs ( only line feeds ) after a start of latency or clocktest.
> We are not able to get a kernel log from this systems.

Also not via serial console?

> 
>   All permutations of Kernel 2.6.34.5, Kernel 2.6.35.13, xenomai-2.5.3, xenomai-2.5.5.2, xenomai-2.5.6 has the same problems on the Core 2 Duo 3 GHz machines.
> On other machines with slower Mobile Core 2 Duo or Pentiom M processors the system runs or has sometimes the same problem.
> 
>   I have try some changes in the Kernel configuration, without any success.  I have also try a combination of Kernel 2.6.35.13. and xenomai-2.4.10 with some changes in the xenomai headers to run with newer Kernels. This version has the same problem on the Core 2 Duo 3 GHz systems.
> 
>   Is there any way to find the reason of this problems with Xenomai 2.5.X and newer Kernels 2.6.3X with 32 bit X86 or has anybody similar problems fixed.

The latest x86 fix can be found in git:

http://git.denx.de/?p=ipipe-2.6.git;a=shortlog;h=refs/heads/ipipe-2.6.37-x86
ie. ipipe-2.6.37-x86 branch of git://git.denx.de/ipipe-2.6.git

It's surely worth retrying with that version and latest Xenomai (maybe
even 2.6.x git, though 2.5.x should contain all known fixes).

Otherwise, please provide your .config.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

