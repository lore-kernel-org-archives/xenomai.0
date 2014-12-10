From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 10 Dec 2014 14:02:40 -0500
Message-ID: <20141210190240.GB24110@csclub.uwaterloo.ca>
References: <20141210183747.GA24110@csclub.uwaterloo.ca>
 <20141210184232.GP1524@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141210184232.GP1524@hermes.click-hack.org>
Subject: Re: [Xenomai] __ipipe_root_status exported GPL only but used to be
 not GPL only and is breaking other code
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Dec 10, 2014 at 07:42:32PM +0100, Gilles Chanteperdrix wrote:
> On Wed, Dec 10, 2014 at 01:37:47PM -0500, Lennart Sorensen wrote:
> > I just encountered an issue compiling an external kernel module which
> > compiled fine with 3.0 kernel but with new kernels I get a linker error
> > about __ipipe_root_status
> > 
> > This used to be just EXPORT_SYMBOL, but not is EXPORT_SYMBOL_GPL which
> > breaks the compile.  I am pretty sure module does not call anything in
> > the kernel flagged EXPORT_SYMBOL_GPL, so it must be something ipipe
> > gets involved with somehow that is making it fail.  I haven't traced
> > down exactly how it is happening yet.
> > 
> > Is there any reason this symbol export was changed in newer versions?
> 
> Xenomai does not support modules with non GPL license.

Well it used to.  Or rather it used to not break the rest of the kernel
from supporting it.

Unfurtunately T1/E1 management software does not exist in free software
versions.

-- 
Len Sorensen

