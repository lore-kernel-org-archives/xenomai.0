Message-ID: <47E4196F.2070303@domain.hid>
Date: Fri, 21 Mar 2008 21:24:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9270C81F1EE463A17D96967D"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [Fwd: Bug#471871: xenomai-runtime: bashism in
	/bin/sh script]
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9270C81F1EE463A17D96967D
Content-Type: multipart/mixed;
 boundary="------------080704020708030407030607"

This is a multi-part message in MIME format.
--------------080704020708030407030607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Maybe someone with idle cycles left could have a look at this.

Jan

--------------080704020708030407030607
Content-Type: message/rfc822;
 name="Bug#471871: xenomai-runtime: bashism in /bin/sh script.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="Bug#471871: xenomai-runtime: bashism in /bin/sh script.eml"

Received: from [70.103.162.29] (helo=master.debian.org)
	by mx18.web.de with esmtp (WEB.DE 4.109 #226)
	id 1JcRKc-0004fy-00
	for jan.kiszka@domain.hid; Thu, 20 Mar 2008 21:25:46 +0100
Received: from qa by master.debian.org with local (Exim 4.50)
	id 1JcRKb-0002iN-Ob
	for jan.kiszka@domain.hid; Thu, 20 Mar 2008 20:25:45 +0000
Received: from rietz.debian.org ([140.211.166.43]) by master.debian.org
 with esmtp (Exim 4.50) id 1JcQg7-0005mj-Kn for
 xenomai@domain.hid; Thu, 20 Mar 2008 19:43:55 +0000
Received: from debbugs by rietz.debian.org with local (Exim 4.63)
 (envelope-from <debbugs@domain.hid>) id 1JcQeY-0003wc-QM;
 Thu, 20 Mar 2008 19:42:19 +0000
X-Loop: owner@domain.hid
Subject: Bug#471871: xenomai-runtime: bashism in /bin/sh script
Reply-To: Raphael Geissert <atomo64@domain.hid>,
 471871-maintonly@domain.hid
Resent-From: Raphael Geissert <atomo64@domain.hid>
Resent-To: Roland Stigge <stigge@domain.hid>
Resent-Date: Thu, 20 Mar 2008 19:42:14 +0000
Resent-Message-Id: <handler.471871.M.120604199410970@domain.hid>
X-Debian-PR-Message: report 471871
X-Debian-PR-Package: xenomai-runtime
X-Debian-PR-Keywords: 
X-Debian-PR-Source: xenomai
Received: via spool by maintonly@domain.hid id=M.120604199410970
 (code M ref -1); Thu, 20 Mar 2008 19:42:14 +0000
Received: (at maintonly) by bugs.debian.org; 20 Mar 2008 19:39:54 +0000
X-Spam-Checker-Version: SpamAssassin 3.1.4-bugs.debian.org_2005_01_02
 (2006-07-26) on rietz.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=4.0 tests=BAYES_00,FOURLA,HAS_PACKAGE,
 X_DEBBUGS_NO_ACK autolearn=no version=3.1.4-bugs.debian.org_2005_01_02
Received: from hs-out-0708.google.com ([64.233.178.249]) by
 rietz.debian.org with esmtp (Exim 4.63) (envelope-from
 <atomo64@domain.hid>) id 1JcQcD-0002qk-QF for maintonly@domain.hid;
 Thu, 20 Mar 2008 19:39:53 +0000
Received: by hs-out-0708.google.com with SMTP id z77so1073758hsz.9 for
 <maintonly@domain.hid>; Thu, 20 Mar 2008 12:39:53 -0700 (PDT)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=beta;
 h=domainkey-signature:received:received:from:to:subject:user-agent:x-debbugs-no-ack:mime-version:content-disposition:date:content-type:content-transfer-encoding:message-id;
 bh=PUm64xSrZS+k3m7HWKHp3hT9wPSLuKeOdoejstTnhE4=; b=m9+01ezZRIM9XaAGg19ucysqGafX4Rl9otsNvCcUD2SIiEXrQGdf62nGV5WpZ5XldoUE3PaQt7Bf6BgbqI07O1oVvRqEtoWMmJRdmijpRFuyNqiy2KO+Xbc8gswuJqSKhgQBXDMRRyVSYX63/fMRcY2CFMxc6AFJ9vmjLg8/998=
Domainkey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=beta;
 h=from:to:subject:user-agent:x-debbugs-no-ack:mime-version:content-disposition:date:content-type:content-transfer-encoding:message-id;
 b=K4SoYDH/FsYkt0wGUC14/6+0SoiVHJ+QsEdqaa+HfMyWfMRscj+lCrDYLO0kFncAxjrYWR8iLmww8D5/N4p0WdMK+NOdiPLxDZ87/QWaUt8Ld7HvbPLb0VUhelGQyp2dIrOUDyo3AZPQ8CUKo7AYcuB6062y4IzfA/StaSHtM1I=
Received: by 10.100.41.9 with SMTP id o9mr6488007ano.42.1206041992913;
 Thu, 20 Mar 2008 12:39:52 -0700 (PDT)
Received: from nova.local ( [200.66.22.50]) by mx.google.com with ESMTPS
 id c39sm3612694anc.25.2008.03.20.12.39.51 (version=TLSv1/SSLv3
 cipher=OTHER); Thu, 20 Mar 2008 12:39:51 -0700 (PDT)
From: Raphael Geissert <atomo64@domain.hid>
To: maintonly@domain.hid
User-Agent: KMail/1.9.7
MIME-Version: 1.0
Content-Disposition: inline
Date: Thu, 20 Mar 2008 13:39:38 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200803201339.41302.atomo64@domain.hid>
Delivered-To: maintonly@domain.hid
Resent-Sender: Debian BTS <debbugs@domain.hid>
Resent-Date: Thu, 20 Mar 2008 19:42:18 +0000
Delivered-To: xenomai@domain.hid
Precedence: list
X-Loop: xenomai@domain.hid
X-PTS-Package: xenomai
X-PTS-Keyword: bts
List-Unsubscribe: <mailto:pts@domain.hid>
Sender: bounces+20080320-jan.kiszka=web.de@domain.hid

Package: xenomai-runtime
Severity: important
Version: 2.4.2-2
User: debian-release@domain.hid
Usertags: goal-dash

Hello maintainer,

While performing an archive wide checkbashisms (from the 'devscripts' package) 
check I've found your package containing several /bin/sh scripts making 
use of a bashism.

checkbashisms' output:
> possible bashism in ./usr/bin/xeno-load line 130 (should be >word 2>&1):
>        $sudo kill -SIGINT $children_pids >& /dev/null
> possible bashism in ./usr/bin/xeno-info line 77 (brace expansion):
> ls -l /usr/lib/lib{g,stdc}++.so  2>/dev/null | awk -F. \
> possible bashism in ./usr/bin/xeno-test line 63 (local foo=bar):
>   local neededApplets="awk basename cut date dd dirname egrep grep head
> possible bashism in ./usr/bin/xeno-test line 65 (local foo=bar):
>   local foundAll=1
> possible bashism in ./usr/bin/xeno-test line 81 (local foo=bar):
>   local foundAll=1
> possible bashism in ./usr/bin/xeno-test line 114 (local foo=bar):
>     local jobsct=$1;
> possible bashism in ./usr/bin/xeno-test line 123 (cnt=$((cnt + 1)) does not
> work in dash): jobsct=$((jobsct-1));
> possible bashism in ./usr/bin/xeno-test line 162 (local foo=bar):
>     local filter=" grep -E '$whatconf'"
> possible bashism in ./usr/bin/xeno-test line 277 (local foo=bar):
>     local file=$1
> possible bashism in ./usr/bin/xeno-test line 382 (should be 'b = a'):
>     if test "$res" == "0" ; then

Not using bash as /bin/sh is likely to lead to errors or unexpected 
behaviours. 
Please be aware that although 
bash is currently the default /bin/sh there's a release goal for Lenny to 
make dash the default /bin/sh[1].

If you want more information about dash as /bin/sh, you can read:
http://lists.debian.org/debian-release/2008/01/msg00189.html
https://wiki.ubuntu.com/DashAsBinSh

For more information please refer to the Debian Policy section 10.4 supporting 
this argument at:
http://www.debian.org/doc/debian-policy/ch-files.html#s-scripts

HINT: sometimes these bugs are already fixed in Ubuntu, look at the PTS

[1]http://release.debian.org/lenny/goals.txt

Thank you,
-- 
Atomo64 - Raphael

Please avoid sending me Word, PowerPoint or Excel attachments.
See http://www.gnu.org/philosophy/no-word-attachments.html




--------------080704020708030407030607--

--------------enig9270C81F1EE463A17D96967D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFH5BlvniDOoMHTA+kRAh0kAJ4hD8+6hdGWPPOmOlnJaEvjIaamaQCcCpQK
SCHuzygCGGmqeL1KK7DbRx8=
=8FDW
-----END PGP SIGNATURE-----

--------------enig9270C81F1EE463A17D96967D--

