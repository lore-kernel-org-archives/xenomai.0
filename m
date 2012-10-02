From: Wayne Warren <wwarren@emacinc.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 02 Oct 2012 16:08:36 -0500
Message-ID: <1349212116.21898.108.camel@ENG-09-LX.emacinc.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Adeos I-Pipe patch problem on vendor-specific kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Howdy folks,

I am currently working on a project to get Xenomai up and running on an
AM3517 based board and have run into some difficulties.

First off, I am starting with a vendor-supplied kernel that was put into
use several months ago and on top of which patches have been applied to
get it working with a board designed by one of my coworkers. This kernel
works fine. It is a based on a TI 2.6.37-based kernel:

http://arago-project.org/git/projects/?p=linux-omap3.git;a=commit;h=adcd067326836777c049e3cb32a5b7d9d401fc31

Because of this I initially chose the following patch:

http://download.gna.org/adeos/patches/v2.6/arm/older/adeos-ipipe-2.6.37.6-arm-1.18-03.patch

because I thought this was as close as I would get.

When it comes time to apply the adeos i-pipe patch, we cannot simply
apply it over our existing kernel tree using the prepare-kernel.sh
script due to merge conflicts.

Because of this I checked out a commit from TI's kernel tree that I
thought would be compatible with the adeos i-pipe patch and it seems to
have applied cleanly. After this, I merged the version of the TI kernel
tree on which our product-specific changes were made; this resulted in
eight conflicts which I was able to resolve in such a way that the
resulting code compiles, but does not boot: When loading this kernel
from u-boot, the kernel seems to hang early in the startup sequence.

It occurred to me, however, that it really might be better to apply the
adeos i-pipe patch directly over the known-to-work commit so that when
searching for the regression I can have a better idea of where to start
looking based on a "git diff --name-only" command.

This would involved pulling the i-pipe patch in directly from:

http://git.xenomai.org/?p=ipipe-gch.git;a=tags

The tag that I have my eye on is ipip-2.6.37.6-arm-1.18-03 which I
believe would correspond with the .patch file listed above. In fact, I
have applied this patch and again resolved the merge conflicts, but run
into a problem in that the Makefile/Kconfig kernel configuration
variables do not seem to be included in that code. What seems to happen
instead in the prepare-kernel.sh script adds them when patching the
kernel. It seems like this script may do other important tasks as well.

I am hoping someone can advise me with regard to either how to proceed
without those variables or maybe offer advice for generally how to
proceed with this attempt to pull in the i-pipe patches for a
vendor-specific kernel branch.

Thanks in advance!

Wayne Warren


