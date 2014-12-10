From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 10 Dec 2014 14:52:36 -0500
Message-ID: <20141210195236.GI24110@csclub.uwaterloo.ca>
References: <20141210183747.GA24110@csclub.uwaterloo.ca>
 <20141210184232.GP1524@hermes.click-hack.org>
 <20141210190240.GB24110@csclub.uwaterloo.ca>
 <20141210190509.GR1524@hermes.click-hack.org>
 <20141210190939.GD24110@csclub.uwaterloo.ca>
 <20141210191350.GT1524@hermes.click-hack.org>
 <20141210191924.GF24110@csclub.uwaterloo.ca>
 <20141210194458.GV1524@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141210194458.GV1524@hermes.click-hack.org>
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

On Wed, Dec 10, 2014 at 08:44:58PM +0100, Gilles Chanteperdrix wrote:
> And by the way, you are not "reverting a change". The I-pipe
> starting with the version for Linux 3.2 was rewritten from scratch
> and called "I-pipe core", did not you see the file names changing ?
> So, what you have may simply have been a mistake. Or maybe not. 

I never realized changing ipipe to ipipe core was a huge change, and
certainly never noticed it was a rewrite.  It seemed to work about the
same with xenomai.

> And if you want to talk about stupid, using proprietary modules in
> products based on Xenomai you redistribute is really stupidly
> dangerous, both technically and legally.

Well to manage T1/E1 ports that was what existed.

I don't see a technical problem, we have the sources and are compiling
from source.  The modules build and work fine on the kernel without ipipe,
so clearly it isn't using any part of ipipe.

Legally has been a long time debate by many people.

Fortunately our new product does not have T1/E1 ports so that mess is
not a problem there, but existing products do have them.

-- 
Len Sorensen

