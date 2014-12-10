Date: Wed, 10 Dec 2014 20:13:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141210191350.GT1524@hermes.click-hack.org>
References: <20141210183747.GA24110@csclub.uwaterloo.ca>
 <20141210184232.GP1524@hermes.click-hack.org>
 <20141210190240.GB24110@csclub.uwaterloo.ca>
 <20141210190509.GR1524@hermes.click-hack.org>
 <20141210190939.GD24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141210190939.GD24110@csclub.uwaterloo.ca>
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
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Wed, Dec 10, 2014 at 02:09:39PM -0500, Lennart Sorensen wrote:
> On Wed, Dec 10, 2014 at 08:05:09PM +0100, Gilles Chanteperdrix wrote:
> > Ah, you mean the problem is with a module which does not use Xenomai
> > ? That is unfortunate.
> 
> Yes, and only becasue ipipe messes with the task structures in some way
> and the change in the export of that symbol is causing the problem.
> 
> Certainly the mainline kernel does not allow existing calls to get broken
> by other changes.

This is true in user space. Not for kernel modules, see:
https://git.xenomai.org/ipipe.git/tree/Documentation/stable_api_nonsense.txt?h=ipipe-3.14

-- 
					    Gilles.

