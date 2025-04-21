Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAD51FC3
	for <xenomai@lists.linux.dev>; Mon, 21 Apr 2025 00:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745193943; cv=fail; b=cxDr2MnjwDmSNx5uXi4pFOIH9lv/Ai/e9Ct3QVaoLOdenzJlJOxe8xq4SK9T1EI0+LGW7bND+ui1wWHnqaVY8YxI7CZiaKjT3q3yYLhJw5vgh16ykTBLogU9Qzo/Tj006c0aF6foRaxvnrYL6htaHQl+5ru1h7YuBWxMvUz1Pwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745193943; c=relaxed/simple;
	bh=CG5/Jpn4NqaqN5M3QAqdCmyZVOeppiT+NvuBTxnWeDI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lMwtPcl/lKbP+5OASFZO+ThEm7AjMJpWh2W5DaRNZUb23vKzn6/pGnCUUCXLLyG3c81B/0pnzn7dTIunWOJtIvFI1hlr7zRi3siQEWog2KAbjkdy0rAZOVtA6hy7KQFHVuyuXb3LYg0l8XMXuxNFjNcueF/jdykAO/rmEqgM7Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gdTWew9l; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gdTWew9l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745193941; x=1776729941;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=CG5/Jpn4NqaqN5M3QAqdCmyZVOeppiT+NvuBTxnWeDI=;
  b=gdTWew9lKZnAZsb1Hd0SsY4kIGe33ZEX9j4BDQ3N93hSAwfDutyuPSQv
   Hg/gahxjagmyicvF+nO4UMdxmvh45IRVp8IAameaMImOH4XpL7znFXgOO
   sA90215lDz9DB9/tgNf4Wv1nmR6ZUXDx8U0Tawt5STrMIe3rlhAwaSjx+
   t14aj9y0mHxw7+w/laHIl6e2NIncqKyOTmrYagzXMKZPQia4MFKgxoFpu
   ugyzM1ePnVdRCr9XTuKn6MPfZhS3fkumdoP/XnI0IiH7x5Xvfb+oWjf2o
   l0/sXfzulydX9y7wG4Wgi6Ldpi8CZGE7T88nCl+Yivf1UaSuCgS2ZddbC
   w==;
X-CSE-ConnectionGUID: ZEYoTZ58Rrmx48DPCQejNQ==
X-CSE-MsgGUID: F51vfDH5TDmU84NIXJ6sZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11409"; a="58096271"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="58096271"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 17:05:40 -0700
X-CSE-ConnectionGUID: P5qNenNvTqiokbL2kXKkFQ==
X-CSE-MsgGUID: E06JuUWnTAqKGM2a5s8+vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="136731724"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 17:05:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 20 Apr 2025 17:05:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 20 Apr 2025 17:05:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 20 Apr 2025 17:05:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKkB1uFLvnQlwb05t4U+OlTpmCK24rUAlXNcHWqbg7G67pZyCKcIj4u67RhN+nYw+AjQ7gB120Zur8YRJW50rLBUQieYRTh5Y5ZJmEe3Kea/xwBRZrSsIPWTKoVlAVdmHmFKs/nItaqH0vVKdVl9248Zc/K+Nk96EwGgiqFJ3BjQs2YLEJEjmorphk0rDwsCM+cd7L+ewrMOpiKe/0WVFIoqzBOEAM8VImni380vJ6Jx8G8nv+38dVTUlZqG4NEpUY+tLEMvy5YFSZJKCz6PTMBSKZ/okVTWrnPPQiLGDNzFVTW/ttPKgPEfeqjIRHN1X/6cGF12vwU2e+hbLXmNgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CG5/Jpn4NqaqN5M3QAqdCmyZVOeppiT+NvuBTxnWeDI=;
 b=dQ21mGdoHaWPpg1EuC25I60yAMUsH9jdLPePh3rXA4H+Sp3+0I0VGduqai0XYwMF8i//YLTXsq04+A5tYRS5icWAQia0qpQ8tmk+rtiVcJeNJC6EjCC3serMCeORYczICQZjCoNOx804iFtDGspj5Wfx9Uw6zZK6i920bntHEJQmOB7N2kGatOmmwcRS54a4o5tYH79XeCIisgq73FjJ2bzQPdgJNdzqDHRhLHW3TmFimAB5eUGOcdMEKayiJM1vK5VRmAOiMPb6K68SX9eOAsgMYwuZa6xui0rI5hIwy1+jDG6Kmg+ozJAXAlmqkw+TUACy5ufElczLwNvYMj7Eug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6513.namprd11.prod.outlook.com (2603:10b6:208:3a3::7)
 by IA1PR11MB6441.namprd11.prod.outlook.com (2603:10b6:208:3aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Mon, 21 Apr
 2025 00:05:36 +0000
Received: from IA1PR11MB6513.namprd11.prod.outlook.com
 ([fe80::8012:e01:4c01:d824]) by IA1PR11MB6513.namprd11.prod.outlook.com
 ([fe80::8012:e01:4c01:d824%4]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 00:05:36 +0000
From: "Qiao, Wei" <wei.qiao@intel.com>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "Pirou, Florent"
	<florent.pirou@intel.com>
Subject: Recall: Build error of kernel/xenomai/debug.c
Thread-Topic: Build error of kernel/xenomai/debug.c
Thread-Index: AQHbslEbhd6wvGGJ7U6yV8WfO1nR4w==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Mon, 21 Apr 2025 00:05:35 +0000
Message-ID: <IA1PR11MB6513EACBABD467EC921E279B8CB82@IA1PR11MB6513.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-traffictypediagnostic: IA1PR11MB6513:EE_|IA1PR11MB6441:EE_LegacyOutlookRecall
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 374f66f7-3407-4443-fb4d-08dd80683de9
x-ms-exchange-recallreportgenerated: true
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/5gs2BTadTnjnNlazcmZwxobCP0vb3qpspCelAbHNerQeC8ppbb8Kkdj0iCY?=
 =?us-ascii?Q?FY+GD9pJicZ1TirwCH7PioGi3wKqVPdJl3leMVSW62xLuc6NXtUtO7KLbwfY?=
 =?us-ascii?Q?W0DMewlaT6QuO6yiTiiSl8IbdK7MPWpmEkoCxs1C6HZi6L5a4gigmlalWYJL?=
 =?us-ascii?Q?idhLktJiPoYH7tvOpFiIzQ4JakSQZcwj9QTpOAMUAlacyvJTMTQ7f8RvKSfD?=
 =?us-ascii?Q?PegA9jt2Xd/z+MhlrbfeI9Erp/c492KF2GgX06Nc2aqesAWKFJhE4RnDXrGf?=
 =?us-ascii?Q?yGJ5mb2kJjBTpOJLP0u8d28BgsynmJG4R6oWu5UUiUc1WiOf8wiuhcJ5LzoG?=
 =?us-ascii?Q?gtDeH+XndrwXUYqkt5SzH17I5s4AyM3GMJEu/3j6KTgC8RJB2ypnXL8PzXIb?=
 =?us-ascii?Q?bxgLk4xSSE8llvPkO1GS0DrIQajnyZdRJfNrr93aznykcnRtYZpSisx+fxkS?=
 =?us-ascii?Q?3IwBOWctjcCxEVqAUmtyNH+5MGaWmqVdeNVqBvOOy9q0ETwIQ+gCCRltACk+?=
 =?us-ascii?Q?jM7XuPFsxSvXis9zdEtVi1mJ9/RFwUmCJ35/KdQKVPXAywmo5Fr79q25tD7a?=
 =?us-ascii?Q?AL0i66Rm0uGCej5u/mYrvTu9i81r3BvUCqFWQi4cqp/b7q6gelJVu0lvWdpn?=
 =?us-ascii?Q?9bf58ZXvEXW7yoz+Nn8K4jpHPNxms6uvedUyej/ay+3BT9KN8nsitP0ddg/c?=
 =?us-ascii?Q?6uEfrGnYozYsVAGbOaQZbiM1zRYdcF12B8rcnZiBS3tzjrUsmZx0nygglvXR?=
 =?us-ascii?Q?BdbzeL3yot72Nn9//QleWqx8kDcwkqXSvfdkTDcC/q0Wa17j/vFjf/6M3zjE?=
 =?us-ascii?Q?/N7wzXRd/mdujOUgJKm0wPU6+VmaUQOmw/DIzyVCWv9byE4I/dkbC/AAutCb?=
 =?us-ascii?Q?YQNqEe0Qsu51LqDAPuYyl17X5M7XxpdWumLlo1z+6YI0/5BjS/Wf8MaXQwmt?=
 =?us-ascii?Q?PHuoputpXiRVmMDyU1bVfO9c+sr9CyWFHHNSoKdMnZOj1aT9w+8Q11XKRC51?=
 =?us-ascii?Q?M+2n+J+lrwineiUvoFKFbwN+If7kEB3QMfgUTPhomO/uHOtiQVYUgCwMi+Yw?=
 =?us-ascii?Q?5BxEmZx8czI0i9UG74ge4TRPSvrVJASRZvXgcggZwxWH5ELbbJ6UQNTg2Jsr?=
 =?us-ascii?Q?RwONlkrk6x0uU7OBYwCrBME4vdb/Rre6dgq96GhZgSlYPUlYUu9KAMDp5ijd?=
 =?us-ascii?Q?NLCtgGqtMYw6js8X9o4/EBlAhIKmqWYbQptHl1UBsrw4W45EubSObUNU3qEZ?=
 =?us-ascii?Q?z+Az+wdYLDso6YFyRSnoHubhtGuuc87RWrfGgGNYnKCk7NfjVgyQnOphLsPu?=
 =?us-ascii?Q?OA1uIwC2SJRun61AmvY/DqqrYedb7YFrgly9GJMXNX6XFVl+hrmyPIQT3Wvy?=
 =?us-ascii?Q?8wr/9Swp7hpaul9NlAXLRMkCmSKzVZIgqEA2HwNHo7rvTRBGmgQEC3xfCthk?=
 =?us-ascii?Q?vFtNnkv7SABfy8BZ6WLL7Ldp9o3MvhG3DvWPkG9HO3q7kelTam4y5b95vTLK?=
 =?us-ascii?Q?PAUOwxuUyXoPoyY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6513.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GN2IIBHAmMuIKavvab6iTaCtNUc/Y4Q7etAvFiyt7K4dZV3UelNsYwKJnhrA?=
 =?us-ascii?Q?FFvfbaqx9q9puRcndQg7pm3yTdhw0XjgpBKeqSoHFDHBBCD8tvJfhk2XvIIF?=
 =?us-ascii?Q?GP5mCwm/iN5bFGK7yuR4VGZNxUVfWdOeEfnGDEDbIUhEldnPzCL6ddFaDlTC?=
 =?us-ascii?Q?y4gysofaOxfoPhP+r84vjq3RH+82hJlyi1KXFeIQU7wAKzq/hJd5yU6Y+NSk?=
 =?us-ascii?Q?qfax+qSh9F92ayNavrqX39L8AvS/9dd4ZIeINA7ltoym/xzbFc5EbjKPDpj5?=
 =?us-ascii?Q?R8jt+/RzfAdXlAlHYDsBpfWLhA1zDh5ryPW3j6gAe93XFJIwf5RaBxnj4wXT?=
 =?us-ascii?Q?0VBajvwkvFD4CQWpXg/+IFUIKxw3xdLilPeH/vcBag+UnB1DRG4EOg6t6kDm?=
 =?us-ascii?Q?Xm3MTNgLRtT8bJp+XF8Xzv61zT+2fX53u5PYpDbShLGUbbPapoz5U2q9oUsh?=
 =?us-ascii?Q?Hwdkk5Lp2mb9iXcGcRXLuau5WGy1VWKfQlkZHc4Aa+ySjK2gYKiPS7Ic1CDw?=
 =?us-ascii?Q?hQdakITDuBu80QJK5+7yAaG7qeBaikYVOfTraUlrz+IYbRG3R4nCsgCYwIVy?=
 =?us-ascii?Q?tQQslro4McPhnTlW4dLoV4ZSIF6O96oVgkzE6xK/zhpPVf4AoDU5GPHiQwZJ?=
 =?us-ascii?Q?jQPFws5AqQ9Ab/Yfi1up3lztFFj0w325LesqZ2NYwTo8BYz1gW3zNn628lAa?=
 =?us-ascii?Q?6A42BE191Nu3YW0x7EOy1fBwxiQ06wrpUrN3mSx8Zf2JjBMNSloeUUaQvpqz?=
 =?us-ascii?Q?vkjA0VU2APyzGxmNvK+NKhMiu3CFzgSY1yMdp/tx1yNMSK3txIk9YcMpNDnh?=
 =?us-ascii?Q?fdGUTfAjYVewlAIYo2PcLv1r+wP0JghqFtZvR35ZYAghaAF8WyTRfe165NaO?=
 =?us-ascii?Q?eOSllPMsNbP8LWVw4CZ51ZU7xo44bt+QomwTxeJBf1We4VCS4ACu78/BHYXb?=
 =?us-ascii?Q?3tG4c+iUeJcB4XXNz7zKPcMnZ0NgR1nM+moc4HuC3sZAjtR0kZCkaFSsdEhT?=
 =?us-ascii?Q?WvkBT/dllUKwacPuW6qGwBrBWrmReRx31ffwwtDGJPqJnH5/Ulm3gZ+KRtoo?=
 =?us-ascii?Q?Vt3lMGpOY/4JM4xJdfOQ91dSBWxC4EyV1V+JttuzfG7dyWGvr0CGJDmgQDsU?=
 =?us-ascii?Q?4tI0E89BWz41uRi3kXWsWVSNhoj9Dgr9dod1lQ5/LFjyMCGZD83fbpwRwBBo?=
 =?us-ascii?Q?a1wNpUU5iniS0ANvnE/NnNcVaX6EfzmHnix76bNbo4DQsG3rUWEib+vi8EOm?=
 =?us-ascii?Q?OtTku/qSxJ2Tho659Ms/BGi8Kjv5Aefk/twaUEVM7tSgPX0UN8KfXFEiUhnW?=
 =?us-ascii?Q?A5PDro0JrgkZDNBbnQN+3rvAjAhrSR5aSFx+aGnJPxBJIW4/xwt6anr0/3iY?=
 =?us-ascii?Q?jXeu2exl2L2BDnN1YIup3BGpoDv/pz9Ev8n/63lLia12urtpoMAcK7MnbIBP?=
 =?us-ascii?Q?CcrkATYtYQv7Zwz3+CfP6g/+QgwGVb7epOOFpKCOzjx9A4n56a0/Vt87+aVy?=
 =?us-ascii?Q?PYOZF1W+Y8PPnT/Mteoliu3Kw15/2yyLA2NleEmqfRNXj/mjUnJGLixf23+x?=
 =?us-ascii?Q?hl0/G4xAghbMs3n0j/25Iihtqwx5tDmrQKPoGfQM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6513.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374f66f7-3407-4443-fb4d-08dd80683de9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 00:05:35.9964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RGT1yo6UN/GQqoTDxsRV39FNwrzjs86P5kraGnke3mOAbR7sX+jrmgOvTBgNaGjtHnXTFVmy0lws7MlVOoh4BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6441
X-OriginatorOrg: intel.com

Qiao, Wei would like to recall the message, "Build error of kernel/xenomai/=
debug.c".=
