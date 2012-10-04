From: Wayne Warren <wwarren@emacinc.com>
In-Reply-To: <506B5E0E.5050900@xenomai.org>
References: <1349212116.21898.108.camel@ENG-09-LX.emacinc.com>
	<506B5D6B.80005@xenomai.org>  <506B5E0E.5050900@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 04 Oct 2012 11:57:02 -0500
Message-ID: <1349369822.3775.107.camel@ENG-09-LX.emacinc.com>
Mime-Version: 1.0
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles,

Thanks for your help!

The ArmPorting guide is helpful, but unfortunately the first tip and
trick did not reveal any boot messages. I had to add a function
declaration for "printascii" to get the code to compile. I have
CONFIG_DEBUG_KERNEL, CONFIG_DEBUG_LL, and CONFIG_EARLY_PRINTK enabled
and have passed the boot parameter "earlyprintk" when attempting to
boot. 

According to 

http://www.xenomai.org/index.php/I-pipe-core:ArmPorting

(which seems to be a newer version of the page you mentioned) I should
try to boot the kernel without CONFIG_IPIPE or CONFIG_XENOMAI enabled
and if it does not work it is likely to be a problem with the timer.

I have then used "git diff --name-only <known-working-ti-kernel-ref>
<ipipe-merged-ref>" to get a list of files and I have been looking
through their current versions alongside a diff of each given file while
reading to the instructions provided in both the old and the new
ArmPorting guides to see what might have changed in timer-related code
that would prevent the kernel from booting.

If you have any additional advice, I would greatly appreciate it. Also,
if I could get an account on the Xenomai wiki, there are some simple
changes I would make to the ArmPorting page to improve its readability a
little (for example, create indented paragraphs for the description of
the "struct ipipe_timer" members). I guess I don't really have anything
concrete or technical to add to it so if you don't want to add me, I
understand.

Thanks again for your generous help!

Wayne

On Tue, 2012-10-02 at 23:35 +0200, Gilles Chanteperdrix wrote:
> On 10/02/2012 11:32 PM, Gilles Chanteperdrix wrote:
> 
> > On 10/02/2012 11:08 PM, Wayne Warren wrote:
> > 
> >> Howdy folks,
> > 
> > 
> > Hi
> > 
> > (snip)
> >> The tag that I have my eye on is ipip-2.6.37.6-arm-1.18-03 which I
> > 
> >> believe would correspond with the .patch file listed above. In fact, I
> >> have applied this patch and again resolved the merge conflicts, but run
> >> into a problem in that the Makefile/Kconfig kernel configuration
> >> variables do not seem to be included in that code. What seems to happen
> >> instead in the prepare-kernel.sh script adds them when patching the
> >> kernel. It seems like this script may do other important tasks as well.
> >>
> >> I am hoping someone can advise me with regard to either how to proceed
> >> without those variables or maybe offer advice for generally how to
> >> proceed with this attempt to pull in the i-pipe patches for a
> >> vendor-specific kernel branch.
> > 
> > 
> > You need to run prepare-kernel.sh with the I-pipe tree as well.
> > prepare-kernel.sh will simply skip the step where it tries to apply the
> > adeos patch. Actually, that is the way we maintain the Xenomai and the
> > I-pipe patch: we work with git and compile the prepared kernel.
> > 
> > To merge the I-pipe tree with a vendor tree, you can use git merge.
> 
> 
> Also note that there is a guide for porting the I-pipe patch to a new board:
> http://www.xenomai.org/index.php/I-pipe:ArmPorting
> 
> It is a bit outdated for 2.6.37, so, look at an architecture which works
> (for instance omap3) to know what to do.
> 
> In your case, you should try the first entry in the "tips and tricks"
> section.
> 


