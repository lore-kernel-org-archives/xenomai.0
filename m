Date: Wed, 26 Aug 2015 16:28:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150826142828.GC13935@hermes.click-hack.org>
References: <loom.20150826T125226-959@post.gmane.org>
 <20150826141853.GX15616@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150826141853.GX15616@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] unable to patch kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Fabian <fabian.hartl@avl.com>, xenomai@xenomai.org

On Wed, Aug 26, 2015 at 10:18:53AM -0400, Lennart Sorensen wrote:
> On Wed, Aug 26, 2015 at 11:03:33AM +0000, Fabian wrote:
> > Hi,
> > 
> > I am trying to patch a beaglebone black debian arm kernel with the xenomai 3
> > kernel for dual kernel mode (cobalt).
> > 
> > I used the debian kernel v3.14.39 and the ipipe-core 3.14.39-arm-9.patch,
> > because this seems to be the newest matching combination. but when i start
> > the patching it tells me:
> > 
> > prepare-kernel.sh: Unable to patch kernel 3.14.39 with
> > ipipe-core3.14.39-arm-9.patch
> > 
> > I also tried other kernel and ipipe versions combinations but with the same
> > result.
> > 
> > I got the debian-kernel from this git: https://github.com/beagleboard/linux.git 
> 
> That is NOT a debian kernel source.

This does not change anything. As long as this is not a mainline
Linux kernel source, the I-pipe patches may not apply. And even if
they apply, further work is needed.

-- 
					    Gilles.
https://click-hack.org

