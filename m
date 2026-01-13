Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4923712D1F1
	for <xenomai@lists.linux.dev>; Tue, 13 Jan 2026 01:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768266331; cv=fail; b=YiOznfYPQ9ZNOi050IrwQSWhXnqcLZ2s7URnv70lKUBu3nnU33gjYoR0Nf/vzp6jHzqJVrMTuX/y21hTJqm0rjN81K8XNWCt0GAv4mLGQRUeQFwI0NvgTM5aXg+AqRt+s8f3Jg3u8zoA5WYixAa/5Z5rIPTGSiCyeFHokiTpwxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768266331; c=relaxed/simple;
	bh=I9S+jfiynDfd06VneavLFmMzB550dayuEnumze16PeQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VFFYwMnXJsI+9TQsnOg/nxJ2MPlMmDc1RpKhDyVCVDqnN3+mtK9GYDyRDGUedWhDkrTXGyPbd4eoioHAoytMh1lhQ/817RLWqrNKaSDh/X6szgu7FiqYnJ1KaKo+gdsgy3pkdlzSM+zIbWQMKIYmYLa0c2lrNOFTVo/lv2s9POk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OxAEql59; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OxAEql59"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768266329; x=1799802329;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I9S+jfiynDfd06VneavLFmMzB550dayuEnumze16PeQ=;
  b=OxAEql59mTfDVN0nW5n8qfpCkXRTMEVh+KxexcoXsSuqiW2B6/Br4plN
   f0yL8NetFNRrP2HSxF6IWSWQXubb6ZfokKRdepmNPz/+cTAzPaw5TWFIH
   /xiUdzRDnt6rjvRxYSkwdpxybaGJ/WzXL/bMSdaGfdatBVG/RF6XVgzr2
   e6pjYIR4tcm9GIz3Uif4wOLXOmizBvrizeQ8p96i2DNFyHyAuvBskRPF4
   VyYtpYZ4Tdm6nKC6aiedcVn6THlsDo08KoKW45s8zzcw9GmzraB5UYKjp
   HyksugC8ywJ55R7nGuV3YDc8BtkDSdwWBGzFcpV28GmtZFB8etT955FA9
   w==;
X-CSE-ConnectionGUID: EBlA2GT7Suiwsmsp3ZxXMA==
X-CSE-MsgGUID: U7YLsb/KSIa1p7R/jkFBIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="79843388"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="79843388"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 17:05:29 -0800
X-CSE-ConnectionGUID: iFcaW9hHTOukvbZU/Pkdsg==
X-CSE-MsgGUID: HU6ldD1KReqRkVDhLa9S+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204640451"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 17:05:28 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 17:05:28 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 17:05:27 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.41) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 17:05:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXFoSt/DZWsJKWgiTKI3my30qJj196oV5liHHtXJkLP2v05ZE5e2ObmwM8mO3h7itNYGu4aTya0aACcoUGQ/qHk7eukW3pAUep6s+5/wEPanADl+d+OOLW0DizRgf2tJZWgEevJ0KGDcagt0x8RfXx4RvTO+nH0MafmTDQ1odj07k46DBAp9dPeULZVHhFtp0m5+ovFP6NtCFrYpA5IjFyHOpLpYaJ8/DllpHtWinXX+f09Qr1qkhq/MZvnFHeh/kjD5dS6VnGvFugIW0WkXQ2UPloeXDZPgoBdzgcPC1lNkjEQFAgXwHLpEY8bUXSEuS+v2B02xfSbOFwfaug/X6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWVgWknPSA00scnaRr2oluvPYwWz4dTSEetb/rvs12g=;
 b=l+1cVec9M3BJMbsZ/wGa37Is4YZTFjizFmQySeusN8NS3mLMwA7Bf/R/mb/AhIrv6NgR6UQhqG0HldQXIURW9WAnmiT8nn19L+vUUpYZ2gQPpOp+UeWhFg2/VS3DrC6d6onFx1BtHA6sVMiF6dA3gu0VskVPISvvGsqeUJnsxFvnnZGaALq7LXgFdX2z6EozAxUaZvj8C0C/c3ochnzFXJvd0RSn0SET3EeSkkqTOV32LHz+bP1+ToD3jfLBSg4P/ltbvj4rpBuG/3cLp+xCqsn06LTClAIMDJefssqG5Ou1vNOK36dcVNcQnj8E6vZhHngXV4OFeXnjo7veey9PBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8134.namprd11.prod.outlook.com (2603:10b6:8:15a::9) by
 IA1PR11MB8198.namprd11.prod.outlook.com (2603:10b6:208:453::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 01:05:25 +0000
Received: from DS0PR11MB8134.namprd11.prod.outlook.com
 ([fe80::d95d:cb19:df8f:1610]) by DS0PR11MB8134.namprd11.prod.outlook.com
 ([fe80::d95d:cb19:df8f:1610%6]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 01:05:25 +0000
From: "Chang, Junxiao" <junxiao.chang@intel.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, "Wang, Yuan1"
	<yuan1.wang@intel.com>
Subject: RE: [PATCH evl 6.18 2/2] evl/net: export sock_oob_bind symbol
Thread-Topic: [PATCH evl 6.18 2/2] evl/net: export sock_oob_bind symbol
Thread-Index: AQHcg6lQcHIH92hznkSwcNN92wWI87VOkYhdgAC2THA=
Date: Tue, 13 Jan 2026 01:05:25 +0000
Message-ID: <DS0PR11MB81343C648D8B2AE5100C453CEC8EA@DS0PR11MB8134.namprd11.prod.outlook.com>
References: <20260113094852.2806192-1-junxiao.chang@intel.com>
	<20260113094852.2806192-2-junxiao.chang@intel.com>
 <87bjizorlw.fsf@xenomai.org>
In-Reply-To: <87bjizorlw.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8134:EE_|IA1PR11MB8198:EE_
x-ms-office365-filtering-correlation-id: 1a479f76-c791-4a55-e4fe-08de523fd5a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?rbsmj7+genlsFZmqTb2IXqee7TqS/F7GwmjnMbR2OwcAZ3VXtr7zyPzDcBmm?=
 =?us-ascii?Q?A/K+MGdmS0paMVkSNXqvJcgZk3evreIs5Ec00rLbAuX4ZtRTknRGwyRE9j2Z?=
 =?us-ascii?Q?JfqNPzCkrAIsdl6VV1hXQUD4K6+ZuNWhibZHxR7leHn/tWZojKsgMBtNxhAg?=
 =?us-ascii?Q?tBv3y2YA+F2qw+0qE+Bjiyzdi8EfEFZ5dgz7KWQzMuwps4NVmKyhwodKgOq4?=
 =?us-ascii?Q?VYLFYdsPqRm3A6Qh62YxYLI2rY4IwZed5xMEf/Z1txxn7zTwwIba9Hj1Fa1+?=
 =?us-ascii?Q?ttPGyj1J9qkDzKW8FEHgJW3AEow4/CGuZC1NJLw0ZZ9yydspZE4APTvs85ot?=
 =?us-ascii?Q?RLCFxkRKD0oSzIEXGz8Wd5+Ks6MdgFDBpnbJEe/DegRkOoRI9Oc3Xe52JP/C?=
 =?us-ascii?Q?51BHyL/1X9UvfOO7CPdXDYWQ2kd/Con/9ZGGrtC2Yp+vYam/UJ5fqfvpAFgj?=
 =?us-ascii?Q?YYVpwcu2zJYVuOcV2ff4DkDp9kLFFjMJdCvCERajF4Y5j8HKTpqpiVeo38lb?=
 =?us-ascii?Q?R5iHhG9g8zGgAZEa4Cuk4g7+ubUZAdcZStc0GiBCk7iHSozSJyDBd1w7S1OD?=
 =?us-ascii?Q?A9Y/g3Y6YUD1o3zhj4x8dI0ZpNRUCi60vHjaHesNfCry4jI4uL1fL7fIRa/j?=
 =?us-ascii?Q?gJkodvkJC5uMihGJ2zGwHwy/qTv4OJXScRR8wmogMKX8rpeTpj7guc3AApbB?=
 =?us-ascii?Q?cHyQaYpBqfysMBuxrf0FqJH2llziUAH1FRIZSSceSjp4DtNXGEeBmpdEpSHS?=
 =?us-ascii?Q?k2y525DyJPNwy0TXAmd/Jg/uwrdvBH2eB1LKnzXFh+uQedINFe4IMYmcNwQb?=
 =?us-ascii?Q?GnO+CVgmyZtjmNLMUw74ZwSorvWaXxkAiQ4L1wZOva0kZhB5TAKkiHyzwgld?=
 =?us-ascii?Q?CnTex3T/Bk/ifJq8/VPmZ63QHXtd4JZxyV1G5g0B/k7KwUSdhUf5FdzZ1AdO?=
 =?us-ascii?Q?UaZtjaxAdEPp7yagaL+E8Bd5vkUqH16QE9V1rvKAlNqQ10xkr4bcdnvmEOcH?=
 =?us-ascii?Q?jisEDjc31/NEbafYmJ/16rwejxXWMvcJ4q0cBTMRZPPGPwiwx8l0BdTWGujb?=
 =?us-ascii?Q?jGeCsoQH6J3ElUekxlbYHbCvIi4VONVzhLgiSIdbQC4NxCU1m2n7dBprWdNH?=
 =?us-ascii?Q?N0zNLaiZnmT3A6C30YBSzbrBAyBfKbMmGzT0HxG9MYUI63IGYYnSQkzo/lcF?=
 =?us-ascii?Q?D8GaIPrqyZqWfXSqGr1xPexskEe/OpHI9L54c67ROIm9w4cQYvF066GH53T5?=
 =?us-ascii?Q?90V84GH40TtjYF0VWXPS3m2oBpyYaEa1/J5Z1mozBALt8tM7u+JkmBglxCyU?=
 =?us-ascii?Q?Ce6lrKynqZp0iJZLq+D6/c/6X8WjGxMReVNc7Y7vrlYOkqFMGQKL5liN+lyb?=
 =?us-ascii?Q?ZTACAV07hkft8qqa2UBmJx9Mg++xhm79LRlqm1yxj9vbYZovMZMxP9mkFfWO?=
 =?us-ascii?Q?zvWMe5r3/vbrCrCmuxdWVhKSrn1Tzfo8D7Sn6mOsB2z2uiJi3QOSlym2EYMJ?=
 =?us-ascii?Q?OTrBL2W8kNLOCddny1MLKJZC4WBcrYW5Qfr8?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CVZ7YmlJP+AQGEOhx+FIkAtTNpV0qWzLvKmnflTyw2tCrza8KngDHLjzZtIx?=
 =?us-ascii?Q?Bqhgj/UAXqCOqpX4AkjnaIthN5LiSAyAfSxybDQM60lgwJOx8AkgxDmv8+A/?=
 =?us-ascii?Q?zRlvM0ZE51kkxmuzfAXrabkE/egjypOMygJismSqm2ZdXHqiR0ui5Z3AkpgF?=
 =?us-ascii?Q?hMooUwmih77r8QX5PMl8zuOIi4snz/ckPf7VaC3qARVdkfTp4S84u901ENCW?=
 =?us-ascii?Q?33nBmE2rQJOHDu+7BlKo8PfhgWlRU4fpGMVtB2RDDDNm1Av5DVckUJVkK7Ks?=
 =?us-ascii?Q?F5SXUhxi8yg0Ia3hVzwLpoHnsMdKK4eVRkna+Mev4kWpbS18i0Tgh9/g5CKf?=
 =?us-ascii?Q?KAk4O0kCCrcT3UcZrWK+cOng1MPycpGoGMxwZFz1cIh/o4I9Q84+y6TlWhd2?=
 =?us-ascii?Q?KlzF6VjJDuSrUWtggVkPfT7Kk5ajLRX2CCVH9jaUsscwH54X1nEOimaYoN3P?=
 =?us-ascii?Q?OUL1VMbUlgElzArWrju5Q1QtKhDQiWtpHUG29BUV99qL058gbw8Hm+FaLUyo?=
 =?us-ascii?Q?JXNy4sR8akA/EVNC+G+F5ypjptxrXkc4UFO2nNxg+JSRsgLWzxObdwT8GL58?=
 =?us-ascii?Q?BW9o+EN6anzbr5ybw80SNHNF+Jm0bIx8vNW56v5t1hPpcAH9WiOGtHVy5ZXg?=
 =?us-ascii?Q?BWLpKjdoozYgtQKfQnrqEhZn/OpooVtggQBohcMcBCdPDmDrEj3Ce9tHy9/X?=
 =?us-ascii?Q?W5ZZm/L82AK+R2CoSuMSn/ttwHIsU7u+nOhTgMmhojTojo6ON/rtLJVuK1PO?=
 =?us-ascii?Q?qCsXldZUa9ASmdh0Z7mfkeXbHI92TaMwTfO9maM0f85gvehrJyfvnZV4lXEF?=
 =?us-ascii?Q?fodmeik5NEaWc5V2vJbfxewJkxqpNdVkkaTVyGu6v9ai7gXlgiKUnTuV+cXf?=
 =?us-ascii?Q?MaYhCSsUvwPxeSNOXUxhhoBYLa45r4A8yQCqh+bIzSeaVCgCIgQY1QDxI795?=
 =?us-ascii?Q?6p2xgk3DnY+tzneTNceq8C/KY/37hHUCZ/b7OVcY/WqCSPev5EFp7o/SXD2o?=
 =?us-ascii?Q?dIG3cezPj/zXbTjG/0eHS2Ri9wOUDE7DR8vdj7vkIP9asEQxH8iSyn9tNWzm?=
 =?us-ascii?Q?ovmUfKa/zRU7WxHMu9O5gGSsnysq9o+zdTXTpWEV5QuqlCvgHgFRh0KjlubL?=
 =?us-ascii?Q?p1VVFyj3kVf78NbbBPZqFPVUHbXc4G0nCRY7vBB1tlkYm7s87WHBeycXiHtH?=
 =?us-ascii?Q?5MNiK3NBy+clS6p9gDspOMtlvKbbYv75/Ilio0rWi9hdtN+IhMq7v68zXrGS?=
 =?us-ascii?Q?lJTCSrvEksYuK05oDkdSLnKQX1LRUhr8WYPg5QYI6DNgOT3YsSkyJH0omkuk?=
 =?us-ascii?Q?XImtrXaxs1wRTDkuApaUxYedGWRvEwtzJh/xvt4kX3168zmoN3XgqhrYxFlZ?=
 =?us-ascii?Q?AMB0W92TSdzN+JUCw/nEGLn5RiBoTnPTD6n9MdA9PvfSpU/4u0ZguC4m6Ct9?=
 =?us-ascii?Q?vP/N1qnbGTCsm/i3ns57bL3fAZffZ2ZSGgze/xZYzUq6oFmZH7xu2CpsImp9?=
 =?us-ascii?Q?/5NpxXInqSfS0irXSuqQcVBiKrL1kQ9URgFYGw0c/d6oGiz6u8gH4s8b7P36?=
 =?us-ascii?Q?QA4d8fDuQhjTkdIhscXmXg4OkBd09jvtkEzSeovq3YaNTQnB4XiGYxoHGj6Y?=
 =?us-ascii?Q?YqW5NdkYMBnOsRRxB4lStVB6r/12TAYUYLJP0xmwrvKfWWT+86FfZGauFcwE?=
 =?us-ascii?Q?hxy39BmTJ/79b0k6OfMVN+dj+F3sV/KVGDjuq+qo7qhtERyttTpDyDbYGd+l?=
 =?us-ascii?Q?0LmbE64UPQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a479f76-c791-4a55-e4fe-08de523fd5a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 01:05:25.3142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CNIdZR0JJa423Cjh+PtEo+yquue81kC0IlekQl9IFRK1qVF2kymMDlDxRsadXtVSlO4XsYXPHqcmAHrek86qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8198
X-OriginatorOrg: intel.com

Philippe Gerum <rpm@xenomai.org> wrote:
>
>Junxiao Chang <junxiao.chang@intel.com> writes:
>
>> API sock_oob_bind symbol should be exported because it might be used
>> in other kernel modules.
>>
>
>The routine you are exporting is the implementation of a weak symbol calle=
d by
>the regular network stack in order to allow any real-time core which may b=
e
>interested to extend the logic of a common networking operation, in this c=
ase
>socket binding as extended by evl. If you were to add some evl-managed
>protocol, then you would declare it to its network stack, so that sock_oob=
_bind()
>could automatically route any relevant request to some handler in your pro=
tocol
>implementation.
>
>Therefore, I'm unsure to understand what could be the use case here, why
>would and evl-based module need to call this routine?

Thank you for reviewing it! It is a minor build issue. When we try
"make allmodconfig && make -j48" to build EVL kernel, it returns below erro=
r:
ERROR: modpost: "sock_oob_bind" [net/packet/af_packet.ko] undefined!

af_packet.c is built as kernel module(CONFIG_PACKET=3Dm), it calls sock_oob=
_bind
API which is defined in kernel/evl/net/socket.c, this API should be exporte=
d.
=20
>
>> Fixes: 9afaf877fa08 ("evl: add net core (EXPERIMENTAL)")
>> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
>> Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
>> ---
>>  kernel/evl/net/socket.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/evl/net/socket.c b/kernel/evl/net/socket.c index
>> 4c61a1c1f6d0..b87f3fa9863d 100644
>> --- a/kernel/evl/net/socket.c
>> +++ b/kernel/evl/net/socket.c
>> @@ -449,6 +449,7 @@ int sock_oob_bind(struct sock *sk, struct sockaddr
>> *addr, int len)
>>
>>  	return esk->proto->bind(esk, addr, len);  }
>> +EXPORT_SYMBOL(sock_oob_bind);
>>
>>  /*
>>   * In-band call from the common network stack to shutdown the
>
>--
>Philippe.
