Date: Thu, 5 Nov 2015 12:01:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151105110141.GC16314@hermes.click-hack.org>
References: <20151105015114.GJ21923@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151105015114.GJ21923@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] ARM bus error due to alignment
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Wed, Nov 04, 2015 at 08:51:14PM -0500, Lennart Sorensen wrote:
> We are trying to move from gcc 4.6 to gcc 4.9 (as part of moving from
> being Debian wheezy based to jessie based).
> 
> This has now brought up an unexpected change in behaviour on arm (powerpc
> is fine).  We are getting bus errors with kernel complaints about
> unaligned memory accesses.  Now it is certainly true that we are doing
> some unaligned memory accesses, but on armv7 that is supposed to be
> allowed, as long as the memory is marked as "normal memory".
> 
> gcc 4.6 and earlier never generated unaligned accesses as far as I
> understand it, while gcc 4.7 and higher do generate unaligned accesses
> by default on armv7 according to the gcc documentation.
> 
> Is it expected that the memory in xenomai would not be flagged as normal
> memory (the other options as far as I understand it are device memory
> and strongly ordered memory).
> 
> This is with 3.14 kernel and xenomai 2.6.4 with LPAE enabled on a
> Cortex-A15 system.
> 
> So same code, same xenomai, same kernel with gcc 4.6 does not see this,
> while with 4.9 it does.  I tried building the application with
> -nno-unaligned-accesses, but I didn't rebuild the libraries that way,
> so that might not be enough.  Really I think it should work fine, since I
> can't see why the pages would be flagged as something other than normal
> memory (unless DMA pages are somehow getting involved, since some of
> this is dealing with network packets being received).
> 
> Any ideas where to investigate?

You need some piece of code, somewhere, to program the processor to
not get the fault. I think Linux historically set the processor to
generate a fault so as to be able to control the behaviour with what
is explained in Documentation/arm/mem_alignment, but there is a way
to avoid the fault on armv7. Maybe a kernel parameter, maybe you
need a more recent version of u-boot.

-- 
					    Gilles.
https://click-hack.org

