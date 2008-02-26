Message-ID: <47C3D73E.9010804@domain.hid>
Date: Tue, 26 Feb 2008 10:09:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030305090808000602070409"
Subject: [Xenomai-help] [Fwd: [Xenomai-core] Xenomai in Debian]
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------030305090808000602070409
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Deserves to be noticed here as well.

--------------030305090808000602070409
Content-Type: message/rfc822;
 name="[Xenomai-core] Xenomai in Debian.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[Xenomai-core] Xenomai in Debian.eml"

Return-Path: <xenomai-core-bounces@domain.hid>
Received: from mail6240.rrzn.uni-hannover.de ([unix socket])
	 by mail6240 (Cyrus v2.3.8) with LMTPA;
	 Tue, 26 Feb 2008 09:31:04 +0100
X-Sieve: CMU Sieve 2.3
Received: from mrelay9.uni-hannover.de (mrelay9.uni-hannover.de [130.75.2.109])
	by mail6240.rrzn.uni-hannover.de (8.14.1/8.14.1) with ESMTP id m1Q8V31T025937
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <kiszka@domain.hid>; Tue, 26 Feb 2008 09:31:03 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mrelay9.uni-hannover.de (8.13.8/8.13.8) with ESMTP id m1Q8V390008505
	for <kiszka@domain.hid>; Tue, 26 Feb 2008 09:31:03 +0100
	(envelope-from xenomai-core-bounces@domain.hid)
Received: from mrelay9.uni-hannover.de
	by mrelay9 with queue (Sophos PureMessage Version 5.401) id 21395370-3
	for kiszka@domain.hid; Tue, 26 Feb 2008 08:26:41 GMT
Received: from www.gna.org [88.191.250.45]
	by mrelay9.uni-hannover.de with SMTP id m1Q8QaD7000939;
	Tue, 26 Feb 2008 08:26:41 GMT
	(envelope-from xenomai-core-bounces@domain.hid)
Received: from localhost ([127.0.0.1] helo=bart.gna.org)
	by gna.org with esmtp (Exim 4.63)
	(envelope-from <xenomai-core-bounces@domain.hid>)
	id 1JTv7E-00005j-AV; Tue, 26 Feb 2008 09:24:44 +0100
Received: from Debian-exim by gna.org with spam-scanned (Exim 4.63)
	(envelope-from <stigge@domain.hid>) id 1JTv77-0008Vi-7f
	for xenomai@xenomai.org; Tue, 26 Feb 2008 09:24:42 +0100
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on mail.gna.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.3 tests=BAYES_00 autolearn=ham 
	version=3.1.7-deb
Received: from mx2.shadow.prohost.de ([64.33.63.70] helo=shadow.prohost.de)
	by gna.org with esmtp (Exim 4.63) (envelope-from <stigge@domain.hid>)
	id 1JTv76-0008VU-UM
	for xenomai@xenomai.org; Tue, 26 Feb 2008 09:24:37 +0100
Received: from dent (localhost [127.0.0.1]) (authenticated bits=0)
	by shadow.prohost.de (8.13.8/8.13.8) with ESMTP id m1Q8ObeX001950
	for <xenomai@xenomai.org>; Tue, 26 Feb 2008 09:24:37 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by dent (Postfix) with ESMTP id 1084DE401B
	for <xenomai@xenomai.org>; Tue, 26 Feb 2008 09:25:43 +0100 (CET)
Message-ID: <47C3CD06.6030006@domain.hid>
Date: Tue, 26 Feb 2008 09:25:42 +0100
From: Roland Stigge <stigge@domain.hid>
Organization: Antcom IT
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080110)
MIME-Version: 1.0
To: xenomai@xenomai.org
X-Enigmail-Version: 0.95.0
Subject: [Xenomai-core] Xenomai in Debian
X-BeenThere: xenomai@xenomai.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: xenomai-core-bounces@domain.hid
Errors-To: xenomai-core-bounces@domain.hid
X-PMX-Version: 5.4.1.325704, Antispam-Engine: 2.6.0.325393, Antispam-Data: 2008.2.26.1348
X-PMX-NS: (No Spam) Gauge=IIIIIII, Spam-Probability=7%, Report='BODY_SIZE_600_699 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
X-Scanned-By: MIMEDefang 2.62 on 130.75.6.240

Hi,

thanks to the previous Debian packaging work of Paul Corner (and of
course, all the Xenomai core developers), we now have xenomai officially
in Debian (i.e. Debian "sid", ready for the next Debian release "lenny").

For Debian related bugs, please use the Bug Tracking System at
bugs.debian.org. Everything else should stay the same as before, except
that all the Debian related files under debian/ are maintained inside
Debian (and can be backported to Xenomai "upstream", if desired in
Xenomai SVN).

Have fun,

Roland

_______________________________________________
Xenomai-core mailing list
Xenomai-core@domain.hid
https://mail.gna.org/listinfo/xenomai-core

--------------030305090808000602070409--

