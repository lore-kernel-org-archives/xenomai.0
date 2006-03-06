From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-core] About the versioning scheme in the repository
Date: Mon, 6 Mar 2006 17:20:16 +0900
References: <200603061559.57932.rlenglet@domain.hid>
	<440BEE9F.2000600@domain.hid>
In-Reply-To: <440BEE9F.2000600@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603061720.16842.rlenglet@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

...
> > The current xenomai-svn package would then have version
> > 2.0.93+svn20060306 (or something like that).
>
> Adding the atomic commit number would be useful.

Good idea, that makes more sense.

...
> > So, could someone confirm that what is currently done is
> > scheme 2), i.e. the version in config/version is modified
> > just before tagging the repository and releasing?
>
> There is no current scheme for managing the version file; it's
> updated when I happen to think about bumping the version
> number. I could enforce 2) from now on though, and only change
> the version stamp just before a release.

That would be nice, thanks!

-- 
Romain LENGLET

