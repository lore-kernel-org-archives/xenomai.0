Date: Thu, 30 Apr 2015 16:53:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150430145352.GV1993@hermes.click-hack.org>
References: <3382708.2jmfqTEg5F@eltrolinux48.eltroad.eltropuls>
 <20150430144105.GU1993@hermes.click-hack.org>
 <5455853.puTnBMi752@eltrolinux48.eltroad.eltropuls>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5455853.puTnBMi752@eltrolinux48.eltroad.eltropuls>
Subject: Re: [Xenomai] Hang/Reboot when using
	CONFIG_CC_STACKPROTECTOR_REGULAR
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marc =?utf-8?Q?Str=C3=A4mke?= <marc.straemke@eltropuls.de>
Cc: xenomai@xenomai.org

On Thu, Apr 30, 2015 at 04:44:46PM +0200, Marc Strämke wrote:
> Am Donnerstag, 30. April 2015, 16:41:05 schrieb Gilles Chanteperdrix:
> > No. At least ARM and x86 architectures are supposed to support the
> > stack protector. Maybe you could tell us on what architecture you
> > have this issue?
> 
> The platform is 32bit x86. GCC version is 4.9.2. I can reliably get the 
> behaviour by switching just this single config option on three different 
> machines. 

I have no doubt about that. I am just telling you that disabling the
stack protector is not an option.

> 
> Anything else I can do to help troubleshooting? The kernel actually does not 
> print any message to the console even with all debugging information (ipipe 
> and xenomai) switched on. Most of the time it just reboots, which seems 
> strange to me as is (the TCO watchdog etc is switched off and reboot on panic 
> also..). It did hang on some trys also though ... (not fully reproducible)

Is CONFIG_CC_STACKPROTECTOR enabled when you enable the *_REGULAR
option ? The first thing to check is that the xnarch_switch_to
function contains the necessary bits in the kernel ELF image
disassembly (function vmlinux at the top of the kernel build
directory). You should compare this code to the contents of
kernel/cobalt/arch/x86/thread.c in xenomai sources (where you see
some code with #ifdef CONFIG_CC_STACKPROTECTOR).

-- 
					    Gilles.

