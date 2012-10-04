Message-ID: <506DC2DA.5000105@xenomai.org>
Date: Thu, 04 Oct 2012 19:09:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1349212116.21898.108.camel@ENG-09-LX.emacinc.com>	
	<506B5D6B.80005@xenomai.org> <506B5E0E.5050900@xenomai.org>
	<1349369822.3775.107.camel@ENG-09-LX.emacinc.com>
In-Reply-To: <1349369822.3775.107.camel@ENG-09-LX.emacinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Adeos I-Pipe patch problem on vendor-specific kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wayne Warren <wwarren@emacinc.com>
Cc: xenomai@xenomai.org

On 10/04/2012 06:57 PM, Wayne Warren wrote:
> Gilles,
> 
> Thanks for your help!
> 
> The ArmPorting guide is helpful, but unfortunately the first tip and
> trick did not reveal any boot messages. I had to add a function
> declaration for "printascii" to get the code to compile. I have
> CONFIG_DEBUG_KERNEL, CONFIG_DEBUG_LL, and CONFIG_EARLY_PRINTK enabled
> and have passed the boot parameter "earlyprintk" when attempting to
> boot. 

Either you enable CONFIG_EARLY_PRINTK and pass earlyprintk on the
command line, that is the "new" way.

Or, you do the printascii in printk trick, that is the "old" way.

If you do both, you should see everything printed twice.
If you do not see anything, it probably means that printascii does not
work for your platform. To get it working, you have to look at
arch/arm/your-machine/include/mach/debug-macro.S
And of course, your kernel has to be compiled for only one board, if the
UART used by these macros depends on the board.

You can validate printascii without the I-pipe patch first. Simply put
printascii("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n") in some board init
function, and check if you see that line among the boot logs.


> 
> According to 
> 
> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting
> 
> (which seems to be a newer version of the page you mentioned) I should
> try to boot the kernel without CONFIG_IPIPE or CONFIG_XENOMAI enabled
> and if it does not work it is likely to be a problem with the timer.
> 
> I have then used "git diff --name-only <known-working-ti-kernel-ref>
> <ipipe-merged-ref>" to get a list of files and I have been looking
> through their current versions alongside a diff of each given file while
> reading to the instructions provided in both the old and the new
> ArmPorting guides to see what might have changed in timer-related code
> that would prevent the kernel from booting.
> 
> If you have any additional advice, I would greatly appreciate it.

The first advice is to try booting a kernel without even the Adeos patch
applied, to have a .config which you are 100% sure is supposed to boot.
Then try to get printascii running. Then debug the boot process to see
at what point the lockup happens.

The code you have to add to get the timer running with the I-pipe patch
is what is documented in the old document, not the new one. The new one
documents the I-pipe patch for Linux kernels starting with 3.2.

> Also, if I could get an account on the Xenomai wiki, there are some simple
> changes I would make to the ArmPorting page to improve its readability a
> little (for example, create indented paragraphs for the description of
> the "struct ipipe_timer" members). I guess I don't really have anything
> concrete or technical to add to it so if you don't want to add me, I
> understand.

Done, you should have received a mail with your password.


-- 
					    Gilles.

