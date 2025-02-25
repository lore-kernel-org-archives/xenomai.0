Received: from mailin.dlr.de (mailin.dlr.de [194.94.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9512698AE
	for <xenomai@lists.linux.dev>; Tue, 25 Feb 2025 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.94.201.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489699; cv=none; b=DATG8NwjMAWmCHqhNcamphzwjRHYYudEfFXeIQcKiiZ2aTo1/5Rl0+VE9eNbTMObsM+xR865M9LNo4mJ5lJ03tr+IdMKbfsgOM9aqrF5iG4ulpAAfuJKGqa7r+UyLCywwrfEISTBIcY+NR17etsJrDgC6Jf1yWR8O/TCOZbsgSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489699; c=relaxed/simple;
	bh=x18NO0UwL5oGzTGtk2p/B+FC6edNEuX9DVQupLo9dLI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SFjsSiMCzzK6/05VcjI/UhMA13mSEcyl/Dl6iX/0C+GfYN6T68Ls1jf3BAcJ1OIwRPcdkMqSAF2y1g4k7ikynJ8XLLoO0U/l8Iy3JUGYWF7y14zMRIU1LqlEhUJHbw6/7CDFPr6cahLbYv60wqlSutGbcz4Rx+h1yWSf7YsaMvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dlr.de; spf=pass smtp.mailfrom=dlr.de; dkim=pass (2048-bit key) header.d=dlr.de header.i=@dlr.de header.b=dgaPkYjq; arc=none smtp.client-ip=194.94.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dlr.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dlr.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dlr.de header.i=@dlr.de header.b="dgaPkYjq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dlr.de; i=@dlr.de; q=dns/txt; s=052022;
  t=1740489695; x=1772025695;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=x18NO0UwL5oGzTGtk2p/B+FC6edNEuX9DVQupLo9dLI=;
  b=dgaPkYjqV8iqqP78mVaeslpHr23XB7ChW8uOphh2fvUXq+s7pxOX4ai2
   MsemfJZf64sDOU45KlvKL/g02IcdTXN2RLEetYrUWOAetI6Z8Vy2uOOMW
   Wfa6i4Lnr+/4ReUFET00tWQS0gutRy8uS0AURTwIhePcFpiu81u2eoiPh
   wRpDkRiR1rvAMN2rvaNZMHF9kjYMe0XEhhYx4c5fH5ARH+4CteATQIZ23
   FXbLaFwGJY0CkvWHkfhNXe93E8Btr0Ze2zXoLEgn5cMMgJ+VHgs4m+fyT
   gzk8qMbQp7cpmQBN18n8cui2uL2BpF+6JCIBSy5EfMHs+nax4a2pN9jdc
   Q==;
X-CSE-ConnectionGUID: Hjib6AdyTFa8A/RoR/eHSw==
X-CSE-MsgGUID: W9GAlnimT26MHLIEU+Ua+A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2HeBABSwr1n/xaKuApagQmHFZYpkheKKoFqMIE6DwEBA?=
 =?us-ascii?q?QEBAQEBAQgBRAQBAYITjggnOBMBAgQBAQEBAwIDAQEBAQEBAQEOAQEGAQEBA?=
 =?us-ascii?q?QEBBgYBAoEdhTVTgluFGQF/JgEEG4VfrzOBNIEBhHzbJoFIiDUaAXKMP4kGB?=
 =?us-ascii?q?QESAW6FdwSCL0qEYoZRgnaDEIECiH2DOo07LIEhHANZLAEPETUTFwsHBYFxA?=
 =?us-ascii?q?4EPgUZ6gkVpSToCDQI1Z4E3fIIrhFaEQ4RChVKCEYQ8hn6DSB1AAwsHZj03F?=
 =?us-ascii?q?BsGAgGBNaQggV5ogWZAknCRZKFwB4I4jUyVai4XhAONB4ZIkV6BJZh9glihA?=
 =?us-ascii?q?oUsAgQCBAUCF4F+gQ9wcYM3URcCD94RgTQCBwEKAQEDCZAcLoEdAQE?=
IronPort-PHdr: A9a23:6o90Jx3gHrbVFGgBsmDOHgQyDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BeFo601xw+QAtSTwskHotSVmpioYXYH75eFvSJKW713fDhBpOMo2icNO4q7M3D9N+PgdCcgH
 c5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFRrhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTezf79+N
 gm6oRneusQVnIdvKKI8wQbVr3VVfOhb2WxnKVWPkhjm+8y+5oRj8yNeu/Ig885PT6D3dLkmQ
 LJbETorLXk76NXkuxfbQgSD/2URXGoLnBZQDAfL8B/1XpHqsivnreV9wzWVPdf3Tb8vRzuv6
 bpgRQLyhycGMz4593zXitB1galGrh+tuwBzzojJa4yTKfFwfL7SfckCSGRBQMhfSjBBDI2/Y
 YsOE+UPMulXopLhp1sXrxuyGRWgCP/yxjJOm3T43bc60+MkEQze2wEvBdEOsG/UrNrvNKYeS
 /61w7PHzTXDdfxWwjb96YjSfR06vP6MWahwfdDMxkYxDg7IiEibpoP5MT2PzOsNr3Sb4PR6V
 eKpk2Mqrxx9riSsy8oxloTEgoIbxk7A+Chkzos4K9m1RkF6bNK4E5ZdqjyWOotqTs4sQGxmt
 yI3x7watZC7ciYG1pQqyhjCYPKEa4iF+g/vWPqLLTtlh39od6iziwu8/EWj0OHwSNe43E5Xo
 idHjNXArG4B2wHJ5sSaSPZw/12t1SuJ2gvO8O9LO1o0mrDeK5M5x74wkYccvlrbEy/tnUX2k
 LeWdkI5+ui08+jnYqvpppubN4JshA/wNKoglMO/D+o4NQYAXG+V9/6i2LH98kP2QatHguc3k
 qnfrJDaP94UqrSkDA9RyIYv8QuwACm+3NQZm3kIMk5FdQqag4T1IV3CPfP1APilj1ixnjpmx
 OrKMqP/DpnVK3jMirbhfbJz605GzwozyMhS6IhXCrEaIPL8QE/wuMbGDhAjPAy0w/zoCM581
 oIeQ22CGbKWMKfIsVOS++0gPfGAZIkOtznlMfgq++bujWMlmV8aZaSlwIMbaGqkEfR+P0WZf
 X3sj88OEGgUuAo+S+nqh0eDUTNIY3ayXrk85i0gCI68CYfDR4atgKGO3SuhA5JZeH5GBkiRH
 nfrdoWEXu8BZjqdLMBvjDIKSaSsRYk52RG1rA/6xaJqIPLN9CMAupzvzMN15/XdlR4q9Tx7E
 cCd02aVQm9sh20GXzA4j+hDphkp2lqF1q1xgtRcFMdP/LVNUwEnJdjQwvIsWP7oXQeUKt6KU
 1avU5O4CD4xR8kw0tYmb0JnXdmv2EOQlxG2CqMYwuTYTKc/9bjRiiCZGg==
IronPort-Data: A9a23:E98Su6yyFa9nSu5EMGB6t+dzxyrEfRIJ4+MujC+fZmUNrF6WrkUPn
 TFMWz3Qb6nfZzejKtp1bY7g8UgA68eGm95kTFNtpVhgHilAwSbn6XV1DatS0we6dJCroJdPt
 p1GAjX4BJlpCCea/1H1aeCJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYx6TSCK13L4
 IiaT/H3Ygf/hmYuaD9MscpvlTs21BjMkGJA1rABTa0T1LPuvyF9JI4SI6i3M0z5TuF8dgJtb
 7+epF0R1jqxEyYFUrtJoJ6iGqE5auK60Ty1t5Zjc/PKbi6uB8AF+v1T2PI0MS+7gtgS9jx74
 I0lWZeYEW/FMkBQ8Qi0vtYx/yxWZMV7FLH7zXeXkc6SxRPvf2rQ7fw+JQYMOrdf98ZMHjQbn
 RAYAGhlghGrq8aa7ZyVb8hJvp55AfnAeoIZpmtpiz3dF7AqTPgvQY2TvZkBjGt235seW6yED
 yYaQWMHgBDoah5UOl4GTow3k+ehnXjuehVUrEjTqadfD237l1EqjeGxa4a9ltqiepR6t0Kep
 2f6pTrcIjU7GeHc9DPG2yf57gPItWahMG4IL5Wo+/hthVSS7mgSEwENE1+6p+SpzEKzRbpix
 1c89i4ioKY88U2uVoOnUg2z5n+CogQVHdZUCas25Wlh15bp3upQPUBcJhYpVTDsnJZeqeACv
 rNRo+7UOA==
IronPort-HdrOrdr: A9a23:S0kFZKPvZw+5p8BcTvCjsMiBIKoaSvp037By7TESdfUnSL38qy
 nIpoVi6faUskdpZJhOo7C90cW7LE80lqQFmrX5X43SPzUO0VHAROoJ0WKI+VLd8ljFl9K1op
 0PT0ERMrHN5BNB/KLHCUGDYrEdKfe8gcaVuds=
X-Talos-CUID: 9a23:a4zTWGHGXvB1OeV+qmJH9k8eROkpY0HzxSf5ZHW/MyFkaIaKHAo=
X-Talos-MUID: 9a23:fEU9SQW3meyiKd3q/AC9qxhmMsZt3/7wLWApsLg7+PSNdgUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="35351434"
From: <akshay.vaghasiya@dlr.de>
To: <xenomai@lists.linux.dev>
Subject: Header Conflicts Between C++ and Xenomai During Compilation
Thread-Topic: Header Conflicts Between C++ and Xenomai During Compilation
Thread-Index: AduHiC3RFiZKTbxOSGa3CmNIpS+tKQ==
Date: Tue, 25 Feb 2025 13:21:32 +0000
Message-ID: <49e5cf6ae5eb4687b0c1f6387e964cb6@dlr.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hello Dear Xenomai supports,

I hope this email finds you well.

I am encountering issues while compiling a C++ application integrated with =
Xenomai 4, where the C++ headers conflict with the Xenomai kernel and user-=
space headers. Specifically, there are errors related to type definitions s=
uch as stdbool.h and bool, as well as undefined macros in the Xenomai kerne=
l headers, like BITS_PER_LONG, ARM64_HAS_PAN, and __no_sanitize_or_inline. =
These conflicts seem to stem from mismatched header definitions between the=
 standard C++ library and Xenomai's kernel-space headers, causing compilati=
on failures.

So far I have tried undefining the functions as // Ensure kernel headers ar=
e excluded in user-space code
#define __NO_KERNEL_HEADERS
#undef swap  // Undefine the kernel's swap macro to avoid conflicts
#undef min   // Undefine the kernel's min macro to avoid conflicts
#undef max   // Undefine the kernel's max macro to avoid conflicts, for som=
e this fixes the uses but then I get the errors related to type definitions=
.

Could you please advise on how to resolve these conflicts, particularly in =
regard to header definitions between C++ and Xenomai?
Is there anything I need to update while configuration setup to make sure t=
hat tehre is no conflict between C++ and Xenomai headers

Thanks and regards,
Akshay Vaghasiya


Deutsches Zentrum f=FCr Luft- und Raumfahrt e.V.(DLR)
German Aerospace Center
Institute of Software Technology | Flight Software | Lilenthal=FCplatz 7 | =
38108 |Braunschweig | Germany
Akshay Vaghasiya | Software Engineer (Master Thesis)
