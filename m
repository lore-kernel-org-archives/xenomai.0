Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B6714F122
	for <xenomai@lists.linux.dev>; Fri, 26 Jul 2024 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721987677; cv=fail; b=WfpsvK1n5pDatNh+oQ1AEOtkdm7e9unoMVB0pkfHsaI6NyTjcwna4ZFiQWT42t7zrxTtvukhHBqddhdWQcCJNywvTZUG7t2abG8KB5q1+3WcBfMQlIWc3d0xOlQsCHcaSBFBQLoAwcamlnSiJCSRcniIfSfY6lpvXtM90Ne0/IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721987677; c=relaxed/simple;
	bh=2p9WMZdjHN/NvEHMKpjkdq88oRKufi6pTctXVrhi84g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kZ4ovme+IOnepb1108aXRYwW2GE/cAT9ijCs3GzQHkiergoVMHNV9CypxNmVSZk1N3UTiNct9OilahlZ2kCw4FRd6rffQ1U2BSWSYy2b/Ew3/djXT67yYi1lLi0xRdkkjWB3YuEuOd7n59JdkbZkLx0pQVGtDT6e9pxYnHQqeKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OxWWTQHq; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OxWWTQHq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721987675; x=1753523675;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2p9WMZdjHN/NvEHMKpjkdq88oRKufi6pTctXVrhi84g=;
  b=OxWWTQHqwBMxPWoN2PR0uQoF742k3DjHskmO80ZXOqGjnD2ZT+R4ZXIu
   C20ol2NqXvp2/cG+YGy5CAIygJ1NYVBM/HjiX6i2Gcgcdy+bLNwa3WRUk
   2RTb1/2wuKRlsAoOawlymXzehKju9LiRmv33slCfVvWiNJKaX4jMcC1of
   NHcZrsDbw29S+AUotjHcZYFu7QRGP4hYy8Y//aJHK/JzpfunAC1NoldVa
   NV0eAOUL3UQD7UBEksKZh14vCcovvrqjn08HcDWbK4DRi7mbxLcalor4X
   pTABC6fQDeXi1zgRgebTJOvQ0lJXFG9t9Rqeo9I4oo1e7fQ9wJpMbpL98
   g==;
X-CSE-ConnectionGUID: Ue3XcF/6Qla7dPo1nXTulA==
X-CSE-MsgGUID: TY19qFUtQbK4TzCNq5I00g==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="30436891"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="30436891"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 02:54:30 -0700
X-CSE-ConnectionGUID: nvm7+SkhQO2znia+BBo2lw==
X-CSE-MsgGUID: G1HwuyzcQtWDvZkd1X6I+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="53999105"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jul 2024 02:54:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 26 Jul 2024 02:54:29 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 26 Jul 2024 02:54:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 26 Jul 2024 02:54:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 26 Jul 2024 02:54:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZDMICsxoDNsJEAU6S0lvPt360t43JD3YykyqXmwrZuKPvL9Z9hW89k7evvIf6MfjHcKkBd6k4YVxZfVSYc0iUa3a/M3RSEuYrIs7k/wmTTpM5cblPGqxPscKMco4ULwP5pswZs3FgcL4yz+Pu2xr91OjqTRrSrb8jRLOZH+g3Yg9Cj9+Rpp+9T2ZJ14azr8BUFoA0ml+ZhmkK1f6xYp3dKZJLM1XiwkMvUAHBQ+jZnZMsvAoMO9vn03ZKkNJv8acEKqmcC3B8yFtJUAVi8oPUOnzgePxRCxP04Wt5cwNZw2Vqh0DUS2yWc+XUQUHJhs3ln4fe+qUZaTOpS+Xv2j3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vItieC503BSNh4XYG+BzkiWXVgfBtJCpHttRmkJufs=;
 b=N1bQOToNcvxY6DS57NwNvASj53zQ1SSXp3cPjxZcuibNnFOsPXFQkgpwJkwn0ppJY0PmGe+RTRnrTmn1Ocsu3cglprtGBLUDn7hevzD2Rg5HzzeCtH2FRVvKDFO5FAiQvtArXXkQDHUdOvMn3y1vmE96NbOp8ZyZ2ADmQVmPQIQAyA/UPOpxyeSvDykrgJZ0yLoY7clnGjcfsy1wJgga6lmwz0C0Jc0JOVF5SsWS8MlzRk5qkeC7Vocj3fqbrWES3UJTFJ6qeVMkSuNcQjaLya1d0JbAnHQOy/FolwOvfPJdpGDhtmyg3tM+1WBrY1ngmuuELEYx+l1c7lOWziUN4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by MW4PR11MB7101.namprd11.prod.outlook.com (2603:10b6:303:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 09:54:27 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%4]) with mapi id 15.20.7784.013; Fri, 26 Jul 2024
 09:54:27 +0000
From: "Nechita, Ionut" <ionut.nechita@intel.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: Philippe Gerum <rpm@xenomai.org>
Subject: RE: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall
 <0x43564d41> - Firefox browser
Thread-Topic: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall
 <0x43564d41> - Firefox browser
Thread-Index: Adqobt1wsEThW759TTGOhdgp/60cKwD2+6CAAAAhQ+AABC7IUAAAPt4AAAFbp1AAB7gJAAywE7tA
Date: Fri, 26 Jul 2024 09:54:27 +0000
Message-ID: <PH0PR11MB5949453FBEBCA4520CAF80A2F4B42@PH0PR11MB5949.namprd11.prod.outlook.com>
References: <PH0PR11MB59493E21636F9CA955E2DE8BF4EE2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87wmnmq8v9.fsf@xenomai.org>
 <PH0PR11MB59491C18ADB51F5FEAEF4B3FF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <PH0PR11MB59490B50D2D2717B8155EFCDF4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87h6eprhbg.fsf@xenomai.org>
 <PH0PR11MB5949B24CB222FBB2D387BF24F4EB2@PH0PR11MB5949.namprd11.prod.outlook.com>
 <87cypdr5fm.fsf@xenomai.org>
In-Reply-To: <87cypdr5fm.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5949:EE_|MW4PR11MB7101:EE_
x-ms-office365-filtering-correlation-id: e9217da9-5158-491f-491d-08dcad58efbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?zldJT9GmmF03wegW8FdnqaoefyrsvVhTz4mvXLeLWc7YbBDCdzYykh9Z2Qid?=
 =?us-ascii?Q?Ko6P17rxklgRB1mlCCCcCTchcq2eq92y8ON4FGKSOE5DSO0FPzFiSRhgUkhf?=
 =?us-ascii?Q?baTnpJ3gnSz0lcLuLi7O3pTEFMaWN7GtaxGX57DWKcxL00p1eCf5OVZk5tst?=
 =?us-ascii?Q?3dRxaPs7Tkw8KQYNUnBMMnq2+yxgXL64jF9IYhZmZuG/WQcDlyFe0a2V/R1x?=
 =?us-ascii?Q?X17B9CzBWYAAYZBFwFSqUKh3FAL7H93Wz1287TgMuFgTgGWDc3T5TAmBBgcn?=
 =?us-ascii?Q?F/6hJbt+8qBvq8RGxolHxp4dE16L5JYPVnvQYDdZisfdQ60Oge6P+6TpcS2v?=
 =?us-ascii?Q?Ca33rO1OJM3zn+YK3/bdB5O0q9LS3kvMApaZn9HMaSHQMqR1aTm9uc8Y+zAe?=
 =?us-ascii?Q?JwEY4Hf2GEVjZ9aWbSgfdxosYeQMJEnQH5XA9llgic6r98oJr7h3XycO+oQa?=
 =?us-ascii?Q?Z7VPByMdIMRU/EQbZ0PjVXuqySNnvOKwywdxZ2+ayJFqR9FXU1cTcGr8+BDu?=
 =?us-ascii?Q?5TOcMtl3JY17LJLoFx5vZo+xzpXdmLqRK1IcQenxsPKRDG7OW2cC3X/ZesxE?=
 =?us-ascii?Q?NA7fWbht3L1GgC4Zlf25enUeUOqExa5Ks7cvQLVbyRmiDTfFIly6+5/doY7t?=
 =?us-ascii?Q?jOGclriSmWpYHAIYf+4VnLzMmMEW2KuxD9p/37oyPRLcWhuDha8cCKl8TyL+?=
 =?us-ascii?Q?Hy1WZzQAzaB2vsoBJG0dT4Rxg/OLfjsu0k7BMPycKNYEohvF5UgWhguOhe0x?=
 =?us-ascii?Q?Jz+zn9hHJRoRPlf5lnyNdqPtN3mJTAgYR0hdXdlE8kmuFsg2aOcBC5cNPu6E?=
 =?us-ascii?Q?XgsaxfhN47Cq5tZtDvYHUfE2MudUrF8o96Ve75zOQe3W7TNsOhaeq0qR6H2z?=
 =?us-ascii?Q?nQkpRSFq4xjk2klztf3FhfFnoH9DLVkYDOFTRxal8ggwNlR87Mtf4U7MndKF?=
 =?us-ascii?Q?1SJet4zBsxdIEp0MBw/Aao8PhyWzR8Xe4TcJsHx2BUPctPRWgFN1xfGEAY6i?=
 =?us-ascii?Q?50N6cKdzPgWblzoYPDpZdM3VGwD6toJ+8oAmgipmLOlh0Z6sZrw2iI1JjmIw?=
 =?us-ascii?Q?WTfR2wf89cx8fQeHJtwZyTWrkvPOTsuF7zfNDpvXDJx38Bk6niWRlAiOTGND?=
 =?us-ascii?Q?n+fWcWH3FHld6uWznf0+iEfiV/VWr/BKMhJpHUObsThySVHg3vJq4xoz68+I?=
 =?us-ascii?Q?PtAX6l1hGVrVlCytt3eSpvYvonj8zytA3aI4RqlFQdECh7whLVZsbUfrOnMg?=
 =?us-ascii?Q?9Rn0/pjSfhQFJoDBWMosshRPxov9t8k45lDAlA7lsgvDk8F1NRvG+45Mpfco?=
 =?us-ascii?Q?AWR4MOrKcL2chWqM4pxP1J8QA8F0XT+2X5tFqth0nDUj8om5usN8mDKqJeXp?=
 =?us-ascii?Q?ZUKxkUr7+uCR9/ex/4l95hqKtmG2rDafSen58W+Mz7duE40fEQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x3FF8vfYDoMFdhHw4iSQdFmhOvh/SL9xnDhw1cNmxA+n6qdfBvSYRkSjRebq?=
 =?us-ascii?Q?mXdgfyV1jCktdBNeLuknJ9XELSiKCHssbrAgYn57cXEDD8Y+P5LhnC1QQvUu?=
 =?us-ascii?Q?lgBirqOoRMZXFeWNqEwtiPWIgh2DCeAa1tWhmnjZomAxWrbifFxaYDnQmOIg?=
 =?us-ascii?Q?gUJtLGKwI+OeDcyYrJQdm2DB7shR0PjHjRJCGM0QL0XgVPsR31V8SKUdscQo?=
 =?us-ascii?Q?qT/C/AJPAmS+4sOoiX571HCFvKEfaUV8TMmV3KWZ5+yyYeRUIKdIOUfOKfh7?=
 =?us-ascii?Q?FOx9CgYVbTTktFvfCqaiE3zRSd3S1PhF32xwBsh+eRoFQqzaoTprDdbPiaUP?=
 =?us-ascii?Q?K8e0LCkSsjVms3JemK9dWsoiw9FzOp195cTr4i1U+lxPx5xCUdVvj01kBSk/?=
 =?us-ascii?Q?YLOIsOgng8Ck8ZMeJqSF0M0+mCk2b5P4GtoLzCBWld6+j3TnFuSSQ46jDiPs?=
 =?us-ascii?Q?LbLR2P7nvYvqgXtUlhdbyEQhS0iKVlVxfE3OBbd9QIz/jNQNvxav7AZYTRfI?=
 =?us-ascii?Q?3C5fQcvr8DwQSs6YOZXURN4ELHsl4Lq7p/cs+o+vnkeh0J9X3/aUkEIDuvIf?=
 =?us-ascii?Q?31y9HgLSOA7aKW/y+u25V1kBt2+s3jYsrdpHLATSoNsfZrxWjzdfw80VUXPR?=
 =?us-ascii?Q?j/tRb2HOlEahZrX+YXZKJcejMPoJecSO41PcfzF07YAiZStYtpbD8N7Uo39E?=
 =?us-ascii?Q?ZwFi2B75YOUVCGDGxs3Gbrq1y8sVBJtEABPnQ9GmPrhQK76B4GR4l03oihJM?=
 =?us-ascii?Q?H1KjTNMlZJGGawzxg4RbEtmUooTRdSI9Q7yhXnEBhnSZ71LuaFKEspQmxohB?=
 =?us-ascii?Q?pWObdslQffpk0wbuP4QkusRzYzwKtJFSRQV2eFcT6D4MvSedy9K4xa4A5h1D?=
 =?us-ascii?Q?rL+99phtAY/5WFp5nINlFRdIvqPpoMESDT/81lxSGdDAhENTAKJBg4viZD0Y?=
 =?us-ascii?Q?2GkaRLEld7x/z9dCxN4w3gCmKToPFSBWfNdSiFcqaQaqkVNe+3a5g/pW1w4G?=
 =?us-ascii?Q?bBZbwA7IgANc9x1q4RHvqKcahNVxG0CZZns6gzVguuahukHuVd4HoYt1VKfs?=
 =?us-ascii?Q?nKFxwK9CwDvZjG1A79fMT25mHTFNi24AQuk6rmVrR/lLViXIpq1Ba/cihmUA?=
 =?us-ascii?Q?f4lU01j/J3h0yQYq/BN1U9lajpW4Jxn0MtTOhVIKSGGoq97t2j5iULvChB8/?=
 =?us-ascii?Q?1O3gEvUL3SP1PzDAtz3sZtCm4LbnbfPShdHmFFGwZ8tx/dX3+a2SLmAO4801?=
 =?us-ascii?Q?Rsz9uReYBwskUs+6mBjqH8p1z71Mr9vxirHrlDQ/d3OPBz+t/V/+mjA+zqxd?=
 =?us-ascii?Q?dLcHMJmqZk1G9XPyCqaFw7Bt170wq+6lOgcK17Hc4IX9nOVxlNf70O8MTST8?=
 =?us-ascii?Q?Dccz8CoW2VwqmM7C0g1EZsUfrHq0tR3Pvs2i6ruWXzAiGrmDj/X4Gcqp0+jt?=
 =?us-ascii?Q?9eg3m+ouTwrk35ZXJO0ICQXQZItwEKBWzUseK5qI/VMk8S4k+H+rR92MIp/n?=
 =?us-ascii?Q?0Dm0CJ5vgy48mE1gJjGhs4ztPYZ4QFRmiV7bFgPT5yg41NAt8DgERqJu8ntT?=
 =?us-ascii?Q?SJ8XJal9fsKm3BMHT1OVneFXIrKzfKIzAGdKZJ1F?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9217da9-5158-491f-491d-08dcad58efbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 09:54:27.0723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GcQ3kefr1sw+qEyARvgrCDUz1yJ1EiF5Mmvm2Ay+gI0KyulEoW77kt6LbT9DZgNbrFmLzYrJhKMzudSBCk/T5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7101
X-OriginatorOrg: intel.com

Hello,

Any updates regarding this?


BR,
Ionut Nechita.



-----Original Message-----
From: Philippe Gerum <rpm@xenomai.org>=20
Sent: Wednesday, May 22, 2024 10:51 PM
To: Nechita, Ionut <ionut.nechita@intel.com>
Cc: xenomai@lists.linux.dev
Subject: Re: WARN Kernel v6.9-evl-rebase - EVL: invalid out-of-band syscall=
 <0x43564d41> - Firefox browser


"Nechita, Ionut" <ionut.nechita@intel.com> writes:

> I delete workspace and I recompiled again.
>
> And I have this now:
>
> ...
> [  163.204266] ------------[ cut here ]------------ [  163.204270]=20
> WARNING: CPU: 0 PID: 4270 at kernel/evl/syscall.c:272=20
> do_oob_syscall+0x191/0x360 [ 163.204279] Modules linked in: input_leds=20
> hid_generic usbhid hid rfcomm xt_nat xt_tcpudp veth xt_conntrack=20
> nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack=20
> nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype=20
> nft_compat nf_tables libcrc32c nfnetlink snd_hda_codec_hdmi=20
> snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_component=20
> cmac algif_hash algif_skcipher af_alg bnep overlay=20
> snd_sof_pci_intel_skl snd_sof_intel_hda_common soundwire_intel=20
> snd_sof_intel_hda_mlink soundwire_cadence snd_sof_intel_hda=20
> snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils=20
> soundwire_generic_allocation soundwire_bus snd_soc_avs=20
> snd_soc_hda_codec snd_soc_skl snd_soc_hdac_hda intel_rapl_msr=20
> snd_hda_ext_core intel_rapl_common snd_soc_sst_ipc snd_soc_sst_dsp=20
> snd_soc_acpi_intel_match snd_soc_acpi intel_uncore_frequency=20
> intel_uncore_frequency_common snd_soc_core intel_tcc_cooling=20
> x86_pkg_temp_thermal intel_powerclamp snd_compress ac97_bus coretemp=20
> snd_pcm_dmaengine snd_hda_intel snd_intel_dspcfg [ 163.204331]=20
> snd_intel_sdw_acpi kvm_intel snd_hda_codec kvm snd_hda_core snd_hwdep=20
> binfmt_misc btusb iwlmvm mei_hdcp mei_pxp crct10dif_pclmul snd_pcm=20
> i915 mac80211 snd_seq_midi polyval_clmulni snd_seq_midi_event=20
> polyval_generic ghash_clmulni_intel btrtl libarc4
> sha256_ssse3 btintel snd_rawmidi sha1_ssse3 aesni_intel btbcm=20
> crypto_simd drm_buddy btmtk ttm cryptd iwlwifi snd_seq bluetooth=20
> drm_display_helper rapl snd_seq_device ecdh_generic intel_cstate=20
> intel_wmi_thunderbolt ecc wmi_bmof cfg80211 snd_timer ee1004 cec snd=20
> soundcore mei_me i2c_algo_bit mei intel_pmc_core=20
> intel_xhci_usb_role_switch intel_pch_thermal intel_vsec pmt_telemetry=20
> mac_hid pmt_class acpi_pad sch_fq_codel msr parport_pc ppdev lp=20
> parport efi_pstore ip_tables x_tables autofs4 rtsx_pci_sdmmc xhci_pci=20
> crc32_pclmul xhci_pci_renesas ahci e1000e i2c_i801 i2c_smbus rtsx_pci=20
> xhci_hcd libahci video wmi [  163.204394] CPU: 0 PID: 4270 Comm:=20
> firefox Not tainted 6.9.0-x64v1-1-lowlatency #3 [  163.204397]=20
> Hardware name: Intel(R) Client Systems NUC7i7BNH/NUC7i7BNB, BIOS=20
> BNKBL357.86A.0083.2020.0714.1344 07/14/2020 [  163.204399] IRQ stage:=20
> EVL [  163.204400] RIP: 0010:do_oob_syscall+0x191/0x360 [  163.204404]=20
> Code: 1a 41 8b 95 70 01 00 00 89 10 49 8b 85 40 02 00 00 41 8b 95 74=20
> 01 00 00 89 50 04 49 8b 74 24 50 0f 1f 44 00 00 e9 0c ff ff ff <0f> 0b=20
> 48 c7 c7 b8 fe 43 9a 89 d6 e8 ef 53 e9 ff e9 59 ff ff ff 48 [ =20
> 163.204407] RSP: 0018:ffffad2bc3ddfdb8 EFLAGS: 00010216 [  163.204409]=20
> RAX: 0000000000000000 RBX: ffff934d7b378000 RCX: ffffad2bc3ddfe08 [ =20
> 163.204411] RDX: 0000000043564d41 RSI: ffffad2bc3ddff58 RDI:=20
> ffffffff9a759fb0 [  163.204412] RBP: ffffad2bc3ddfdf8 R08:=20
> ffffffff9a759fb0 R09: 0000000000000000 [  163.204414] R10:=20
> 0000000000000000 R11: 0000000000000000 R12: ffffad2bc3ddff58 [ =20
> 163.204415] R13: 0000000053564d41 R14: ffff93545ea52040 R15:=20
> ffffffff9af682b0 [  163.204417] FS:  00007fcdd4d9d780(0000) GS:ffff93545e=
a00000(0000) knlGS:0000000000000000 [  163.204419] CS:  0010 DS: 0000 ES: 0=
000 CR0: 0000000080050033 [  163.204421] CR2: 0000582e42dcb5a8 CR3: 0000000=
1147fa003 CR4: 00000000003706f0 [  163.204423] Call Trace:
> [  163.204424]  <TASK>
> [  163.204428]  ? show_regs+0x6c/0x80
> [  163.204433]  ? __warn+0x88/0x140
> [  163.204438]  ? do_oob_syscall+0x191/0x360 [  163.204441]  ?=20
> report_bug+0x182/0x1b0 [  163.204447]  ? handle_bug+0x5e/0xc0 [ =20
> 163.204452]  ? exc_invalid_op+0xe6/0x110 [  163.204455]  ?=20
> asm_exc_invalid_op+0x1b/0x20 [  163.204462]  ?=20
> do_oob_syscall+0x191/0x360 [  163.204467] =20
> handle_pipelined_syscall+0xb1/0x390
> [  163.204472]  __pipeline_syscall+0xaf/0x260 [  163.204477] =20
> pipeline_syscall+0xbb/0x190 [  163.204481]  do_syscall_64+0x74/0x210 [ =20
> 163.204485]  ? irqentry_exit+0x40/0xe0 [  163.204489]  ?=20
> exc_page_fault+0x99/0x1b0 [  163.204493] =20
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  163.204497] RIP: 0033:0x7fcdd4ec6381 [  163.204500] Code: Unable to=20
> access opcode bytes at 0x7fcdd4ec6357.
> [  163.204501] RSP: 002b:00007ffff1a5a260 EFLAGS: 00000246 ORIG_RAX:=20
> 000000000000009d [  163.204503] RAX: ffffffffffffffda RBX:=20
> 0000000000000000 RCX: 00007fcdd4ec6381 [  163.204505] RDX:=20
> 00007fcdd4c9d000 RSI: 0000000000000000 RDI: 0000000053564d41 [ =20
> 163.204506] RBP: 0000000000000000 R08: 0000582e42cb7148 R09:=20
> 0000000000000000 [  163.204508] R10: 0000000000100000 R11:=20
> 0000000000000246 R12: 00007fcdd4c9d000 [  163.204509] R13:=20
> 0000000000100000 R14: 0000000000000980 R15: 0000000000100000 [ =20
> 163.204515]  </TASK> [  163.204516] ---[ end trace 0000000000000000=20
> ]--- [  163.204517] EVL: invalid out-of-band syscall <0x43564d41> [ =20
> 163.204550] EVL: invalid out-of-band syscall <0x43564d41> [ =20
> 163.204589] EVL: invalid out-of-band syscall <0x43564d41> [ =20
> 163.204626] EVL: invalid out-of-band syscall <0x43564d41> [ =20
> 163.204647] EVL: invalid out-of-band syscall <0x43564d41>
>
> ...
>

Ok, thanks. This is the piece of information I need. I'll work on this issu=
e.

--
Philippe.
