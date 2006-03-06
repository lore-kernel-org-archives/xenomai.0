From: Romain Lenglet <rlenglet@domain.hid>
Date: Mon, 6 Mar 2006 15:59:57 +0900
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603061559.57932.rlenglet@domain.hid>
Subject: [Xenomai-core] About the versioning scheme in the repository
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

Hi,

When is the version number changed in the config/version file?
Is that value the version 1) of the next release being prepared, 
or 2) of the last release?

This is a concern for packaging. I would like to make two series 
of Debian packages: xenomai, libxenomai, etc. for the official 
releases, and xenomai-svn, libxenomai-svn, etc. for periodical 
extracts from the svn repository after releases.
The problem is: what versions to give to the *-svn packages? For 
instance, the current value in config/version is 2.0.93.
The current xenomai-svn package would then have version 
2.0.93+svn20060306 (or something like that).

Using versioning scheme 1), the next xenomai package would have 
version 2.0.93. This is bad, because the xenomai-svn could not 
be replaced by the next xenomai package:
2.0.93 < 2.0.93+svn20060306.
Even if xenomai (official release package) is more recent.

Using versioning scheme 2) works, because the next xenomai 
package would have version 2.0.94 (or 2.1 or...), and hence 
would have priority over the older xenomai-svn packages.


So, could someone confirm that what is currently done is scheme 
2), i.e. the version in config/version is modified just before 
tagging the repository and releasing?

-- 
Romain LENGLET

