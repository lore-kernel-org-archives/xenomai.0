Message-ID: <440BEE9F.2000600@domain.hid>
Date: Mon, 06 Mar 2006 09:11:11 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] About the versioning scheme in the repository
References: <200603061559.57932.rlenglet@domain.hid>
In-Reply-To: <200603061559.57932.rlenglet@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
> Hi,
> 
> When is the version number changed in the config/version file?
> Is that value the version 1) of the next release being prepared, 
> or 2) of the last release?
> 
> This is a concern for packaging. I would like to make two series 
> of Debian packages: xenomai, libxenomai, etc. for the official 
> releases, and xenomai-svn, libxenomai-svn, etc. for periodical 
> extracts from the svn repository after releases.
> The problem is: what versions to give to the *-svn packages? For 
> instance, the current value in config/version is 2.0.93.
> The current xenomai-svn package would then have version 
> 2.0.93+svn20060306 (or something like that).

Adding the atomic commit number would be useful.

> 
> Using versioning scheme 1), the next xenomai package would have 
> version 2.0.93.

2.0.94, or 2.1.0 actually.

  This is bad, because the xenomai-svn could not
> be replaced by the next xenomai package:
> 2.0.93 < 2.0.93+svn20060306.
> Even if xenomai (official release package) is more recent.
> 
> Using versioning scheme 2) works, because the next xenomai 
> package would have version 2.0.94 (or 2.1 or...), and hence 
> would have priority over the older xenomai-svn packages.
> 
> 
> So, could someone confirm that what is currently done is scheme 
> 2), i.e. the version in config/version is modified just before 
> tagging the repository and releasing?
> 

There is no current scheme for managing the version file; it's updated when I 
happen to think about bumping the version number. I could enforce 2) from now on 
though, and only change the version stamp just before a release.

-- 

Philippe.

