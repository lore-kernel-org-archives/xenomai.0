Message-ID: <4483EA60.3030702@domain.hid>
Date: Mon, 05 Jun 2006 10:25:04 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Blackfin upgrade notification
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: adeos-main@gna.org
Cc: xenomai@xenomai.org, xenomai@xenomai.org


This is a note to the Xenomai and/or Adeos users over the Blackfin 
architecture. A very annoying issue (aka brown-paperbag bug) has just 
been fixed in the Adeos/blackfin support, which basically made all POSIX 
timing services inaccurate. Upgrading to the newest patch is strongly 
recommended.

The following patch is based on the 2.6.16 kernel shipped with the 
latest uClinux for Blackfin release R2006R1-RC2:
http://download.gna.org/adeos/patches/v2.6/blackfin/adeos-ipipe-R06R1RC2-bf53x-1.4-03.patch

This one is based on the CVS head from 
cvs.blackfin.uclinux.org:/cvsroot/uclinux533, as of yesterday:
http://download.gna.org/adeos/patches/v2.6/blackfin/adeos-ipipe-cvs-20060604-bf53x-1.4-03.patch

Both patches work for the bf533 and bf537 boards. Those patches have 
also been committed to the v2.1.x and trunk SVN branches of the Xenomai 
project.

-- 

Philippe.

