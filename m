MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18443.30645.189628.665469@domain.hid>
Date: Sun, 20 Apr 2008 19:04:53 +0200
In-Reply-To: <480A4AF3.9010502@domain.hid>
References: <480A4AF3.9010502@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Debian package xenomai-2.4.3-4 available
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roland Stigge <stigge@domain.hid>
Cc: xenomai@xenomai.org

Roland Stigge wrote:
 > [Warning: First in a series of several issues applicable to
 > xenomai.org's code.]
 > 
 > Hi,
 > 
 > at http://packages.qa.debian.org/x/xenomai.html, you can find the latest
 > version of Debian's package "xenomai". The "diff" to xenomai 2.4.3
 > applies to the normal Xenomai distribution with an empty debian/ directory.
 > 
 > Feel free to synchronize the Debian changes back to the mainline Xenomai
 > repository, especially the Debian packaging has been fixed.

Hi Roland,

reading your mail, I realize that the patch to remove the few "bashisms"
in xenomai scripts was forgotten. So, since nobody complained, I will
apply it now, so that you will not have to replace /bin/sh with
/bin/bash in the next release.

Thanks for your work.

-- 


					    Gilles.

