Message-ID: <475957B3.80507@domain.hid>
Date: Fri, 07 Dec 2007 09:24:51 -0500
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] SVN issue
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

I'm trying to checkout a new xenomai tree using svn, but I get:

saf$ svn co svn://svn.gna.org/svn/xenomai/trunk xenomai
svn: Malformed network data

If instead I do:

saf$ svn co http://svn.gna.org/svn/xenomai/trunk xenomai

then it works.  So something seems broken with the svn protocol.  Has
something changed on the server, or is the problem on my end?

    Steve


