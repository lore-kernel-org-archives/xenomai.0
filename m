From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 28 Nov 2014 11:44:39 -0500
Message-ID: <20141128164439.GB24110@csclub.uwaterloo.ca>
References: <5478430B.9030602@siemens.com> <20141128095038.GA3832@hermes>
 <547846AC.6070204@siemens.com> <20141128101605.GC3832@hermes>
 <208C6975C932E94F86239FEA59CCA632DCD4A13E@AUSMXMBX02.mrws.biz>
 <20141128124348.GF6395@hermes>
 <20141128161818.GU24110@csclub.uwaterloo.ca>
 <20141128162423.GJ8051@hermes>
 <20141128162919.GZ24110@csclub.uwaterloo.ca>
 <20141128163503.GL8051@hermes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141128163503.GL8051@hermes>
Subject: Re: [Xenomai] [pull] forge: Adjust default registry mount point
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

On Fri, Nov 28, 2014 at 05:35:03PM +0100, Gilles Chanteperdrix wrote:
> It would be handy if the runtime package was built correctly, but
> since you were the first one to use the word "shitty", if there one
> thing shitty it is Debian's debian/rules. This file has essentially
> been unmaintained for years, just modified enough to compile the
> next version, without taking the release notes into account, and
> removing options or compilation flags that were no longer useful.
> The method to provide patches for the kernel has disappeared from
> make-kpkg around Lenny or something. But since no user was paying
> attention, nobody noticed.

Well the debian rules in the xenomai git tree seem pretty decent these
days at least in the xenomai-2.6 tree.  The addition of the -dbg package
generation a few months ago was so nice.

> No, really, stay away from Debian's xenomai packages.

The one actually in Debian, yeah it's not much use anymore.  I have
stopped looking for help from that one.

-- 
Len Sorensen

