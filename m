Message-ID: <43E73441.9090702@domain.hid>
Date: Mon, 06 Feb 2006 12:34:25 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <b647ffbd0601311053s2f9f77c3m@domain.hid>
	<43E0BEC1.2060400@domain.hid>
In-Reply-To: <43E0BEC1.2060400@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [BUG] problems with
	adeos-ipipe-2.6.14-ppc-1.2-00.patch
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

When trying to patch with latest version of this patch, I get:

patching file include/asm-ppc/ipipe.h
Hunk #1 FAILED at 1.
Hunk #2 FAILED at 149.
Hunk #3 FAILED at 160.
Hunk #4 FAILED at 195.

Problem seems to be at line 4168 in the patch, where it says

@@ -0,1 +1,179 @@

but the old [working] patch said

@@ -0,0 +1,178 @@

Seems like the patch is created againt a not totally clean distribution.

-- 

Regards

Anders Blomdell




