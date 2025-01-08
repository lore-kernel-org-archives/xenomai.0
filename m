Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C893113C82E
	for <xenomai@lists.linux.dev>; Wed,  8 Jan 2025 01:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736300451; cv=fail; b=TSRgmiuQCBqz8ngirpIbQ9H9bBLiGJFi43C+bGSrwyArd13WtJypNgJbN7gMG6veFsaeYd/Uw8Kqn08BAuU/QalTVUX2JhI9bXhlK9LmieImPS1n4o8dFX5Gzn51lZ+aC4nw9Vp9+yau8vBUppBfFoXlsTQ1/VcelmuYrjw3Fn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736300451; c=relaxed/simple;
	bh=qt1TLEgMcgJtS7LNxctq646aZWhwCdZcD7Bxqj1Yt8M=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sE9oMsFkNHuTRzdOVmXNWgcVq/xvEjOpGexuvwVHg6IfBhSX7GcQHtJonnQXoPiAm6oK61LPsh2xVsvK2Gb8tLDIdvHUsoCAQ1jHRxAZLwdqBsohvSmxuny7QGgEkD5yebls4R3v56bdJJUFAUEjDhH+zVviylzHx7DpC4Rfv0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3DSystems.Com; spf=pass smtp.mailfrom=3DSystems.Com; dkim=pass (1024-bit key) header.d=3dsystems.com header.i=@3dsystems.com header.b=wbYQJLS7; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3DSystems.Com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3DSystems.Com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=3dsystems.com header.i=@3dsystems.com header.b="wbYQJLS7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJZZ4o6pyGxQ93HWl4ypeDT388TRf21I8SfE6Hv5oZOv5cg3ju4URjoG8VutfvZGnjcCHTGzffM325V/zziT6syCzYVq1ritRVJjBuHAaTZ8GG13Xukbh6+p9aRTnapQwO2XX5RrW4TcbXQ2ZcxtZg0pqc6tMvrYEjSnE+d7aSfIg5URmiGv+mJjxwusHXEWUocOXFG9qweusN9SEhmXoH7RHAHkoVobFv5/+5NA6SzILE5PspIh8+KSXw+Kwoxtqotmk3y13EBazZ/whm8atRAI/7bGuk0xbdHyYhjZNLeyocEzRn8MJxmS/88hzxhrIORQri9RG6na/AUqBgnM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qt1TLEgMcgJtS7LNxctq646aZWhwCdZcD7Bxqj1Yt8M=;
 b=FJPvYLj4d9XchxwQkB5uxN/sIONwHdK2UDAea/LNy/s5solh4aZZRfXd3F+hZRj6xgktjtFXyRsmxPcKX/NPYc1SdBTEFhjbL9SxI26HwG3xA/TGg/I/2oaWzQ+jrpFNR+zZRiVjAKsl2zbD30DdvxYeJwWxBkfQwd9D5MT6x4nSMXHlk2qwnfpybtTvUnYrVMa/er8gR/wxeQwdH+vkWBPgTV1bn8Y9ZnMmAkeuLqnwl9zdeDIq9AJzuqi5W+gc+iD6H95Nf9jPpWB2yvPPF53geqLBC4/tvusgjWkHhG28AIKhd0jLtN06N5LFZycMhQV3caIJj/Ix6wiXxcgsLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=3dsystems.com; dmarc=pass action=none
 header.from=3dsystems.com; dkim=pass header.d=3dsystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3dsystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qt1TLEgMcgJtS7LNxctq646aZWhwCdZcD7Bxqj1Yt8M=;
 b=wbYQJLS7FBRGh9rBGx3VXDjUUUiSIxsunSRzLi1ZFzSEcvsxZx9X2/ZNTMl7TVvYI2uG+ApDGI0oEsFCcmlEcf9z4x0/4P/24gj7bK2vsNjGo02bjOmpVHTmSSZF+FOGPtxFSPNki+Ab5Yhhh8NxFiabfHU1IBrJI8JmQsxXmLg=
Received: from MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7)
 by IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Wed, 8 Jan
 2025 01:40:46 +0000
Received: from MW3PR12MB4460.namprd12.prod.outlook.com
 ([fe80::f32:26d5:2189:f7a0]) by MW3PR12MB4460.namprd12.prod.outlook.com
 ([fe80::f32:26d5:2189:f7a0%6]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 01:40:46 +0000
From: "Auel, Kendall" <Kendall.Auel@3DSystems.Com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Output thread status to OOB serial port
Thread-Topic: Output thread status to OOB serial port
Thread-Index: AQHbYW2rGEJ2BdeuPUy+XTJgDgWksg==
Date: Wed, 8 Jan 2025 01:40:46 +0000
Message-ID:
 <MW3PR12MB446043BCF431010AC84E4ED1C2122@MW3PR12MB4460.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=3DSystems.Com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4460:EE_|IA1PR12MB7736:EE_
x-ms-office365-filtering-correlation-id: 5c29c577-5fc7-4c0d-aa67-08dd2f857900
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ZTHr//E+eN9j7VOxm9pAtsx79WKBWx5UO7EVjBGdwAP7MhnoAYVMCM2qIS?=
 =?iso-8859-1?Q?GOQodSo41B6LuV9aHz5Z2cO3fczUdpxrGMcXedQRLPePbZ1yyYSp2jB/aZ?=
 =?iso-8859-1?Q?DzfphmdNCrrOsxna99USBs172W1vfEpAKMVBuANB3rkwq+GSexv0xeRJgO?=
 =?iso-8859-1?Q?o2cpBwNw1A5vzLP0H+FK8ToL0qVypttsimdJCi1PZ1i7W/L8zk75PabpP3?=
 =?iso-8859-1?Q?qMOJ2YGpsVQMH25MtO8V4R7KBMxefnq7UF89UJxojU+66zs6MGFcuw8kr8?=
 =?iso-8859-1?Q?hjSp5doHN260VGGUORQ1MHttXjePZKFSAiwFGFAPyczZ/3LeaoiV8OhGy4?=
 =?iso-8859-1?Q?/qM2dPae36uNEZ2lmHRJ4PhShjz/H6jlELH6AfXG3pqEZyxjMD7zNxZOdo?=
 =?iso-8859-1?Q?n/UWJa2FnnlotDXWc5aO0hFkpE9d2nvLVX9r79xSYaQQxtjRbonupXp3y4?=
 =?iso-8859-1?Q?Xqoren2DpsrWhIccft+kFk78Yzuruz4nZFkNlivivDmGzpPPJ6JoV0RnRi?=
 =?iso-8859-1?Q?7qfAqvcOFZV1uHXNZGFjOmC8efF63Rj5zSKCYEufQL7r81p9KwdqAWKMp4?=
 =?iso-8859-1?Q?CASrPRl4q6wqgdggjGG6RGNHn3BDYquH/98ZC9vyqBKZqQm6u8PfD5Lm+B?=
 =?iso-8859-1?Q?OGaVeLY85q+Ps085uMSl6CPnf/JIEaAPt0OrWyhZIEI7TQEdD93TOgguyY?=
 =?iso-8859-1?Q?zjkzSyQnCnx9pg5d6x7VgM7XkUn7WPT26L6eOPPolewLilqn3v4tQpiVzR?=
 =?iso-8859-1?Q?7hpe9VKcp3wBYm20/Hgl3mctb4Wmc6Kq/WP2ZUpOl2HbLHUvAts3GQwQoc?=
 =?iso-8859-1?Q?RvND6WGGcP/GHVmS2JHF7oxJHmVBtv/TzxtTftgLtulLz6a1EN+ZfRPQxx?=
 =?iso-8859-1?Q?PZ55uaQZ3wB3jIKMWu6zgCn1X1QYAyq6xYJIQSuPbrdslSY4NsphJxdCA1?=
 =?iso-8859-1?Q?TdkIFE7lkgqCZP3L2ThSeuq5EN2XjanrrTD0cNGBym9SenwegRCmv8qr7U?=
 =?iso-8859-1?Q?I+aYWq8oosIHFMOuUtAFyk3B/4k2IjE4V/lPyRltr3FTLT/7ihJHCFwIJF?=
 =?iso-8859-1?Q?6GR5fG4WWuGPAIhAU0XTSTO6l6YTD0ax+k1VOlE1AdT1GsPXQyrrEF3lP+?=
 =?iso-8859-1?Q?+4P3q10FHS7lvjMmNlCH7zOXXQL+vdEKBHdluHchs6igdK7uiiMcvf+Ueo?=
 =?iso-8859-1?Q?ZEa9jOP8AOZQYHfXQwarJtdXYO+6r460hNFLide+R+pgyozVwfwu+Vaa2g?=
 =?iso-8859-1?Q?/uhq5o0xvtQaRIZr5l6/5zVeRfXgxS3x8OqmDtTzIVhNhAafCxUTl79ClT?=
 =?iso-8859-1?Q?QNQpZDeKHszIQjdbkCMWq1SJlmMskEe5GQvqn7d6WM7uy91mGk/QcFX8l1?=
 =?iso-8859-1?Q?vT8iQOmpzGdJSSjWovbRpRY5UQyxw6bVJH268Qww3VzFVsElWDVUlodQHA?=
 =?iso-8859-1?Q?uZek1nhPAod96Xx6hUNCSCdpP9ak5Kjw7SQogC0mIGe73bQ4HRcpcTZLhV?=
 =?iso-8859-1?Q?PWTFRlp1PeLTFBktqph+jT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?c5e4EQXbT8/Fzf7Nwf7NltcIVduAawdhKJwNeoZu/OcUIhdF7aTryMxy1R?=
 =?iso-8859-1?Q?d8Gp+7hXr85q0cTE/Z+zy5r/gOX7CIdbaT0LEGD6sULTIjgStYgFIjBL4Z?=
 =?iso-8859-1?Q?wZhqvJAKWrrpgNSfbUte0TThrNYY0kGBHTlkGNDqC+nVQcr3KsbyHs/5i+?=
 =?iso-8859-1?Q?BFHPi7cYpqSjKVTHcAvTkxyAua5ovMeZf94iwW88Bczk8J7FZubsJdAPQw?=
 =?iso-8859-1?Q?UzYiDsMqWdqEGztnN0pRqyc+uHExFKRtLsS2zBkYCRrrLk6cHcP8bzRdHv?=
 =?iso-8859-1?Q?lkKTvRH0F25QQIJeikGlrhSizgTZWV1xrlPxG9vGRNDCvHxCQvgDsEhMuE?=
 =?iso-8859-1?Q?Swc7Z0KQmTKROFp/YPlimYs2OyyNBn0ReoDiNtG6PP8q2NHnHkIV8iydfq?=
 =?iso-8859-1?Q?hHDcqDjZIvmgbPxOSfM7XNppvsJc2QTYq+OYzv7NnOUe26sr9a2LRLjksr?=
 =?iso-8859-1?Q?Pkxd9tmxt2OX/5kzOlzN7dyqsek9A69PHCp64U0XJbKZ6QITjOPVe7bpbF?=
 =?iso-8859-1?Q?RiHfS+aDW4J2GpvAdCHSAxY8I9twL/K7quz118hZixIFPpNtT3lIslklmB?=
 =?iso-8859-1?Q?8DAAOGCPu8/T2RS1CyO8WFQBvvMGa7yJSzQvLjEEszqIycDn/wHS1HvBmv?=
 =?iso-8859-1?Q?qmhM+17MDaNatW2LEM+bYNoS2mxNF7dnj/LdOUyVU/HYw2sirMFbGTVgwI?=
 =?iso-8859-1?Q?qsxs4Kq2LcTpLXf0/T4N1spKAQ/ZjCyBj/2a6xtm4jH5Eb5zu1w4RqaALA?=
 =?iso-8859-1?Q?TsLeM4jA1V1uXJSG/a64Wp4vN6lhmDS/BhEcGtaqqkV2zvMiItzRc02xM3?=
 =?iso-8859-1?Q?ml6RtLZ2Fu9zzlxUDKtmwTJsPbPIs0g5wfg8rbl396lQ9pSCNKu0l/k3Cu?=
 =?iso-8859-1?Q?9yvBnZs0Mg9k/+XROfZxAH1Z7tkucTz1G0MXyHh/seOCPJhNTIc8zJIAaj?=
 =?iso-8859-1?Q?m3ZfekWRpOFyqk7lzF9sxIaY/0m8GAVrteTI/YzAQSGQR4m8F+GArz+rGy?=
 =?iso-8859-1?Q?0SCAbxsL3j3LQIf9Ft37ASHNDm0TNYP7BpTv9ePSd3NXpP6R3hV/bcedoi?=
 =?iso-8859-1?Q?grKWUJapZEd+KSAR/qXEtHATLJsitCyEPZljfItkAaOrI/siB3pYqR3zVW?=
 =?iso-8859-1?Q?OsSopPzXsR5yrP60RweOqYk6Fz4uw0P3P29d1FXrxUZ7KEDVUpHTnx08eG?=
 =?iso-8859-1?Q?9TmfuG09MBtxfwQ5NpaRMbBCbqynEesFR4NIB0WQWbxS/9VaP+6iE/EgTu?=
 =?iso-8859-1?Q?wOsqOKXxjr3HNcfw5vjNXW/zHdWrC6oplVnL0RcbIHWz09RV5MuQqYl7KW?=
 =?iso-8859-1?Q?VkaA0+1FT2sXbZiaCB/dNvXWVX8LQGD8j05ZzKoZLsb4AQPhXyQhS+V8Gv?=
 =?iso-8859-1?Q?q5WbEgA/X3nZ+mSL+5BBoYUIZ+YPCln4hz/Mqi2I2qGZ+RrIEaIdLrZF4H?=
 =?iso-8859-1?Q?OZLLmiDV1yncmQag/8j4cVqVQO/73084ll29WIJvEGJtY0Ov4hKJO+aSNe?=
 =?iso-8859-1?Q?x0B/4UPra0bysaYvkunv9l2HJ9VRkWhchttmYPlkAQLlrD+Z9+d4SzJ3GO?=
 =?iso-8859-1?Q?pa3s2cAYdhLBWJ1+t+9zijojPb/w6NdBVPDd2odS18NxLREn93E00wq5nL?=
 =?iso-8859-1?Q?qHVLsMlU4PncZK7HQUD7462dICJIhPKQiS?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: 3dsystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c29c577-5fc7-4c0d-aa67-08dd2f857900
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 01:40:46.3460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 150688f4-8db2-44d3-b980-cd00ab6848fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8/CFBJ8QdguxFU1+dCuedLCbmNw4nD6lzu48nlpgSSh2wVWKk2btteC+Jv8ajy9DVK3wwKuAsOcv7w6iypfTzv4O354yqLYby2xpETAwML8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7736

I'm trying to debug a very infrequent lockup of our system. It occurs once =
every day=0A=
or two. The symptom is that all Linux processes freeze, but there appears t=
o be activity=0A=
on at least one real time thread (a pin is toggling). We tried to catch it =
with the watchdog=0A=
but that doesn't trigger for some reason.=0A=
=0A=
At this point we have enabled the real time serial port, and we can see "he=
llo world" from=0A=
a high-priority oob thread, while a lower priority oob thread is running an=
 infinite loop, and=0A=
thus locking out the in-band threads. My next step is to output something l=
ike=0A=
/proc/xenomai/sched/threads periodically on the real time=A0serial port and=
 wait for a lockup.=0A=
=0A=
Two questions:=0A=
1. Is there a better approach to debug a lockup, when the watchdog doesn't =
catch it?=0A=
2. Is there some code I can steal to output the thread status, or do I writ=
e one from myself?=0A=
=0A=
Thanks,=0A=
Kendall Auel=0A=
