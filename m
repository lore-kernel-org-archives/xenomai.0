From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 26 Aug 2015 10:18:53 -0400
Message-ID: <20150826141853.GX15616@csclub.uwaterloo.ca>
References: <loom.20150826T125226-959@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20150826T125226-959@post.gmane.org>
Subject: Re: [Xenomai] unable to patch kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fabian <fabian.hartl@avl.com>
Cc: xenomai@xenomai.org

On Wed, Aug 26, 2015 at 11:03:33AM +0000, Fabian wrote:
> Hi,
> 
> I am trying to patch a beaglebone black debian arm kernel with the xenomai 3
> kernel for dual kernel mode (cobalt).
> 
> I used the debian kernel v3.14.39 and the ipipe-core 3.14.39-arm-9.patch,
> because this seems to be the newest matching combination. but when i start
> the patching it tells me:
> 
> prepare-kernel.sh: Unable to patch kernel 3.14.39 with
> ipipe-core3.14.39-arm-9.patch
> 
> I also tried other kernel and ipipe versions combinations but with the same
> result.
> 
> I got the debian-kernel from this git: https://github.com/beagleboard/linux.git 

That is NOT a debian kernel source.  It looks like a TI kernel source
tree, and certainly the 3.14 branch on it is currently 3.14.51 based.
You didn't say which branch you used.

> and the xenomai-kernel from here: https://git.xenomai.org/xenomai-3.git
> 
> 
> Unfortunately i have not found an instruction how to do this with the new
> xenomai version 3, only version 2.6 is described in the net.

If you try to manually apply the patch file with patch you might see
where the conflicts are.

-- 
Len Sorensen

