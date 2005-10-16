From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17234.2952.618629.412596@domain.hid>
Date: Sun, 16 Oct 2005 10:12:56 +0200
Subject: Re: [Xenomai-core] Packaging issues - part 3
In-Reply-To: <200510161658.20513.rlenglet@domain.hid>
References: <200510161658.20513.rlenglet@domain.hid>
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
 > One more issue about packaging.
 > 
 > It is generally a bad idea to make "native" packages, i.e. to 
 > maintain the packaging files (e.g. the debian/* files) into the 
 > upstream repository.
 > Some packaging-related issues will arise, such as typos in 
 > package docs, file location issues, etc. and releasing packages 
 > that correct such issues should not require to make a new 
 > upstream release.

This looks like separated issues: fixes of the debian directory may go
in the Xenomai svn repository, and cause a debian package update without
a new upstream release. But there are maybe other issues ?

-- 


					    Gilles Chanteperdrix.

