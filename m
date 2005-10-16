From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-core] Packaging issues - part 3
Date: Sun, 16 Oct 2005 23:25:03 +0900
References: <200510161658.20513.rlenglet@domain.hid>
	<17234.2952.618629.412596@domain.hid>
In-Reply-To: <17234.2952.618629.412596@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510162325.03410.rlenglet@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

> This looks like separated issues: fixes of the debian
> directory may go in the Xenomai svn repository, and cause a
> debian package update without a new upstream release. But
> there are maybe other issues ?

Alright, but we should be able to make changes in both the 
Xenomai code and the Debian files, independently.
If a package has been released, then if we want to release a new 
revision of the package that corrects Debian-only issues, then 
we must be able to ignore any modification in the repository 
that do not concern the Debian files, to create the new package.

We can do that with either separate repositories, or branches in 
svn.

-- 
Romain Lenglet

