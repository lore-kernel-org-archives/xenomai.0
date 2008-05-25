MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18489.35854.502315.832894@domain.hid>
Date: Sun, 25 May 2008 17:55:58 +0200
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

I am trying to merge the debian changes back into Xenomai, however, I
have two problems:
- I can not find back the 2.4.3-4 patch, I only find 2.4.3-7;
- I do not want to merge changes that replace /bin/sh with /bin/bash
  since we fixed the bashism the right way (it is important for people
  of the embedded world, that Xenomai does not require /bin/bash, since
  embedded boxes may use other shells);
- I do not want to include the manual pages in the debian/
  sub-directory since I merged your patch adding manual pages to the
  proper place.

So, could you re-generate a patch using Xenomai v2.4.x branch fixing
these two issues ? I promise, this time I will not wait one month before
merging the changes.

Thanks in advance.

-- 


					    Gilles.

