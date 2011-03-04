Message-ID: <4D70FC9A.7040007@domain.hid>
Date: Fri, 04 Mar 2011 15:52:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTinnqCe1aJzfsJMGApD2De7NAk1hhOYAWqKdJfAL@mail.gmail.com>
In-Reply-To: <AANLkTinnqCe1aJzfsJMGApD2De7NAk1hhOYAWqKdJfAL@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai patched kernel "laggy"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Hyams <jeff.hyams@domain.hid>
Cc: xenomai@xenomai.org

Jeff Hyams wrote:
> I am running a patched 2.6.32.20 kernel with the correct xenomai patches
> (2.5.5.2 and the adeos patch for 2.6.32.20) and my RT application seems to
> work fine, I can use the PEAK CAN drivers fine, and I managed to make a
> config where all my interrupts work.  However, when using the machine
> without any real time apps running, I start to see a lot of latency in
> normal use.  Ie, a regular compile operation that normally takes a few
> seconds all the sudden takes a minute, and my i/o also seems incredibly
> slow.  The display also seems lag frequently.
> 
> I have been trying to track down the problem for a while now, but I am not
> seeing any specific error messages in any of the syslogs or anywhere, and
> the machine does not completely hang or anything.  I was wondering if anyone
> had any advice on where to look next?
> 
> I'm running on a dual quad core 64 bit Xeon machine with an nvidia Quadro fx
> 4800, a dual channel PEAK CAN card, 2 dual channel network adapters, and a
> dual channel firewire card.
> 
> For reference,  I did an install of the Ubuntu 10.04 iso, then basically
> followed the instructions referenced here:
> http://www.xenomai.org/index.php/Building_Debian_packages.    With the
> additional caveat of doing an apt-get purge on nvidia-current and the an
> apt-get install on nvidia-current to get the proprietary nvidia driver to
> work with the new kernel.
> 
> Any help would be greatly appreciated.

Send us the result of cat /proc/interrupts and cat /proc/xenomai/irq
And the FULL kernel logs, from the boot, up to the point where you start
seeing any issue. And please remove the "quiet" on the kernel command
line in grub configuration, if any. Please also send the kernel .config.

You may also want to try the tip of Xenomai 2.5.x branch, to see if the
issue is still there.

-- 
					    Gilles.

