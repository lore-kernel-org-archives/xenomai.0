From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17283.40272.808573.538923@domain.hid>
Date: Tue, 22 Nov 2005 23:36:00 +0100
Subject: [Xenomai-core] On-line documentation tree layout change.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, xenomai@xenomai.org


Hi,

in order to cope with the various branches and versions, the on-line
documentation, accessible on GNA download area, now follows the same
layout as svn repository.

Documentation for trunk is accessible at:
http://download.gna.org/xenomai/documentation/trunk/

Documentation for the 2.0.x branch is accessible at:
http://download.gna.org/xenomai/documentation/branches/v2.0.x

Documentation for the 2.0.1 version is accessible at:
http://download.gna.org/xenomai/documentation/tags/v2.0.1


As noticed by Ignacio, doxygen documentation search function may not be
used on GNA download area. This issue will be solved when the
documentation is put on Xenomai web site. In the meantime, it is
possible to extract documentation from subversion repository and put it
on any machine running an apache server, by using the extract-doc
script, available at:

svn://svn.gna.org/svn/xenomai/trunk/scripts/maint/extract-doc

-- 


					    Gilles Chanteperdrix.

