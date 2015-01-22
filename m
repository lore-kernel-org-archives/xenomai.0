From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 22 Jan 2015 15:15:47 -0500
Message-ID: <20150122201547.GP30245@csclub.uwaterloo.ca>
References: <2296691.2JpS0rAJbA@soho>
 <20150122114038.GE23461@hermes.click-hack.org>
 <4743020.6q5RsBy8Ia@soho> <54C0F262.6010806@siemens.com>
 <20150122144930.GL30245@csclub.uwaterloo.ca>
 <20150122145624.GF26731@hermes.click-hack.org>
 <20150122172142.GM30245@csclub.uwaterloo.ca>
 <20150122191640.GC29604@hermes.click-hack.org>
 <20150122192757.GO30245@csclub.uwaterloo.ca>
 <20150122193359.GD29604@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150122193359.GD29604@hermes.click-hack.org>
Subject: Re: [Xenomai] Xenomai-3 creating debian packages
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On Thu, Jan 22, 2015 at 08:33:59PM +0100, Gilles Chanteperdrix wrote:
> When working with the I-pipe git, there is just one tree with all
> the architecture changes in it. So, no need to apply patches. The
> trick is to not run prepare-kernel on that tree, but on another tree
> obtained with "lndir".

Yeah I am pretty sure my ipipe patch is just a git diff against the
baseline linux tag.  Xenomai still seems to be easier to use with the
prepare script.

> As for --split option of scripts/ipipe/genpatches.sh to generate a
> separate the "noarch" patch, it is kind of obsolete now, since it
> was made to help porting the I-pipe from one kernel to the next,
> when we reapplied the I-pipe patch on top of the kernel to do that.
> Since today we have adopted a "merge" workflow (which by the way
> makes things much harder for an I-pipe maintainer), we no longer
> need that option.

That makes sense.

-- 
Len Sorensen

