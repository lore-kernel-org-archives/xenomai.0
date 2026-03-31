Received: from USG02-BN3-obe.outbound.protection.office365.us (mail-bn3usg02on0049.outbound.protection.office365.us [23.103.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B375437FF75
	for <xenomai@lists.linux.dev>; Wed,  1 Apr 2026 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.103.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031920; cv=fail; b=eGo0x93kD0grTAod5g0gwHunLt2IDWWbiLXEiSKJEdghmo9VkjTYfDP7waKSvewgEFkjIBePTIzeXHQW9pKOJiebvzJll6/18O77cJ7El6IWDzqHsbGM5oGpFeZpwO9RPQ1oQGEYMsnU1wEJOMc2Ca3t3IokLLkGifH9wa80s9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031920; c=relaxed/simple;
	bh=EiJFAifM+r+FbDq1jX0lad14D5rlnTnuBQRhfzV5Ja8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T+rRN7X8gYoosg1VHc1V7hQh6RqGmGsX6I0Osy//mCi95C2tvK3kDAbu/3a5JUjaLTLQDjvIZ7GkX+lo2llQfLtcIlxsVx450w6lIuPm2Xu7Ht0Zqc0fDaYq7pS9izGvI/tb2QCxlWkUAR2VE0KJphX2xKbM05CMj09wQYgaHYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=relativityspace.com; spf=pass smtp.mailfrom=relativityspace.com; dkim=pass (1024-bit key) header.d=relativityspace.com header.i=@relativityspace.com header.b=jq7QhdPo; arc=fail smtp.client-ip=23.103.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=relativityspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=relativityspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=relativityspace.com header.i=@relativityspace.com header.b="jq7QhdPo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=TNe9B22zoTnuLZ8ocECGzQokxDlZo+z09SBBW2bsJ6SRfO3qjSvpdRXNT7Gaayn2dXar+v5YzNip9gB5pT+fmH1E7ZcjXnq/wO28txGdpaz5sfAx5TO1I6NxCrzYTpjsPfTtwGCTb45zViuEo0gvofPD2XIj7vBPDEp3IKVi7aGZa1redFImKJc1tJ+9rZwg6OKy3dOUZasgb2HtpbURiOE9Djvrm/YQjkOI96RFPwCpljcMwH2DV4SDHS6/SgpSfEmyWU7c5jjbhG5vm60z4WaRBESsCBuEqi6NHYRrOT/wwa0+qM+7yRkWUbtxBOCTQP7P1DxIoF/mamRZg8YsIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiJFAifM+r+FbDq1jX0lad14D5rlnTnuBQRhfzV5Ja8=;
 b=Fmv6eJyA75Vbra1SA7AaHM8VNGylqRrl8fuN8Rh3FcGR1rmUgmqDZ9Leb53R4TxRBOg63a+UabEzYBZd83rhZZHM8iT+d1VP5uH1/sIskGCa6iqaomajxt8h7AYx2YxnVLNOfO2/eD5K2pw5tjKkNwoe98r+bw0Rqnb/eeGfJg4f0zK5sEUCS8r3qqnrkz/d3DDaamDCkOl3gKi/BGXFrPoyujjOHU+r58VpPoyYBYCAzcmQThOp5fbIRTnP7WspMRk5rsbPrwI2kQNSmuCDsR6i9FpuMaxfm4t6yfGw9AqrUayxHxtzUPdSSD6GBNN8frEuwjMG3u5qV4NZYJWCCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=relativityspace.com; dmarc=pass action=none
 header.from=relativityspace.com; dkim=pass header.d=relativityspace.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=relativityspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiJFAifM+r+FbDq1jX0lad14D5rlnTnuBQRhfzV5Ja8=;
 b=jq7QhdPo5XpLdLAzD3RDb0QcXVBt7Z0GVflYL/AWnfUw2mC4XYm5IxvrEbJ5h7bauJAl5tT6WHFi+9B/Tf8jspAdhCrM+i1sz306rFZfAXkrVIpJn43Yqbr7cerhng2dfUg7YPF57nmkMKwGSYSuJP7okPrEUFs3RFvLCnNIg9M=
Received: from SA1P110MB1278.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:194::20)
 by BN2P110MB1527.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:17d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.24; Tue, 31 Mar
 2026 22:52:38 +0000
Received: from SA1P110MB1278.NAMP110.PROD.OUTLOOK.COM
 ([fe80::f7ba:12ab:22b9:b340]) by SA1P110MB1278.NAMP110.PROD.OUTLOOK.COM
 ([fe80::f7ba:12ab:22b9:b340%4]) with mapi id 15.20.9745.024; Tue, 31 Mar 2026
 22:52:38 +0000
From: Brandon Ho <brho@relativityspace.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: Jay Sridharan <jsridharan@relativityspace.com>
Subject: Minor page faults from memory compaction causing in-band transitions
Thread-Topic: Minor page faults from memory compaction causing in-band
 transitions
Thread-Index: AQHcwWAV7mGNgh5thESUe/fRudyFBA==
Date: Tue, 31 Mar 2026 22:52:38 +0000
Message-ID:
 <SA1P110MB12786D45602F07720B3AEF78D353A@SA1P110MB1278.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3c71600a-6d1e-47ee-96a5-33d44f8880ef_Enabled=True;MSIP_Label_3c71600a-6d1e-47ee-96a5-33d44f8880ef_SiteId=95efb839-1b37-48d6-a201-7187831a1c9c;MSIP_Label_3c71600a-6d1e-47ee-96a5-33d44f8880ef_SetDate=2026-03-31T22:52:37.790Z;MSIP_Label_3c71600a-6d1e-47ee-96a5-33d44f8880ef_Name=No
 Label;MSIP_Label_3c71600a-6d1e-47ee-96a5-33d44f8880ef_ContentBits=1;MSIP_Label_3c71600a-6d1e-47ee-96a5-33d44f8880ef_Method=Privileged;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=relativityspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1P110MB1278:EE_|BN2P110MB1527:EE_
x-ms-office365-filtering-correlation-id: fe8c60e4-c781-44dd-bde9-08de8f783503
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|41320700013|1800799024|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info:
 DbuoMgJodL2Ht+ASr25OSKrr3Jlq9+tPa2UID0aPo2c/+ELp05AaGvtjQYrJCJGPK42nS8a7q16/Up0CyYP6m8oB/bI+lM6/kIwi41UzY19MwExHgPmONMnxwZ6ZWbHqcBceexDAAJpBS2kCe7aiPp6g/iHU7jHj+Og3Vspb4OrD7CZWY9K+ML1jCS7Cz824hsy15+dAWLw3fJ9y9xnffk6NOlQCtxoVxkMpI8FviMFA7uMX37UadtwYkkJ+I3GvQ8nlSZoWX+G4LAA7epzzsZ8nzEM3H0U+obpD9bSuJgB3j4+ciKfb4jh2y+Y3KfaNc15aRA0SNAEzRPUtxgjt646jOu4R34+cDZk2uuqU+LVVcESRgoVFLKvpm6e2eZzl4cWZYGJHsBTpMt4nuSaMONNhH/bVW0dXmDdHin6qXIO1vad4UYoDLi8WF4UYEIWTs696/rz5aJID2uvarHS5sekauNK8ulz/XvPm3OAq5ZOznVcftQ2o2fAN3IC3CdTl/m3vLnwW4pggyukuQshv/5YVaG9bMNoPBWuiFVRxx6bpJEiqN4i3gqF8qUK+QntJyqvadoOgXI1QLxJy3ySR7rkS8HBuwtu8E9j0W3DBqyXO8kI2kdMsoLGL97k81AoHJWCyJ8FNE4ZzdIQHBCKtfxTVWUF77UVSc89yYU8Y4kxSbZyIy0vvwZ9ZRAvYZXR2dkmSNQ0IoZBHHPLDqR7K0Q3atX7sgZZc4zQ0uoFDZrHX/YN++e0cUoF9nzpEEi4yWON3kZaqFAQk06ny9osdkyS9F/bqOP7r1uTOfCKghfU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1P110MB1278.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(1800799024)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?FJv7FTspHlbYUkDXxDf9O3JRfsEHCSK1vgSt5wVn7IkZqKQkLUO7I4DZTf?=
 =?iso-8859-1?Q?o7d/JtEGQRmOQlMVoo47ViQ34DMEhOtcIky/1XLUsoWOJnzp+VUI46ElL+?=
 =?iso-8859-1?Q?/JKjSLRiSw7y7kJQ43mIvgZc9eafeILlCixx543WVVqstCyTKVZi6IP6z3?=
 =?iso-8859-1?Q?WC9zChhclHX9ly4X2FQh2NTk1FwsOJG2Wjb9DMTdNqLF6xpo3uMGr0R5B1?=
 =?iso-8859-1?Q?c6cTMNwgSlObMKuAugLT7cxeZ+2uI96IDl7oixC2ro6Pk0V02UU3kuR44p?=
 =?iso-8859-1?Q?V1QAj50bsKfE6rPbXKjMwXcuampa32MsuZH9NzPC7kDA5Kgyszn0od36oN?=
 =?iso-8859-1?Q?VG39VplfSulx7W5rJ2xa46PGlmtkw3CiScGaTcfe5PTcs5NaD0GMW36cHi?=
 =?iso-8859-1?Q?cuqci79EtPdgn2Q/rNX54RTuO9UzCZS7Aq8aPeIEIw66mEc9I2p9fjGyXK?=
 =?iso-8859-1?Q?6oYc37qFM7bfbL+XDFRAUcgDYNtM8uWH3KfApy1IPUNfHT3ltRxPWNGK12?=
 =?iso-8859-1?Q?hAeFE5A16tQ6OC1ahJhYpbv6TPzOFYxD6lutAHm7wmk53VRaIGKtcL57E6?=
 =?iso-8859-1?Q?08hxfjj06LA40tFnN4UKiW7rqndFi2Bz/a6BqyCXTC2OLXNC8nBl1whNZ4?=
 =?iso-8859-1?Q?wOqzimlCnhzS3Y0BTPUfQKCxwyjTMgmT/BI/ciZZPV+oBEL0O1RJ+enXTT?=
 =?iso-8859-1?Q?aDeEWuJ2p22jSn19ZANre0C7zLA0AmDLbOis4YyPOruJY7tvYN1j4kNzVQ?=
 =?iso-8859-1?Q?2f++0Vz2DnYXFTo/D6H63/Ep+DNIM1cYj+3Ab6bH8ycexdWR/vBzhiFdzH?=
 =?iso-8859-1?Q?jyYDYl/+Sz2CUenO4JX3/tUqAgbSAAdBxebBCwEAVjxYtTtYkRRZ2ar7CX?=
 =?iso-8859-1?Q?QVNXL9c4RAIKPZ6I6JUrHVxy4P5RJ2XUPEtT/DAaKKVrPL9I1EdUTnR1r4?=
 =?iso-8859-1?Q?nI5/1mi1BpcT8unY5H+KbtL0ci5u+jhPWpHfo3AaHQ/3TFeLd0iGjwUpiO?=
 =?iso-8859-1?Q?xvifz7xBKbq8v6+8QrYvLsenddjryG/Nz6Ngg087gJUofWW/KTJFBmFL0R?=
 =?iso-8859-1?Q?5wP9TdZx2RYRCvWbZp0ZqvYrwtGfj+jVEjasUSI9zhjppW8tn28xdbA47B?=
 =?iso-8859-1?Q?hNoXphPdkxCyeyyc9CjBX7buSSoFKXjpCPzPPAkto5VNpeQowVqvOcuFuC?=
 =?iso-8859-1?Q?o9T4jyPywoISbxKqrzd7URDqq9C1g+33ZgZuzxRaIwjOZdlnVy8HvTpjdD?=
 =?iso-8859-1?Q?fCyXL7vTIJj/ugUSrLlDDs+M031pLF8zIcnwn5QqPV9ygoyER3fg7N/XUZ?=
 =?iso-8859-1?Q?NaHG9SCYLn+CSOXBNoGDaJo4R7fZqkpp2UWg3taZsh4V/6l0PH6H98xls/?=
 =?iso-8859-1?Q?rSl4XCO8ovsBwikmdAqlBEVATYEqzVBAO3dMC0O9hqM/XPMx0ZS7iCJjFL?=
 =?iso-8859-1?Q?mZ14PQW74+tv3zNtVN8HvbeLix9AR9cCDmuLyMBMpaDchyXMKAhTmOSF1Z?=
 =?iso-8859-1?Q?wbcugmD/WAtLD6CFJdSy9au5dWBZ3F8QqYub6QvSe3NStdq99I1V/m1zJL?=
 =?iso-8859-1?Q?40elv1NpmHT3GL+ojwvdL2x0wd42UNT9TITeYQt06Ps7kufuc8kj9dec6j?=
 =?iso-8859-1?Q?wLi4bHbG9Ha2hWyS8zv4YcUFbw8IEtg7GIIn6dtoEwiM6jNDRKZBHwPcle?=
 =?iso-8859-1?Q?fDL9jJxzE4euL5qQcpDhb+jaj5lJlHLNn/qzOSj6dVpjknxQSZIZwbMSpQ?=
 =?iso-8859-1?Q?bsgQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: relativityspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1P110MB1278.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8c60e4-c781-44dd-bde9-08de8f783503
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 22:52:38.1248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 95efb839-1b37-48d6-a201-7187831a1c9c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN2P110MB1527

Hi Xenomai team,=0A=
=0A=
I'm working on a real-time control application using Xenomai and we've been=
 experiencing unexpected in-band transitions caused by minor page faults du=
ring kernel memory compaction. Even though our RT threads use mlockall(MCL_=
CURRENT | MCL_FUTURE) and we've pre-faulted memory, the kernel's compaction=
 process seems to temporarily invalidate PTEs on our locked pages, causing =
faults when the RT thread accesses them.=0A=
=0A=
We've tried the usual mitigations (disabling THP, MAP_LOCKED, etc.) but com=
paction can still trigger these faults on already-locked pages.=0A=
=0A=
Has this issue come up before? I'm wondering if there's a mechanism to rese=
rve a section of RAM that's excluded from compaction/migration entirely, or=
 if there are kernel/Xenomai configurations we should be using to prevent t=
his.=0A=
=0A=
Any guidance would be appreciated!=0A=
=0A=
Thanks,=0A=
Brandon=
