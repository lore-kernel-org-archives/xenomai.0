Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C86C2DFA4E
	for <xenomai@lists.linux.dev>; Thu, 17 Apr 2025 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744877729; cv=fail; b=MbVXfv+Sid5TSc/IdrKWWUeTCiZqHvynlh9x6AfzIi5j7P7JvBOPcLibpzYiddAco963r3Q+os+MbDP3oQwFMCV3TSamETmapIuxGrJcprajBUy8bPOhvVfmV/5OZw0yjvqQhq2j9Fdd4X1tFU+suSzaPDxVGqz4yWIlDkEmwNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744877729; c=relaxed/simple;
	bh=La08TLmXjxj67hLuc5pfQlxsA6fmLlL4e8l4rFFaS4M=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RADGKVluj7uNrmmlvygrwQGYM8PSh1AnEKD7bda1AZN6rqtEL6rTKHaY1o5T0BqO8nXROTlgcHvSAniH0pKA2noWos4I71vVyt4OW+x14kVII6izDEbb9Of9rCVoRx6hIHfHp0oZW1OMsiawJFRBjyZJHAUqVMYwwrPUJwRLPPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S2eBiBpQ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S2eBiBpQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744877727; x=1776413727;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=La08TLmXjxj67hLuc5pfQlxsA6fmLlL4e8l4rFFaS4M=;
  b=S2eBiBpQy29XvMFfsYMj1oofpWcosx7NmtIwQoO/Wl33aFjmVCznyMLD
   x9uCghoWJm4l6LecldX19dL53V8UbYlrI0+Jsf94huUe6zTuEfIYrAZO2
   qcvu5i+3BXEnXeFLXQKB/WqtfPe0/CHmHL+XFdIJEPWD3d1Pjs2K/NENs
   hAw2DVJLdxmDPDqOqYDEetpByd+OP53h/zRgmP45n5s+lTzAz+iggKTKV
   M5ql08RLPENzyeaVevF0BsGVoDfARwY06PbQoJiagza5TYcy1bY72WCV6
   74ilkQdf1WHB0IGGExNnSs4Qq6iDZYWhg24o08siL10fxZTFzpUoL7B9R
   Q==;
X-CSE-ConnectionGUID: U2ylvmgHT6KeFR0AIl00ow==
X-CSE-MsgGUID: FQAOIOhsR6ieGzNNDbOcRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46350092"
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="46350092"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 01:15:24 -0700
X-CSE-ConnectionGUID: bzuw4QOgTvmNaDBK68ZnAA==
X-CSE-MsgGUID: cMiu0Rl6TBK3VCt7P16y+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="131263874"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 01:15:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 01:15:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 01:15:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 01:15:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdrHYVTcssd+ZQ6M/vlr+lt+BkE3PRhUD6ceehwQx3bauzNvw5Awuba90PuDnJxzMbGqDkzCqqU7jY3qiZM41jjkKP8UWjMM6QF3+iCAx1mNMOQsWiHbtCkKZDT0i+txGQoEw6i8BctMitQ5WYvPlNJ805KySNdf8KtASG2kZnigPgxw4ufxCymHyze0fQF6N3+3ysNa5M2hpGbNcJLuloFi7Scsbm+RTI2wJcGe5V2XpDi7E3YBXskqcRGn1+DpxyaYu27oibVazbbNU9e2uTcqxFi6kGXrpWa8XMV9QUBCtlc4HpEJ2t5QDwB73jvUXX/vUvLOVct2S5RStPAMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prVXh5zIP9ehYUxQ1kP2O7GsRBT0euQOxJQhzek5/Xo=;
 b=INxbDe6DR2D2uJlsJUob78EYwRLu5THVbap+tUeRDphpzrZsY6ddF4QM7RZ9rJB0wjq8j3M7GoNYMw6hKP37ZdnbdPERYAquf6KsT/Lpfm5FHf2pYZK3O+h9yVch0UIqm52EsDANsqdpYER07duTN6XyuGGrhRcBUgdyFMZYmQOzA0KUT3wXjA+/RppOaKHIKecUBKIonn9VZnYhDdsqQYPltqunQPJTE4SUde8zSIJTPVyC3bq3Q+dtEM4OZOSM7DvuyDmsq9SMD5ETVBXkWE7J9oesFIZX98Tk1F94s5elCwIK3BElMA0YBOxv00a0jRzY0Vz1BTyCXmF1b0H5Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6513.namprd11.prod.outlook.com (2603:10b6:208:3a3::7)
 by LV8PR11MB8584.namprd11.prod.outlook.com (2603:10b6:408:1f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Thu, 17 Apr
 2025 08:15:20 +0000
Received: from IA1PR11MB6513.namprd11.prod.outlook.com
 ([fe80::8012:e01:4c01:d824]) by IA1PR11MB6513.namprd11.prod.outlook.com
 ([fe80::8012:e01:4c01:d824%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 08:15:20 +0000
From: "Qiao, Wei" <wei.qiao@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: "Qiao, Wei" <wei.qiao@intel.com>, "Chen, Hongzhan"
	<hongzhan.chen@intel.com>, "Pirou, Florent" <florent.pirou@intel.com>
Subject: Build error of kernel/xenomai/debug.c
Thread-Topic: Build error of kernel/xenomai/debug.c
Thread-Index: AduvcNIP6fYojmwUSlGjpzfO8h3ARw==
Date: Thu, 17 Apr 2025 08:15:20 +0000
Message-ID: <IA1PR11MB6513EB0131E06C8CC865E8EF8CBC2@IA1PR11MB6513.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6513:EE_|LV8PR11MB8584:EE_
x-ms-office365-filtering-correlation-id: bee81589-b249-472f-23a8-08dd7d87fefd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?windows-1256?Q?amWSczM5Rl8BloQ36QiaNey6fX15RYQgGubDZLgc8X55NtX0rM+muDGl?=
 =?windows-1256?Q?GBFvbhEmRwUYaoSwxfA5g2DXjzeK1T/vHw2m2Yppktf2qjhtluBIKp/q?=
 =?windows-1256?Q?eweDQ7OA9t+mmp7suLxEuMZbJRzK2BYkvqee0f9rP3mm2p075tARS7u4?=
 =?windows-1256?Q?HRkm2codzy98X1zjTZToLEQZ9YaVYWMTE8pd8tkJAEiO4mDRn/VwTWx+?=
 =?windows-1256?Q?AXwELSNNww6u9qD2/gvVVKuEe6XZJt4les57nU6SsCtbIqr06MFG3zCO?=
 =?windows-1256?Q?/zSiaDd7IUT6neL/eB+6ImNQJDkzCbtfvwq+QvaZc2uZreegtkSD8I69?=
 =?windows-1256?Q?148QZtBDa5PLI+ZBwXYFx4vnpCiSD8UDYmD2j0qcubkkB+O50ciM3OEx?=
 =?windows-1256?Q?re1T4H72XNzoXeG94rOSgeIZTP8KqgdxOdM5giA1bxlWgZwYV8aOuw1P?=
 =?windows-1256?Q?8Fdl/2xemV2TIfxKHwulPyBb50pMDA4GWwtl5EjxWkCATTwK8Rc0Ocz9?=
 =?windows-1256?Q?6Y2W90sOVY74txzlpkn0KkzZ413LuOA6/wBjVmjbXwmgrfJhx1Y6OOcx?=
 =?windows-1256?Q?2fRZOu5djIwpWdx27uhOuuYH/zC8C5cpJFmN74mEEKCbJLKz3Xu4DcU6?=
 =?windows-1256?Q?+XVGf/EY9mDs3eWUDA8teXg98BZfNohwN+MU01edrFeHzg6IVM/rzfOB?=
 =?windows-1256?Q?4kI8r9Vhx2PUd+rTr1fvGAnMTnIsa0d4wzuOxhHs2lAXI3I6UWvs7Wr2?=
 =?windows-1256?Q?SC+x8VwtMGBSuzPilKGx+TMWPOH8oFHfiu6/JlsccUTg23hijJf9pQ3r?=
 =?windows-1256?Q?jZvshmwe/oncZGqgB2fcHwwV9JW4fqFp+Ni4vVzSXPv3QXb6X0LOSqNd?=
 =?windows-1256?Q?ThzzRucyFUuIt01qFKyHo7KhjPPQ4fXEPVWdaxtDySY5GfEGd4aX62Mc?=
 =?windows-1256?Q?GVfCWyqHjvaYutunxq32LJZXLlbG6ILwlQ/ReJVH6ZxLcuNoMPYzKFAP?=
 =?windows-1256?Q?Ke4AL2ZFXTgn+zaMy/ejmKJYOpjv0+lms7VjMn8LQBZQ9X08Afe6Yrle?=
 =?windows-1256?Q?1v+EKcNMPUFpfdRJ1OhHyQbys3dsWIkd/twKJ5ItXRM158UqS/PaXKQ3?=
 =?windows-1256?Q?aGVQegOtjuGCsudNOfwv0/J8cUfN68Ak7KDihp2XOjSxonfkKN6H/xm6?=
 =?windows-1256?Q?Ow7XXAbk3fFcK8rmo5+Pf+Ow8eafBTRDD/L6LBIFjFdPNrpr3vojcsgw?=
 =?windows-1256?Q?buXo7hByFthqquG1RIyEeAD+oGyr24q3f+rsZBVBqGihJcOR3+Dp3tdA?=
 =?windows-1256?Q?kMij5RJsa8jRSdKu6n/3exrWKYw4R0gVfH/HSKQ8ADvq0DwXNK4TYhUc?=
 =?windows-1256?Q?T817dkC+nVF+XP5bt739GPGqLdrM70iwQaeHvU/4rCWb31okdUQ4TPtp?=
 =?windows-1256?Q?fz8toTHbLQlXAAnYwRgEiWEmgKglWzDwu3+SFiG6oGZ823MUHpLUntCM?=
 =?windows-1256?Q?szAsHdV/JTLG5UIkhydM+8NxJdLEXGVASXYimUJaf3pkWWo4MUgL1nsc?=
 =?windows-1256?Q?Wnv2QCKTxFdH/zuWnkdUPKiiuTkXXvyakEjAJ/+uMJMIySIs9vVRRDmB?=
 =?windows-1256?Q?Zc4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6513.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?windows-1256?Q?eKNtt8ffxftaqWuRrOmlSvO3y3WfDuplS27brtVChvtDeDbG7HKznrpt?=
 =?windows-1256?Q?HVNcBeR0vlX3iq14LXmEHSTTux4KRhfYDSXoR+cZyO2g8RW6o6nssAWa?=
 =?windows-1256?Q?9RrfJVOdnP3z1oIfyAoZDYUnMw3ucuWJZ6gaLjgoTVUfY3XoKXkSzxJt?=
 =?windows-1256?Q?U9pkIyXX1xdcjdM++43KpozlXEXqE9zp1QOT9JYxukxK7QO3fNjvFG8Q?=
 =?windows-1256?Q?mo8mUT1R/sKml1PLnI+cDXCQ9wY7d+IMoyPEDw54n3lmP7iu3Lebm1LN?=
 =?windows-1256?Q?uwMy0ODBTy+lQx+B+N/+FVgSQsW/QIboJku5w7dIiVx5yXgMluo8a2Ej?=
 =?windows-1256?Q?/dYtiUKhvgIL6OJfJnPAD5VzTrpey7RHp4DngOpcmX+2S4bXWDrWv0fd?=
 =?windows-1256?Q?RKBKImEn8HvlflcyCV8TGGaP10KV0i39D77vG2zV/3WlMQDe6a0O0cbX?=
 =?windows-1256?Q?vHTb75O9RqXX4RKpgYFyYITaVGzkwoM6z6sLankf9XH8wCvkQnnUFhuB?=
 =?windows-1256?Q?28yIM3DrNzNk0heg/mqPcRjE1ajs2Cs9cOop3TAHb086ar21cmUb8Qzn?=
 =?windows-1256?Q?vrN4mGvNZUA0sCh01BSlYEFzG4OcxmWdPyvY9DplKTtQbyL59CGaRTTm?=
 =?windows-1256?Q?qnY04ouzp1cSIjWxQSzCg3fyZ4An3uxf9YuupzPzzeZurltC/Lwo25v2?=
 =?windows-1256?Q?vZSj93zLqa6gMepwYY7fSJZHdZUr4rMvjN2pOW6lNDyQQhYoUl+95n0/?=
 =?windows-1256?Q?+I/g4R8iPz5lhKro/SrdxjuxnCQQoi2RNgvVzlRq0LJqlhAN8v2tmSZA?=
 =?windows-1256?Q?ejZJli8hrPy20j4UkWU5MrCJ2KVYi3LUyx47Wn//+17C2QRQ02/n+VjR?=
 =?windows-1256?Q?YzbzFWrsXLS8W5hnfR7f7oiz0VZcBXMtU2xCPaL0f0aujPJ8Q/oXzO3k?=
 =?windows-1256?Q?76dKunEbpm+9mV7diMTfmDhVoNtaQuPIwHBwtT2uKBT5Uvmks96n5Qna?=
 =?windows-1256?Q?guchaZ7qbFTMFnTWI6uVk+igWtCD6gxapg5CdzQCcznhi8ifiX4xDq5H?=
 =?windows-1256?Q?T981hUEoMtCx7Df7r+GpZ2EvWTgdHk4p9rN65GmosJbqF6B471byeNkR?=
 =?windows-1256?Q?KgzkS/PPAc2KbY+eoHplZqCl41GcBpds483tFuxjRM3fYTKyTyEuwHuv?=
 =?windows-1256?Q?U/nCv+EyvKzWSZS1zxdW8NZ6btP30hMbxG89dJ6fFIugM0DgLzoeJMLp?=
 =?windows-1256?Q?dqoEu3FnW4IHM++TIrdFSEGd6IBVI0QiTtit4+RKgVkJzhWXKe7Ybmni?=
 =?windows-1256?Q?qh1X0Bvs12Ftgx+npexpqoQ0wEqf32jrAknZUYZwlth1cXcx6RD4LTbC?=
 =?windows-1256?Q?pt9lSdcYArwL+PUE2XxMdgnICLWN9aVeLmu1gAKLfkZvCpjmNB0948aX?=
 =?windows-1256?Q?6ZyyGwFuFaSqZVvR/QYk/FZQIJf1yCx87bFSQaA6JPZdQ29L4Hdz/uRn?=
 =?windows-1256?Q?eAWpqP01bWWoWBETxNp6m74rxgM3k24QYJo2nPKOHIqwi+h2VPekWbLD?=
 =?windows-1256?Q?aozsG0drj8QdZgbSd8+kpF3gNQj1Sd4547QUf7YkeDrvWadEM8rTdboK?=
 =?windows-1256?Q?7Gh/RGKCY2O8bbtjSsW+fNJrvxM+mQw0wdKxaDWBE7nkNXG3uGMbrUVG?=
 =?windows-1256?Q?9I4BxMW8FqBLzp26UBax01Nq3XRJP2yI?=
Content-Type: text/plain; charset="windows-1256"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6513.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee81589-b249-472f-23a8-08dd7d87fefd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 08:15:20.8156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2Lulp3huTQA4mCJtsUqZe0S/Him6U18IgNaUsljid299eA9FOmF50qPsqXxiLuMidCrC76D1/l2WeVrDA4kSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8584
X-OriginatorOrg: intel.com

Hi All,

If we build the kernel in ubuntu 24.04, there is build error:

from kernel/xenomai/debug.c:23:
In function 'strcpy',
    inlined from 'hash_symbol' at kernel/xenomai/debug.c:94:2:
./include/linux/fortify-string.h:787:17: error: call to '__write_overflow' =
declared with attribute error: detected write beyond size of object (1st pa=
rameter)
  787 |                 __write_overflow();
      |                 ^~~~~~~~~~~~~~~~~~

This is because new gcc version has stricter FORTIFY_SOURCE( =3D3 is =9Dstr=
icter=9D than =3D2). Please help to fix, thanks.

Br,
QiaoWei
