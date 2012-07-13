From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
Date: Fri, 13 Jul 2012 13:21:52 +0200
References: <4FFC89CA.70809@xenomai.org> <4FFEF029.1090901@antcom.de>
	<4FFEF20D.6030709@xenomai.org>
In-Reply-To: <4FFEF20D.6030709@xenomai.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201207131321.53227.leo@alaxarxa.net>
Subject: Re: [Xenomai] Debian packaging bug in Xenomai v2.6.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

A Dijous 12 Juliol 2012, Gilles Chanteperdrix va escriure:
> On 07/12/2012 05:41 PM, Roland Stigge wrote:
> > On 07/12/2012 05:14 PM, Jeff Webb wrote:
> >>>> I unfortunately don't have the ressources to regularly sync/update
> >>>> debian/* in the xenomai.org dev repository.
> >>
> >> Do you have the resources to update debian/* on xenomai.org just before
> >> each release is made?  I don't think it's necessary to update it any
> >> more often than that.  I'm assuming that you eventually package each
> >> release anyway, so it would be nice to do it before a release is made
> >> official.  Of course, if you don't have time for that or your
> >> availability doesn't line up with the timeframe for a release, that is
> >> understandable.  I am just asking if the problem is trying to keep the
> >> git repository up to date all the time, or if you don't even have time
> >> to do it for each release.
> > 
> > It would be possible for me if I get ~2 weeks notice before a Xenomai
> > release to already do _before_ the Xenomai release what I would normally
> > do _afterwards_ anyway (for Debian). Gilles, is this possible?
> 
> Yes, it is possible, of course.
> 
> Next question: the current debian directory is (I believe), compatible
> with Debian stable. The rationale being that it allows people to install
> the latest xenomai revision on Debian stable.
> 
> Is this "feature" useful, or simply something that nobody does (I feel
> few people are using Debian stable these days)?
> 

well, I'm now trying to compile 2.6.1 in a Debian stable. Now there's another 
bug, in the package of the patches (linux-patch-xenomai_2.6.1_all.deb). The 
rules script call to prepare-patch.sh, and this script has this line:

find $xenomai_root/ksrc/ -name "adeos-ipipe-2.6.*-$supported_arch-*.patch"

that changed to 

find $xenomai_root/ksrc/ -name "*ipipe*$supported_arch-*.patch" |

make the package filled with all patches. However, I don't know the pre patch 
i post patch question, and how will be affected in the debian package.

About the Gilles question did .... YES!!! it's useful. I'm maintaining a group 
of boxes with stable and I would like to use the latest version of xenomai. 

And, not a few people are using Debian stable ....


-- 
--
Linux User 152692
Catalonia

