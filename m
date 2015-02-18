Date: Wed, 18 Feb 2015 21:56:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150218205606.GO30317@hermes.click-hack.org>
References: <20150218181334.GE30317@hermes.click-hack.org>
 <54E4D835.1040204@siemens.com>
 <20150218182632.GG30317@hermes.click-hack.org>
 <54E4DDEA.3060909@siemens.com>
 <20150218184943.GH30317@hermes.click-hack.org>
 <54E4E166.5030701@siemens.com>
 <20150218190549.GI30317@hermes.click-hack.org>
 <54E4E546.8080801@siemens.com>
 <20150218192712.GJ30317@hermes.click-hack.org>
 <54E4FAF4.7050004@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54E4FAF4.7050004@siemens.com>
Subject: Re: [Xenomai] arm: Late delivery of pending Linux signals?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Wed, Feb 18, 2015 at 09:49:56PM +0100, Jan Kiszka wrote:
> On 2015-02-18 20:27, Gilles Chanteperdrix wrote:
> > On Wed, Feb 18, 2015 at 08:17:26PM +0100, Jan Kiszka wrote:
> >> The Versatile Express is the ARM reference board, not something
> >> arbitrary virtual. It's also what you get when you obtain the Fast Model
> >> (CPU and system emulator) from ARM.
> > 
> > Nevertheless, it is a board that nobody uses for real projects,
> > so adding support for it is still a waste of resources.
> 
> No need to worry, it mostly just works. Apparently, I-pipe already
> covers the whole Cortex-A series with its unified timers, clocks, and
> interrupt controllers. Well, with the exception of SoCs that have
> additional interrupt controllers - like the NVIDIA Tegra124, which I'm
> currently looking at for other purposes.

As far as I understood versatile is a platform which accepts several
processor modules, which cover a large part of the ranges of all
ARM cores made by ARM.

> 
> "Mostly" because sshd is dying for unknown reasons. Same rootfs, same
> emulator but newer kernel without I-pipe, and it works fine. One after
> the other.
> 
> BTW, I noticed that LPAE build is broken. Trivial to fix (missing
> argument to cpu_switch_mm), but maybe there is more behind it as it was
> not used so far. Anything mm-related that one has to look at carefully
> on ARM(v7)?

For LPAE support you need that commit:
https://git.xenomai.org/ipipe.git/commit/?h=ipipe-3.16&id=653ee8e622fe2ab7ff2fda1a0d14100d01bbf2e5

at least.

-- 
					    Gilles.

