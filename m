From: Wolfgang Denk <wd@domain.hid>
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
Date: Mon, 02 Aug 2010 16:27:02 +0200
Message-Id: <20100802142702.2554C11D922@domain.hid>
Subject: [Xenomai-core] Misleading git tags
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Dear Gilles,

I noticed that "git describe" does not provide helpful information for
the Xenomai repository.

For the current code (tagged as v2.5.4) I still get:

	-> git describe
	v2.5.1-349-gf8fa381

Only with the "--tags" option I get the expected result:

	-> git describe --tags
	v2.5.4

The behaviour changes from version to version:

	-> git describe v2.5.0
	fatal: No annotated tags can describe 'fddf7831dc53cce70b7196314cbd0b3aec028350'.
	However, there were unannotated tags: try --tags.
	-> git describe v2.5.1
	v2.5.1
	-> git describe v2.5.2
	v2.5.1-142-g6b3e8f2
	-> git describe v2.5.3
	v2.5.1-232-g55bf2d3
	-> git describe v2.5.4
	v2.5.1-349-gf8fa381


My recommendation is to always annotate release tags to avoid such
confusion.  Thanks.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
NOTE: The  Most  Fundamental  Particles  in  This  Product  Are  Held
Together  by  a  "Gluing" Force About Which Little is Currently Known
and Whose Adhesive Power Can Therefore Not Be Permanently Guaranteed.

