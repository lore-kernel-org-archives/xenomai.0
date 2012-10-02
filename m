Message-ID: <506B5D6B.80005@xenomai.org>
Date: Tue, 02 Oct 2012 23:32:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1349212116.21898.108.camel@ENG-09-LX.emacinc.com>
In-Reply-To: <1349212116.21898.108.camel@ENG-09-LX.emacinc.com>
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

On 10/02/2012 11:08 PM, Wayne Warren wrote:

> Howdy folks,


Hi

(snip)
> The tag that I have my eye on is ipip-2.6.37.6-arm-1.18-03 which I

> believe would correspond with the .patch file listed above. In fact, I
> have applied this patch and again resolved the merge conflicts, but run
> into a problem in that the Makefile/Kconfig kernel configuration
> variables do not seem to be included in that code. What seems to happen
> instead in the prepare-kernel.sh script adds them when patching the
> kernel. It seems like this script may do other important tasks as well.
> 
> I am hoping someone can advise me with regard to either how to proceed
> without those variables or maybe offer advice for generally how to
> proceed with this attempt to pull in the i-pipe patches for a
> vendor-specific kernel branch.


You need to run prepare-kernel.sh with the I-pipe tree as well.
prepare-kernel.sh will simply skip the step where it tries to apply the
adeos patch. Actually, that is the way we maintain the Xenomai and the
I-pipe patch: we work with git and compile the prepared kernel.

To merge the I-pipe tree with a vendor tree, you can use git merge.


-- 
                                                                Gilles.

