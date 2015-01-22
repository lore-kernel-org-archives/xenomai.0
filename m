Date: Thu, 22 Jan 2015 20:16:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150122191640.GC29604@hermes.click-hack.org>
References: <1537147.Wm9AbiuW5D@soho> <2296691.2JpS0rAJbA@soho>
 <20150122114038.GE23461@hermes.click-hack.org>
 <4743020.6q5RsBy8Ia@soho> <54C0F262.6010806@siemens.com>
 <20150122144930.GL30245@csclub.uwaterloo.ca>
 <20150122145624.GF26731@hermes.click-hack.org>
 <20150122172142.GM30245@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150122172142.GM30245@csclub.uwaterloo.ca>
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

On Thu, Jan 22, 2015 at 12:21:43PM -0500, Lennart Sorensen wrote:
> On Thu, Jan 22, 2015 at 03:56:24PM +0100, Gilles Chanteperdrix wrote:
> > Unfortunately not, if you want to work with the I-pipe git, you can
> > not run prepare-kernel.sh in that directory anyway, otherwise you
> > could end-up commiting the Xenomai fragments with the I-pipe kernel.
> 
> I meant as far as patches going from the ipipe and xenomai git trees
> into my kernel tree for the end product.
> 
> As far as developing xenomai and ipipe, it very well might not be
> solving anything.  I don't do that, so I wouldn't know.

Then I can tell you, using one I-pipe tree and one Xenomai tree for
multiple architectures has been possible for years, this is how I
develop on Xenomai.

-- 
					    Gilles.

