From: Romain Lenglet <rlenglet@domain.hid>
Date: Sun, 16 Oct 2005 16:58:20 +0900
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510161658.20513.rlenglet@domain.hid>
Subject: [Xenomai-core] Packaging issues - part 3
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

One more issue about packaging.

It is generally a bad idea to make "native" packages, i.e. to 
maintain the packaging files (e.g. the debian/* files) into the 
upstream repository.
Some packaging-related issues will arise, such as typos in 
package docs, file location issues, etc. and releasing packages 
that correct such issues should not require to make a new 
upstream release.
I therefore propose to make one separate repository for the 
packaging, for every distribution, and to have separate bug 
trackers (although Debian already has its own bug tracker for 
Debian packages), etc.


OK, that's all for the weekend...

-- 
Romain Lenglet

