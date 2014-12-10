From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 10 Dec 2014 14:39:46 -0500
Message-ID: <20141210193946.GG24110@csclub.uwaterloo.ca>
References: <20141210183747.GA24110@csclub.uwaterloo.ca>
 <20141210184232.GP1524@hermes.click-hack.org>
 <20141210190240.GB24110@csclub.uwaterloo.ca>
 <20141210190509.GR1524@hermes.click-hack.org>
 <20141210190939.GD24110@csclub.uwaterloo.ca>
 <20141210191350.GT1524@hermes.click-hack.org>
 <20141210191924.GF24110@csclub.uwaterloo.ca>
 <20141210192419.GU1524@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141210192419.GU1524@hermes.click-hack.org>
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

On Wed, Dec 10, 2014 at 08:24:19PM +0100, Gilles Chanteperdrix wrote:
> A false statement again: the I-pipe tree is just one tree with the
> mainline changes merged from version to version. Granted, this is to
> recent a change to solve the issue you have, but please do not
> propagate false rumours. 

Well from my point of view it is a true statement.  I ahve never yet
found a git tree I could look at to see where the ipipe code changes
came from.  All I have ever located just has checkins of new versions
at various points in time.  I would love to actually be able to figure
this out.

There are certainly symbols in ipipe that are just EXPORT_SYMBOL.
Of course there are also some that are inconsistent such as:

./arch/arm/kernel/ipipe.c:EXPORT_SYMBOL_GPL(ipipe_test_and_stall_root);
./arch/powerpc/kernel/ipipe.c:EXPORT_SYMBOL(ipipe_test_and_stall_root);
./arch/blackfin/kernel/ipipe.c:EXPORT_SYMBOL_GPL(ipipe_test_and_stall_root);

As far as I can tell, the change to __ipipe_root_status has made it
impossible to have an ipipe enabled kernel be used for anything by a
non GPL kernel module, even if that module has never heard about ipipe
and doesn't care what so ever about ipipe.

-- 
Len Sorensen

