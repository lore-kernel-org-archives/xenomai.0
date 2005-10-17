From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17235.61949.261241.654277@domain.hid>
Date: Mon, 17 Oct 2005 20:48:29 +0200
Subject: Re: [Xenomai-core] Packaging issues - part 3
In-Reply-To: <200510162325.03410.rlenglet@domain.hid>
References: <200510161658.20513.rlenglet@domain.hid>
	<17234.2952.618629.412596@domain.hid>
	<200510162325.03410.rlenglet@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Romain Lenglet <rlenglet@domain.hid>
Cc: xenomai@xenomai.org

Romain Lenglet wrote:
 > > This looks like separated issues: fixes of the debian
 > > directory may go in the Xenomai svn repository, and cause a
 > > debian package update without a new upstream release. But
 > > there are maybe other issues ?
 > 
 > Alright, but we should be able to make changes in both the 
 > Xenomai code and the Debian files, independently.
 > If a package has been released, then if we want to release a new 
 > revision of the package that corrects Debian-only issues, then 
 > we must be able to ignore any modification in the repository 
 > that do not concern the Debian files, to create the new package.
 > 
 > We can do that with either separate repositories, or branches in 
 > svn.

Handling a separate branch mean seems a lot of maintenance, whereas
updates of the debian packaging system would go in the debian directory
(I mean, except manapges ;-), and work on the trunk would never change
the debian directory. 

Maybe a lighter solution would be to maintain the debian directory at
another place in the repository, for example in packages/debian, and to
make it appear in trunk using the subversion svn:external attribute.
This way the debian directory would appear in all the releases of
xenomai.

-- 


					    Gilles Chanteperdrix.

