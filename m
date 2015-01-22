Date: Thu, 22 Jan 2015 20:33:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150122193359.GD29604@hermes.click-hack.org>
References: <1537147.Wm9AbiuW5D@soho> <2296691.2JpS0rAJbA@soho>
 <20150122114038.GE23461@hermes.click-hack.org>
 <4743020.6q5RsBy8Ia@soho> <54C0F262.6010806@siemens.com>
 <20150122144930.GL30245@csclub.uwaterloo.ca>
 <20150122145624.GF26731@hermes.click-hack.org>
 <20150122172142.GM30245@csclub.uwaterloo.ca>
 <20150122191640.GC29604@hermes.click-hack.org>
 <20150122192757.GO30245@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150122192757.GO30245@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] Xenomai-3 creating debian packages
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On Thu, Jan 22, 2015 at 02:27:57PM -0500, Lennart Sorensen wrote:
> On Thu, Jan 22, 2015 at 08:16:40PM +0100, Gilles Chanteperdrix wrote:
> > Then I can tell you, using one I-pipe tree and one Xenomai tree for
> > multiple architectures has been possible for years, this is how I
> > develop on Xenomai.
> 
> Well the patches for arm and patches for powerpc had a merge conflict
> when applying the patch in init/Kconfig where both want to add 1 line
> for source "arch/<current arch>/xenomai/Kconfig"
> 
> Everything else applies great (using the patches generated from the
> xenomai tree with one patch for arm, one for powerpc and one for common).

When working with the I-pipe git, there is just one tree with all
the architecture changes in it. So, no need to apply patches. The
trick is to not run prepare-kernel on that tree, but on another tree
obtained with "lndir".

As for --split option of scripts/ipipe/genpatches.sh to generate a
separate the "noarch" patch, it is kind of obsolete now, since it
was made to help porting the I-pipe from one kernel to the next,
when we reapplied the I-pipe patch on top of the kernel to do that.
Since today we have adopted a "merge" workflow (which by the way
makes things much harder for an I-pipe maintainer), we no longer
need that option.

-- 
					    Gilles.

