Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C46D17E
	for <xenomai@lists.linux.dev>; Wed, 11 Jun 2025 04:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749616284; cv=fail; b=i4brMkS62hHb9L2pikrslT/IQ3APxTpLEU/ML5QXFiwmtEs+HSUS8UOG8qxIEo1h7VG8kgKqeiziZPRmhWv4l+7SEd5bjgYWmF04j1yl5YzE85XN/OSX5Rr+ny566FeSCX60ToQ0E+t13enODRXkwvc+9MyAOtTxLZoF1URCkak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749616284; c=relaxed/simple;
	bh=eJE6/zR7JCOSWISDY3jC99q5UB9klJKXVAH7xy/c6w4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TMUHhHjc0HPtfn0cdq0vixfKJ+pwcSk4ikIZrRkxpepSwU8omXMZuIj+NwIS2sg2Ddh0Y3C4Q/NwUZrhYIGoJ8MVjIb9ZpDxuAqHgS9zr7EZc/IyKi7rLUe6zF9VIZmL+uzZ1rOcYtDQRLRHpkPIJUKhSdhTRBETlc/MEn/30vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WyT26ZHx; arc=fail smtp.client-ip=52.101.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WyT26ZHx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgMiUIuN2V9VqvsuLAFHUrKmYeCRy3qLJmq3pMWZL/Nqb+ENeWm+rA/DNABgNNKFHmk9cHTenk87rtupy6vrOUllCgHyGiHGQoC5Se/ifGF+eb18vLiuOLfwV6qCMGxDCe711aB5tPfZbyowPOjUmqfG/ZxNrmg9t8jDN7aHDCb7RlnnjhK/l+1VRDc2TYdANUKaZFbw21OtMtF75TDlF71d4INoUdNuM39/Xk6an0XZjpucpfDBBxVYVZf64Iym8xgy2vxDXOCI/Hm85eTjzwWjH8k+JuJGegDexfmyAEN/WqwBYsjF8Mse4PlrGrOzhCu1MXwIkifNTT0WBXa9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zmOwSHTucr++YWt3Bv2oSIJr7Izi8pJUtLc021/fh0=;
 b=KuWDfHwocMND74mkmQ/JGqvtsIznJzHd+nX1/3IqEmyd86itwOX3svECuSytQgtXMNu1dhzYSlWdciQ6hHMfYH5BwtPRZTiSnOLSkQMAVcrhj0TrpqGueY1aYpDoFf5qoY6eE8j1z0n4Pt1HrVO4dGWLyng3R9KGkoUQ5+lN+/zX0QwXm74dz/6keASb5MHtbSfWUAzaPWcRUu/9gGm0Ah1FIJ8ZiNVv15DTKtNoRmj6zcKbFtMF9GRVgy6tGUN7UKUGabU1IP4ywKmnfPInvbum+CtJpfhLs/D95bdm2zf5hIYJ89uF4ecbKgQ8LUqYlrHyqZ2yeKB4zvPIi1XaeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zmOwSHTucr++YWt3Bv2oSIJr7Izi8pJUtLc021/fh0=;
 b=WyT26ZHxthtnf4CP49PZhEerRTyN+Tc0IM9oT4RjcGcmXVP94x6VY478pd72QRCHJ6Dg3uQafqJqGSCyoMXciMRyHCUzKWfUwzMRE2cNMXFtWeRMgsCUGQzPKVr+DpgEdOyWYziK2jfXk4NAlG6K/y+SWdj8nPdExlcsqR1+W1h/9gRGCBwjBH9PtdcVjuVsDTm8YBJ9xSa5E/yddmTD75S7WOT3oc0DCtWrXjX5ZdFUWIyyPHrctnM3jstaTG5b4QiZz27xMOAOkEb5y0M5uHml3dmhvkA10Nw8BDcXcL5gtC/gjHp2LXhiPvCvyvQbCu3iC2cPEkOihJomTOjnkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB9105.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Wed, 11 Jun
 2025 04:31:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 04:31:20 +0000
Message-ID: <89f06095-d612-41e6-a86c-6ad9e7d16aee@siemens.com>
Date: Wed, 11 Jun 2025 06:31:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Reminder: Xenomai community call on Wednesday, Jun 11, 2025, UTC
 7:30 AM
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 xenomai <xenomai@lists.linux.dev>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E7C229D3943554AE31B6F23E2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74997A20364527E81370A33FF2122@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74998618D1F5B701C8C07330F2F72@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749901F0793C63043273F166F2C52@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499534189182B1B56FDC426F2CB2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499D5045E7CD5CC207EADB5F2D92@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74997D0A2A025EBDE30826D6F2BD2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74998FCA330C96F94503AF18F2832@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499BABF9BDA783C86090B60F291A@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499C2C6A4E4E6239A05C979F267A@PH7PR11MB7499.namprd11.prod.outlook.com>
 <SN7PR11MB7489BEF822E21923EE582FD1F275A@SN7PR11MB7489.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <SN7PR11MB7489BEF822E21923EE582FD1F275A@SN7PR11MB7489.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0410.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a0214d6-a100-42ae-d4f5-08dda8a0d037
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXRybWpFa0cyWEZOTEg2QUI5ZzhBRXk2MlRxZWJlc2F1ZEtLcTJhYWFvN0RQ?=
 =?utf-8?B?RjFBcll2VVBORllQbVhDMlNkcVpEbnJ1WDVNOFNVZ2puR21GL3h6TEZlTFdS?=
 =?utf-8?B?N2tMNUdvbVNQYVBKcGRRZ3dVTkVFSkZRQTJXdkNJdEFwZkJyb01QL1VnSDg3?=
 =?utf-8?B?V040Qis0OTdyY2RlRllEeTFXZ2c5Ly82TkpJZzNaaURHTndtUHF0bmltdW04?=
 =?utf-8?B?eE9IWjZHWHNLaWpMZkxYUERzWVNIWFFldVphRDJVa3hIOWFpYjBrbW9ub1Vv?=
 =?utf-8?B?c0pxRExVNUV1SC9ucGNrWitqTzJ2VXdaMGhrZG1CZmdXcEgrZUN5enc0My95?=
 =?utf-8?B?TTRqL2VNL3hpY2s5bHVkQ0x5bUlqYkkwanZmTWtxVWtESktDQ2pwWmNPb1J5?=
 =?utf-8?B?Ui9MWTlyRUcvTzArVkJJQ0VFZ0ZsdzZyakJUd3hUdUp5aVhjazdWSEtVMGJr?=
 =?utf-8?B?dFZMbzBXT1hwcWdCZWhDWk1RbFJMVUk0R2pCTmp6eTlabVB5TUQvazdXb09C?=
 =?utf-8?B?RmpsL053cXVwUEVCdVJwT2lUcWVnaHRadmR6TGg4UDhiRlB5UmRseU0wSXFh?=
 =?utf-8?B?bmJlei83c1ZzNStocjBIQ3V5Ny95VWFrYmFuS3hJanlCNEpUYmhvM1BtdlN2?=
 =?utf-8?B?UUhqbFgwNFZIV0dNbDFFNWlNTGJYbjBzWm82ak9PSDFLQ1hJbC9ibU10WWpG?=
 =?utf-8?B?L0JxTmN5OWpqUFE2ZmNNeHhpZEROVlRiWnZldm1nVzRxaExZRVpQayt5V3RF?=
 =?utf-8?B?WGVqaDVIblJ6ZlNPRGRZMXQxYTUwdHBGVFA0ZDROTDZHeHpIYnU0WFZoRjVC?=
 =?utf-8?B?UVEzNVFGNDZnV0FIMUpQMmZZS2dkaXVBbFpwZXJpUy9zN0kwV21oY0svaUJ6?=
 =?utf-8?B?K0ppM2ovM2F2WlhHbkVUZENYRTBZbnRyQW9ETlFOQml2UUpaNXpJV3hSNmlB?=
 =?utf-8?B?NndHQTR4V1BkdWorZzcvcVpRNzI0TW9WcVhHODM5eUt0WVlKejFvUFFNU2lo?=
 =?utf-8?B?QjJkWkxnUGUyek9KU1I1RXdEMVQ0Um95ZGo2UGpSalFLZnZzZDk4dWMySU5o?=
 =?utf-8?B?b3huZlI2VXZ3VTF1VktXV0FtQXB2Y09zb21SV0xuNlVDeFlYNWdZWERtVFhM?=
 =?utf-8?B?aThRVGRXbTRXNGdobDdxUTNEeU5BcXhUT0s4WFBQLzNxcE1xT1krdHFZQVE2?=
 =?utf-8?B?Q0tnYzh5NVV0UE5FVHI5SEs4Nmw1aEh6QW1XVm1sWHNZRGJqNzM5TURSeTQ4?=
 =?utf-8?B?eTBnNWZncElQSmU0UGkvK2hxOGVDM2k2QSt6cURRN0tRNEtuenN6dmpRWExZ?=
 =?utf-8?B?bHJUaFpURndHN2laK3FQRlNuYjF0UkRzdytRZ0ovcFZGVGZPSmlwdG1Ga1JF?=
 =?utf-8?B?NFIxS2QyVHBRWGNSeVRudlErUWxTYUN2VnVZYTIrOTRNK2xCdVExN0llVzlN?=
 =?utf-8?B?WkR5UzdtY1JoWEFjTHI1OHlTT1RIZFdrcVhnZENwTlFYaE5xR1FkNFdIdEdq?=
 =?utf-8?B?aERhVXZSYnFNdmo5Qm5NRWxIdVRQbEppSEZqSjB3YW5UdE9JNS8xUHpkTWNv?=
 =?utf-8?B?czJnOVAxRDlaWmxnTzR2UUwzSkZDVTZPMW0zK0dBbHVtS2o5cnk3c0xLSjhm?=
 =?utf-8?B?aTNkd3BwSm1sOGJRN1MyTkhyUXY3cHNtS3RTeEgzbUw0RFdpejQ3ODNLTFFz?=
 =?utf-8?B?ak5xeStWNGl3YmxtT0t4allFWlNXcVRjSXRvSngzTW1ocUxWenVNbmI4RTNR?=
 =?utf-8?B?SDNIT2dkMGtMWDFPd2gzZjYvZ3lESnBuSVVLL2MrdmhBYzdQYjBvL21TQWxT?=
 =?utf-8?Q?f93b8bX27QE5yOVAWQC1aeU2keZvPM2l7eIGQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE12d0ltSU5rSUNkRkl2VkhRdVkyc1doUmoxbmJoaHljSXZ5M3pFZEdsaWND?=
 =?utf-8?B?U05vZUFOZzRHUVlWMGVObjR3SDJ5TVBFNkEyanIwTmQ5ZTBrUjFMVFdNcXdY?=
 =?utf-8?B?ODB5cUpxcWpQZzkwTXd6NCtoaWFwWTRWZmRHeDhFK1RJS0tiby9aNmhnNUFQ?=
 =?utf-8?B?akJEOXh4WnhUNEZxOHFCKzZCZk04KzUrcnY4VUtzWERha1JPWFBkOE4rVU1Y?=
 =?utf-8?B?bFpWdWJMSnZkbDQ5Qld6MUozNzlldHlOMUdwYTllMFFqNzJ0cW5aM3hZZ0NR?=
 =?utf-8?B?L3hDbWZhZ05yKzlOaldFUWRnYlVZOFlaeG5mZ3dmTXdsL1JLelNOR3pMZ2hr?=
 =?utf-8?B?WHdVNHFGaXUzdkFtcUxEMkV1bHNvT0RMdmIxU2w3MkcvZUJNbndKS2RlS3RQ?=
 =?utf-8?B?MG9udXI3S2hzL3N1MXVyWmJDS0xsZGROazU5b0FtTjMza3FKUXdnVmdvem4x?=
 =?utf-8?B?SUxkcUpFbTBMTWQ3d2VaRklOcnZ0NURhT1VEZ1NRN0VFUWcvZXl4UHJDYytV?=
 =?utf-8?B?Tys0T0RYSG9lR0t0enJmdWtnQUpBV0N6aE4zeEM4YkJSVXB5K3dUU3JSTHhG?=
 =?utf-8?B?L2RzYzFoS2Rwb1pRSGF0UVRyTmNKTlZPRWJyVldmYStISEFWYmxIWWJiL3FV?=
 =?utf-8?B?QmJqMVo4ZUh4bXJramRKQXdaRGkwaTVnNTY3Z1NQckcrS0tkMW5BaFJhT0U2?=
 =?utf-8?B?ZCtVUVlhYXFCa2wvL1NOblJJaHY5TlpWaHp1dlB6ZVRLOGh6YVB0U09YenBn?=
 =?utf-8?B?K3cyTzdiazNmbElzejdoRW91R0FQbzFIWVNvekRJdFFUNDV6TVNGUkJKSXhy?=
 =?utf-8?B?Y2ttTFN1Z3VQSFk1Ky9HNGxSSXNSUS9tcFdNdVIxMDRQUTFReEJ4YzdIeGlO?=
 =?utf-8?B?ZDVHRHV2M2kyVlZFdTF2VmZSSEtvS2NNTE42OHN1UDNNdmdHZVl1anN0bU1P?=
 =?utf-8?B?d0FZZitITWZDTXZkckJUMDNuRDdIWFVFbnltMTBqanlkVUd6K0lkVTliNUVE?=
 =?utf-8?B?elQ5WStOa2VVL21CcW52RmMzRXF3S1FXN3JFSnZTS3FuelpybFl2alVsSXBO?=
 =?utf-8?B?R2kvMWdJZHZLc095R3JORTY2MGNzYUltV3ZmdmpVQ3ZnSnpPUU15akFxMTJ1?=
 =?utf-8?B?ZDI2QjJrajdsTENYTHA3OTI3VWtyK25FYXdFZmlxRFpvdjJON2crTWVXbVFH?=
 =?utf-8?B?Vks1VEswQThSTzFDVFlmem5iZld0MGRsZEs3N0pOMEVRbTFGa2I4NFFPU1VS?=
 =?utf-8?B?dnJxTlJjNFU0RDNjWUdYL04vU3d3YlNyL2c3ZFJUTjFRVEFEdEY3RFB6UEpq?=
 =?utf-8?B?OGltNkJQNkpjRzFqTk1XcnhiUTZrZnlEL1Bya2F0c0JEeWlyelllR2Q5Wlh2?=
 =?utf-8?B?enNCR1FjbW1qRDk5ZDFHUi96SzhPNmRUbEQzT24wR1Zoek1UY0hrcTY1cURS?=
 =?utf-8?B?UmlGL3hsMnZYK0NST0RoUEFtdWszazN0L29naUVKWTBjY1ZYVjFTREVVbk04?=
 =?utf-8?B?eEdNNXBVbkpSbVFITWNOcitldjBwdis5T0U4dHBseFh6WnhtRldvZGo4UXZq?=
 =?utf-8?B?S0lON0pSZVAyc1c4YXNYZnZPcXJ1TVQ0SXpWYVBPNnJyRDVndWNHZ0pDMTc3?=
 =?utf-8?B?cFE4TGlRUE1uWWVTMG1rTG9XNTR3UnpJeFF4Z2IrdzNSaUZWZ1VTdjZJQ1Jh?=
 =?utf-8?B?T3E4a241SitGalVDK283R0RxSTBuMVd2RVdyeElFdDlUUlV0Qi9hTlJURXFt?=
 =?utf-8?B?M080eWVLYjdNcVFtZzNzZ2xRa2FweU1GSnBacTJsZ0RhOG04ek9rNHk0ekJ0?=
 =?utf-8?B?OFUwTVd0YU1vdGVYNWdhY3J2QTBCcWxkVzVsNkZCdW1zbzZJZGpCL1RQOHcy?=
 =?utf-8?B?eFhLS0svZUd4b1MxclBjT0pUclNwL3FwTGk3L1NSclNNYVA3YWpoeWFEOWlL?=
 =?utf-8?B?ZFhHaHl1YVFReWRpdCtUWmgzU2x6RThPRTVaVyt0cy9GRS9QWUdSa3pmM0d0?=
 =?utf-8?B?UmxVcjNTdFdOMUJCRlZEbGFqdWNvMUZwNFZsYVhJWDZlcENGTy9RMk5sVWVO?=
 =?utf-8?B?eXcwQktpbkxITVpodDgvWk1HaEhkREEydDUrVUhpSnE2aFRrcGE1Skt6UjZt?=
 =?utf-8?Q?9lOGU5HUWuSWy/6jjCbQ+WlRh?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0214d6-a100-42ae-d4f5-08dda8a0d037
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 04:31:19.9251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWnuXSeuYNLTOlI99D2SH5Zqn2RkYIivoPUPWOvsKpEEwVnWtb+i08M35ZVYjI4K8H5QPPuXfCifE+ZHPfEFEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9105

On 11.06.25 06:22, Chen, Hongzhan wrote:
> 
> Topics may include but are not limited to upstream/downstream project 
> plans, status updates, and technical discussions. It's an open online 
> meeting that anyone can join and ask questions.
> 
> Time:
> Wednesday, Jun 11, 2025, UTC 7:30 AM
> Paris, France CEST 9:30 AM
> China CST 3:30 PM
> 
> Join Zoom Meeting 
> https://intel.zoom.us/j/91297279269?pwd=WmdwS0pDODRNMS9tQk54Y1dvbFlqUT09
> Or
> https://intel.zoom.us/wc/join/91297279269?wpk=wcpk52a9f96d989e7e20b628c2c36e48b68e
> 
> Meeting ID: 912 9727 9269
> Passcode: 367528
> 
> 

Sorry for the late notice, but I will not be able to participate today.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
