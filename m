From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17477.7886.244387.688290@domain.hid>
Date: Tue, 18 Apr 2006 19:15:58 +0200
Subject: Re: [Xenomai-core] [RFC] collecting xenomai statistics
In-Reply-To: <44444AB2.9020305@domain.hid>
References: <200604171047.51730.niklaus.giger@domain.hid>
	<44444AB2.9020305@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jim Cromie wrote:
 > perhaps as a 4th number on the version, that way xeno-config can stay as is.
 > 
 > [root@domain.hid bin]# ./xeno-config --version
 > 2.1.50
 > Id like instead:
 > 2.1.50.941
 > 
 > This seems better than pokinh around a filesystem, looking for the 
 > xenomai svn
 > (which may be on the build-host, not the run-host)

If you want to change the version returned by xeno-config, simply modify
config/version and re-run scripts/bootstrap before building Xenomai.

-- 


					    Gilles Chanteperdrix.

