MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17557.24320.717387.489268@domain.hid>
Date: Sun, 18 Jun 2006 16:11:12 +0200
Subject: Re: [Xenomai-core] Some new test cases for the vxWorks skin
In-Reply-To: <200606151340.55710.niklaus.giger@domain.hid>
References: <200606122058.18019.niklaus.giger@domain.hid>
	<17552.3527.468486.973862@domain.hid>
	<200606151340.55710.niklaus.giger@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

Niklaus Giger wrote:
 > Hi
 > 
 > Here the reworked patch.

Ok, most of your patch is applied, I changed vxworks msgQLib so that it
behave like vxworks. The only thing I did not apply is :

Index: sim/skins/vxworks/testsuite/t010726-2.c
===================================================================
--- sim/skins/vxworks/testsuite/t010726-2.c	(Revision 1206)
+++ sim/skins/vxworks/testsuite/t010726-2.c	(Arbeitskopie)
@@ -219,10 +340,10 @@
                         SEQ("Peer",2),
                         SEQ("root",8),
                         SEQ("Peer",14),
-                        SEQ("root",1),
+                        SEQ("root",6),
                         END_SEQ);


The count is 2 here.

-- 


					    Gilles Chanteperdrix.

