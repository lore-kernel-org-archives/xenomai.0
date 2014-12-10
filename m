From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 10 Dec 2014 14:11:59 -0500
Message-ID: <20141210191159.GE24110@csclub.uwaterloo.ca>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Dec 10, 2014 at 02:09:39PM -0500, Lennart Sorensen wrote:
> Yes, and only becasue ipipe messes with the task structures in some way
> and the change in the export of that symbol is causing the problem.
> 
> Certainly the mainline kernel does not allow existing calls to get broken
> by other changes.  Perhaps ipipe should follow the same rule and revert
> the change to that symbol.

This was 2.6.36 ipipe:

./kernel/ipipe/core.c:EXPORT_SYMBOL(__ipipe_root_status);

But later versions changed it to:

./kernel/ipipe/core.c:EXPORT_SYMBOL_GPL(__ipipe_root_status);

and as a result anything that uses that symbol is now implicitly made
GPL only even though those calls are not GPL only.

-- 
Len Sorensen

