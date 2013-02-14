Message-ID: <511D3F8F.8090501@xenomai.org>
Date: Thu, 14 Feb 2013 20:48:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201302141227.05428.paul_c@tuxcnc.org>
In-Reply-To: <201302141227.05428.paul_c@tuxcnc.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai, Raspberry Pi, 3.5.7 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul_c@tuxcnc.org>
Cc: xenomai@xenomai.org

On 02/14/2013 01:27 PM, Paul wrote:

> 
> Attached, a patch set aimed at providing support for the Broadcom 
> BCM2835 SoC as used in the Raspberry Pi[1].
> 
> The first patch assumes that the core-ipipe-3.5.7-arm patch has already 
> been applied or the sources have been pulled from the ipipe git 
> repository[2]. Most of the changes have been pulled from the 3.6.11 
> kernel sources maintained by the Rasbperry team and adds a number of 
> drivers needed by the BCM2835 chip. Low level changes to the timer 
> support have been made courtesy of ian-cim and his preliminary 3.2.21 
> patch[3]
> 
> Patch number 2 silences a trivial compile time warning and can be 
> skipped..
> Patch number three adds a minimal default config (bcmrpi_defconfig) that 
> can be used as a basis for compiling a Xenomai enabled kernel. This 
> patch can also be skipped if a defconfig is not required.
> 
> Patch number four makes some changes to the way GPIO interrupts are 
> handled - Interrupt latencies are considerably improved (typically in 
> the 15-30uS range).
> 
> Work is being undertaken by the Raspberry team to get support built in 
> to the mainline kernel - I believe the window has been missed for 
> 3.8.x, so fingers are crossed for 3.10.x.


In the meantime, we can put it in a raspberry subdirectory in Xenomai
sources. Would you mind making a single patch? Or do you prefer the
patches to be kept separated?

-- 
                                                                Gilles.

