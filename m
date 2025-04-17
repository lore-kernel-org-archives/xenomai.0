Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D68218845
	for <xenomai@lists.linux.dev>; Thu, 17 Apr 2025 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744877785; cv=fail; b=Jo11a3Qra4hp/PTV4liwpEf2EFS9f/U2WURbTw3YH5CrfjKgpXad2/EJ0lG4JTh5x/9+DYa0zEt6xptyxbflg6Dtt/L2La1kC6YNUq8EGvq/C0PnqtsjmbC3AZcfyKnzxQn2v1rzXvG7pR4s1hrR67UA7dN/6RLfbd6QDnPYPxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744877785; c=relaxed/simple;
	bh=CG5/Jpn4NqaqN5M3QAqdCmyZVOeppiT+NvuBTxnWeDI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XTcxmDIbtMlJIky/ZK3eFCn1Xsj90V6lLolvj5BXx/C6PsviYB97ePoIIl74jCJ3CkWz+fK8J1AVyjXCZ6F4p8rOZffukWiSGoJAsHYLKKksmfuMecUVSijxZqIwdIHtthX8wpHOR61uLGG0BgZmLXWfnocQDoJPJZ51d9s3fQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yu+/+Wy4; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yu+/+Wy4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744877784; x=1776413784;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=CG5/Jpn4NqaqN5M3QAqdCmyZVOeppiT+NvuBTxnWeDI=;
  b=Yu+/+Wy46O15+egII7Jf2jTjJ2Z8WZVuuzk2yBlfWxhosOk5vWYYboLh
   eRt4DRVDrbs05t2sESpIxU/JMCmvVgQ0bMLkYu441MpbhBZDEkkdunYqR
   yJYx6CQoTw/UpMN0b+dN2X0cn6/mGB6of+5hmQdSxOCmbI5JG94wOqBxJ
   KG57cIn+kyJLqwqEjbVBd3mnxXJrPrRqoxW2RGP6F0Xww+eqnJ3XlGxaP
   ZZF1rvLyL2itZ0Mdvzy8E4tOYHl1Fo82wUR2CTWI8KoBUy61/8PIQUzZv
   viooqIi519JIcm1YxdQuAsTgHz1hsg0rlLRC9Ch2m0j/pzd/+pum4atUD
   w==;
X-CSE-ConnectionGUID: nerqCfoOQzS9FlTC6NQBWA==
X-CSE-MsgGUID: YVojwxgnT5WgZADNBgrFlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46350175"
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="46350175"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 01:16:23 -0700
X-CSE-ConnectionGUID: ENZj53/VRaa0kZ1tq0QGbQ==
X-CSE-MsgGUID: iKEtQaclRamQ9DIHE8M9Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="131264021"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 01:16:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 01:16:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 01:16:22 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 01:16:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Io8InFlSX/Dh+yxyWqE/1BokmFaZsf1WPUVVGE2FdXphKaNkE2ahpJCMWFe1yRHLyStGOT437gZUjioNWp0ceZFQ0UAFM2pBtsTvgIQS5YJIzbgmG5gBo07WRG9SmNhUjbdog+yLtY0lHXlvNEiI+Vvp82CO1OCpL23LwkqI0sVUAiOsWpMyBBuBI2wI2Hz/DJWXOOP96wi39nVH7grT5AxcHJFVc1kiIrJC1GS+ezfaIaCWcjuCgLV4AdGLmf/Bu+Cx05u11Nv+4oL/F7wisCeA8AMFMerswkkR730BXOsFpeuvTUkN9ytBVbTT9Qy8arLo9H2W8SDd86v6oCGXQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CG5/Jpn4NqaqN5M3QAqdCmyZVOeppiT+NvuBTxnWeDI=;
 b=MuZzPymGEMjoSchJopPdz8QMFf6kKZfrJX4qinNDVckJT2fbtLj/RVjWwzkNM9bG4JtA4IeH/09X8Mdn3Fgz7v+6olTXwebj1okiAgEDLML1ZnHnMWmSdq9OIM19Mtus5q9jkl4jhTMsk1kQW7fT07UGRzcjkWJBomXD25U6qM+BupWCGLRXvSCwP6ApEun112HNfq1DLrI2Cerg7s81Jc1gWmHTRFB4cT1nwg2Oc8Vpj4gmNB+oIuP+HDHPVD2vjTAcf64O4U2O8vSvTWhLRelknXpT9hNN/QlhzE5FdG3KA+RGRdqcRbkMiMRFFYs9GJmvb/9/XtSoWVWNj1UrCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6513.namprd11.prod.outlook.com (2603:10b6:208:3a3::7)
 by BL4PR11MB8847.namprd11.prod.outlook.com (2603:10b6:208:5a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 08:16:19 +0000
Received: from IA1PR11MB6513.namprd11.prod.outlook.com
 ([fe80::8012:e01:4c01:d824]) by IA1PR11MB6513.namprd11.prod.outlook.com
 ([fe80::8012:e01:4c01:d824%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 08:16:19 +0000
From: "Qiao, Wei" <wei.qiao@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: "Qiao, Wei" <wei.qiao@intel.com>, "Chen, Hongzhan"
	<hongzhan.chen@intel.com>, "Pirou, Florent" <florent.pirou@intel.com>
Subject: Recall: Build error of kernel/xenomai/debug.c
Thread-Topic: Build error of kernel/xenomai/debug.c
Thread-Index: AQHbr3D/w1AUqsAHp0O3GJSdt0SSTw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Thu, 17 Apr 2025 08:16:18 +0000
Message-ID: <IA1PR11MB6513489CCA6742725B13A8908CBC2@IA1PR11MB6513.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-traffictypediagnostic: IA1PR11MB6513:EE_|BL4PR11MB8847:EE_LegacyOutlookRecall
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fbaea9b-7307-4226-6292-08dd7d8821a2
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?yEsgiVxeq3Nmdl9PG6wXQE3wpT4drOVqLcZ/9g437b3rOfYrb0qrOMKRpjSp?=
 =?us-ascii?Q?gRDzTsqQo8P+7jOuoFYfBnf9ASOB4v3l9yEMy40R4hnc3+d0GWfGeLsUYCXn?=
 =?us-ascii?Q?E2e/Luty2Vfmn7qBSYQ43Isdbq4k3pi8IvICpCqaR7pxaqfR7LHuwsdHjlOc?=
 =?us-ascii?Q?eOK1nszF/c2Il/QLPpQ4OoYRefuIwvURa4QD0qdCYuRO09JAkSVsO9HXJiUf?=
 =?us-ascii?Q?BNIlQmdP0rJ5hFqhh0QKnyjrejz+aqVLFqpoOLihO1zUdk69HA3A7m9MdzuM?=
 =?us-ascii?Q?qC7VSIqmtF+xgASrfJ1PIK7CLFHhCKilCfL04NTCmtUxLqdDobSnkXSW+VE4?=
 =?us-ascii?Q?ZvOMVSBm5tJogFubC8p9T6KY5jk7xSmIgRFHDbkC6gsOJr4gE8EdrgyLOAEO?=
 =?us-ascii?Q?kv0ulhfDIZmk31yV2ZKEbJjgXOtpBpOkCfj2xtkv6DFPj0gZr+cuQA0dNYgA?=
 =?us-ascii?Q?wC/OZTt0cgR8SFxIVAKw7RwpE1/EXoV6tqfPL0YoNaobWyarutG9qo7I7OoS?=
 =?us-ascii?Q?bbYX6GLruV+t/FC7O5OYI+l07WOxuhBBm8HMxjjK5aitTCITUJhbzHYZPXXd?=
 =?us-ascii?Q?TrhgsNyc7HLsjRCcqUU0D3dYAJuBS9NseQDuUxcAnr/kKX2u5JuOpM6pZ3aF?=
 =?us-ascii?Q?rihAeCewJCj4yBgUEEwDgt91wFdxEd1gTCvKDIcQeY/ruAXSGCcJY6cktKsu?=
 =?us-ascii?Q?Dd2x1hID0RuKAOb51J8Oh4vCZAo0DsZLto4V+KTAm1tslpObC/6mkp1c83Pm?=
 =?us-ascii?Q?PdIoeBrU5toBKLObH6ILJ2NwMW1vhj6q68QJ2h4skF5rF6ngKqwt71pQkPq6?=
 =?us-ascii?Q?hlJ86UEcUrca0vQBKpxHy1/3O0DyF77zm4SuV27QeSXKczv8l6OnnRsPCLpa?=
 =?us-ascii?Q?FatGiPbrMemYVx+l0LBdBmbk1DDdE8UTwGFOd3irsJ7MC3UkzjVbEGIRS/GR?=
 =?us-ascii?Q?A3CnXhTDkRGv6wlK3BDyZGJi+5JCb097l4Oz6hL8zkZNVHyn1hmj30e+Gygj?=
 =?us-ascii?Q?Q2qHeDncWzxN2G1PxgzZ43R7ijnwzj6QALsTTBs7SMXSIbMLwoIcEhznP5Vu?=
 =?us-ascii?Q?5pAMjKQKqfDSm1NKWlvRK/kyoLCiz3lgrYzC2iuEK9jEF8o9+g3p4nH2MGMy?=
 =?us-ascii?Q?/XKJYRTVIh0Or7HMwRl1hkdKJvZuizyUSk2e/WTwLkbJQNSabinj0VQlXBBa?=
 =?us-ascii?Q?C5WNA/OPyf9br2b55XrKwLJyrsI3ZhSIjPrjlofhAPLE45BOjklkQgXiIV8C?=
 =?us-ascii?Q?Lesg19bJrPDoCFbxt5xdq4kllSxk9AiRWPh4UxUSNoIEbO+WWTEeAWQzyRuQ?=
 =?us-ascii?Q?f8TaRF69hlWyM5FDmwqtxNsU4HiqD9jA/L2cbI/QBoe/3+BuHAiWbpsTfR+T?=
 =?us-ascii?Q?qaFme21C/6ut7PxOE0UWM5CiHAGCg3AoDO2pwVn4XJaz4JJezkTkpXHA1M8v?=
 =?us-ascii?Q?EbQXGm45L97QQiL8t9imfewCPkSPxKDoAJ9TlLmsJbvlABO3hey1ox7KZnpX?=
 =?us-ascii?Q?/IMOFUyO5YFR0ug=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6513.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TD6TWV1NGAWqDRtNtx1ITW+73xXw2XDErxUpEf2M9bKv6vWZNhqIXY96Bt2Q?=
 =?us-ascii?Q?KbiAQRnVY7+MKGwnzevNCcg9jPrT8FIa11lhmHryAUmpHL7WvmIfnwXvLkby?=
 =?us-ascii?Q?4FT6SuPfx1Ma8nckDtwFXmTqBnp5Yx5KKgviqAxs0aMKoXNvOe9qUt0oMryV?=
 =?us-ascii?Q?SCrug21Z/oVa8KK3BUhiBi2JjgSyf6KP2wwN3QR3yjtv5Oux9uzk01Y1+Kyf?=
 =?us-ascii?Q?x0XpjSqMkSS+6ewLpsr/h/u5/IXO38o5zQ9ONJMO7ETfZ8OS3wnX6tgfauLb?=
 =?us-ascii?Q?TvnylVzJollfT8JaWI8O917LQEO0P/IfJJV1641piYxEBMttj6CiwFClR3UH?=
 =?us-ascii?Q?JPiBJ7XvXfjdJxU5nI4cpOpPKHkAWX73fSekxbvmGAGfeYok8yonLvW1TzB8?=
 =?us-ascii?Q?jAjn/XZBu4+MdOPfFeBj/4ujEhOL0S1L36WI9rK3G+hnJMNCLzTjq+541Bwq?=
 =?us-ascii?Q?9m4BsWeMZ7VzK8A1U1Hr0CuBAMG7RlO4ruS58S/BsQCuL6g3bosxip1zrc/z?=
 =?us-ascii?Q?MSUhZDRc3+BpkigEhy6zbVwz+pCKMwMJEs8//tPgXffQOn3uzFPB+6mLM0MN?=
 =?us-ascii?Q?zORtAU7OD5/dVD75T/QqswB7sT3jREVbT3llmeusgZyImaT6awKG+0EfvniQ?=
 =?us-ascii?Q?Y8YyN0MX3WRGN+tjTaDQJ93Q4/bLfmK9GiaItAYoc+pFJc+1OR5cpt9DttRB?=
 =?us-ascii?Q?PZ0BQmmaLR1ap/I8/UQy5LCv8uXaDvhcQxqBv0/IfBcnI+eAegq8TudlseFE?=
 =?us-ascii?Q?/NTYw40dJ33yqSaxRTCEghjVJCmsBlKR8pvHkEfheVEQ/WccqF+MtACedrct?=
 =?us-ascii?Q?oTwbZ9uaFoF+eyxp919YCTqhPs+GwOIpU2FeihPPxbmekk2B29wrZBPKuqON?=
 =?us-ascii?Q?ukeJnPB68ICHH68mu/AmJe/V5wUSj4DYpuTBaAUCZmPFjUcKoGe7158XW5eS?=
 =?us-ascii?Q?tAOj1bokmfTBJIYi7G50ML6YnsPx4SivVi3P/IpTyVW+McV+rCep459sFqIi?=
 =?us-ascii?Q?n5QuzJ0PMx5zPJo2hvscwhulHTPqPvu1RjXOpJU12XIa9qd7ocirtxWsN0ps?=
 =?us-ascii?Q?If5pO75go6nB0qB+sOnHjkDUi8agcwa8LJdTcz2kBrzeijziVLAvpCKfs3bt?=
 =?us-ascii?Q?axNS9nhLYl21ZZNsyJEiGn4nWdLQ+5IXJTdR3vuNYq8E8QHtlja3/UoKX3a9?=
 =?us-ascii?Q?qqvL9KKcYQAjTv9AOxTwSaQYuCj5KXmK71iCOSN8lQXT6LgY4aWmI4dtMrK6?=
 =?us-ascii?Q?XC6Yo9M4GjFu/D9c9JFdlqpQPaEao/yx2bwDW4DNuY7oI6MeEHdsLtNwACo5?=
 =?us-ascii?Q?Gova5heu0sAiz21CTCwExoeAVJtd/NgNwQPf7di3ylSsSvwIzjrfZmgqi5Ls?=
 =?us-ascii?Q?3PqZ+OnsDNNXVev7wemaUoOxUzVE9IHI2oGl3fJSt3YP9v7lrmCR9/i9hpw2?=
 =?us-ascii?Q?ytpi0Z22zCnz7QATRTVD6f40b5+A4VvsE3VkXKtqZH7ULdc3dBbkn123wkB8?=
 =?us-ascii?Q?sFtPRFf9Rcl/hrDZHiA/5PDLKLHYfLtuwSFFFQfvNybpCgSkx1oTpyE49MAI?=
 =?us-ascii?Q?wqGCVoTIwd1mEX1Tp0we8dNzSn2rk1yHSJx9FITA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbaea9b-7307-4226-6292-08dd7d8821a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 08:16:18.9314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqwfbWL+bRruaH0WbESkQBDhcTHeYqRHEYibwAQ6yQxROiSQF1MTPXDqSW1b9/X/218QIJwCg48hgWSPiOZoFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8847
X-OriginatorOrg: intel.com

Qiao, Wei would like to recall the message, "Build error of kernel/xenomai/=
debug.c".=
