Message-ID: <4FFEF029.1090901@antcom.de>
Date: Thu, 12 Jul 2012 17:41:29 +0200
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
References: <4FFC89CA.70809@xenomai.org> <4FFDA171.3010201@nta-inc.net>
	<4FFDAF59.9010000@xenomai.org>
	<20120711174844.GG19565@csclub.uwaterloo.ca>
	<4FFE1841.1070409@xenomai.org> <4FFE8B7C.6090101@antcom.de>
	<4FFE9477.5070002@xenomai.org> <4FFEE9E8.2040008@nta-inc.net>
In-Reply-To: <4FFEE9E8.2040008@nta-inc.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Debian packaging bug in Xenomai v2.6.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <jeff.webb@nta-inc.net>
Cc: xenomai@xenomai.org

On 07/12/2012 05:14 PM, Jeff Webb wrote:
>>> I unfortunately don't have the ressources to regularly sync/update
>>> debian/* in the xenomai.org dev repository.
> 
> Do you have the resources to update debian/* on xenomai.org just before
> each release is made?  I don't think it's necessary to update it any
> more often than that.  I'm assuming that you eventually package each
> release anyway, so it would be nice to do it before a release is made
> official.  Of course, if you don't have time for that or your
> availability doesn't line up with the timeframe for a release, that is
> understandable.  I am just asking if the problem is trying to keep the
> git repository up to date all the time, or if you don't even have time
> to do it for each release.

It would be possible for me if I get ~2 weeks notice before a Xenomai
release to already do _before_ the Xenomai release what I would normally
do _afterwards_ anyway (for Debian). Gilles, is this possible?

But keep in mind that from time to time Debian does intermitted
revisions and it would be necessary to synchronize with xenomai.org.
Much duplicated work that I would like to prevent.

Looks like this feature is more popular than I was thinking, so I'll try
my best.

BTW: There is the patch tracker at

	http://packages.qa.debian.org/x/xenomai.html

(see down on the right)

which could be used for automating or helping with sync with incremental
Debian revisions?

Gilles? Philippe?

> I find it useful, and have not had any trouble with it not working
> before.  That being said, I wouldn't object to getting the debian
> directory from another location, as long as the information at:
> 
>  http://www.xenomai.org/index.php/Building_Debian_packages
> 
> is updated with detailed instructions on exactly how to download,
> extract, and graft the appropriate debian directory into a xenomai
> source tree that was created from a release tarball or git repository.

I remember having updated one of those pages, but the current version
quite deviated. Hope everything works fine?

Thanks,

Roland

