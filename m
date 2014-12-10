From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 10 Dec 2014 14:04:21 -0500
Message-ID: <20141210190421.GC24110@csclub.uwaterloo.ca>
References: <20141210183747.GA24110@csclub.uwaterloo.ca>
 <20141210184232.GP1524@hermes.click-hack.org>
 <20141210190240.GB24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141210190240.GB24110@csclub.uwaterloo.ca>
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

On Wed, Dec 10, 2014 at 02:02:40PM -0500, Lennart Sorensen wrote:
> Well it used to.  Or rather it used to not break the rest of the kernel
> from supporting it.
> 
> Unfurtunately T1/E1 management software does not exist in free software
> versions.

All the module is trying to do is strat a kthread and then later find
it to kill it, and it seems having ipipe makes that no longer possible.
I would call that a wrong change in ipipe.

-- 
Len Sorensen

