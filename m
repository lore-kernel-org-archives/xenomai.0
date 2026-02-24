Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010042.outbound.protection.outlook.com [52.101.69.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D1433A70F
	for <xenomai@lists.linux.dev>; Tue, 24 Feb 2026 21:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771967517; cv=fail; b=BLha09cHgugty0mUsEOVoYzGkQ2DMpbJOqhac2n/AjBK5lzlJ4WRroMCBWQ5o7AH1Lpxv4qd02Y+hjF+nzATZuC5r4CKsbi6nT+lcQdyWCYUpGDpcdLpJRCYr7o3svTmnSxgM4BkZsVmV5JAFLpLUzpU+apYkyaWeYfss4wc/5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771967517; c=relaxed/simple;
	bh=USC0ZW+QId0FzKnrTeeLw2FPTbj6BoF090hNt8hzEnE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d0vdKnayu7qXbsX2ZUeb/VkBYysggHwWLFBIMEea9/GmXXL2U7LxdxTmKiUKJ8uPb/GiEMr9D5zQgSOk+OJD5eSa65DUpBXs6MxmlIKk7x2c51zKWkA65Lkh00qLwpQ7sTQv9DqdDztnrnhXmxM8gvz8Dj6eoM3uG2lg1JWxMpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=hn5H8xMH; arc=fail smtp.client-ip=52.101.69.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="hn5H8xMH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCcdB0vsN0PtCxoTXgVDn+o7XyF48K26acKUaOYmbybvF41IX4/Hhq1DarGF2rvnoAtfQwrc2obZh+8dZsCLg+7Zqi7F708mLupSahOyo29qsfP3OB9d1xiXeGPOajJjEUh97a8TUZZeCfWGt5tOC7fM4ptS5cD4ZZdstX1N9alzwBxeagnus8X1yVxwgex2WJ6jeyQ4q+iciQ1dKjmUuFwB9BkhFhU6BP8csXSuJa581rQoULszP2EOkq2ptXAkIGPQlyaCbUAKcQxsweHBT3O5ModAxMaXhcsezDO6rj7wrYR3j6fN6hLOCPCx1TgAukUYge40eOpitEK8eNl+UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQjCNoQnBoyqThjP51m70ukqPUGNi+S31OmoiqCjDmU=;
 b=mfi15NKK22/+LzdRJZ+EDJl01rFPGQspRCVbLkg0WfyRfOL/iSHgNntpczV8GwiKZpiITtQh+CIowAu5rjwWGS3lkXv+dcJNydscmKoqqdBnhh9wfZkycCgA1u3Wjb2jb3Ib/ugX3xz+ZqkQ4wgPi0lHuZO+17HKaz1wEUYZsSALr3n49m7jJXhpdgES9kRjv9q8W8NmA4dKZeBWC0hULMkCnVMip3k4qgvnw2aJPtLEoQj93eXh2tE7CMHDwLDDzJN1ThN7RmU6AmQxIUubWHHBnqxcSRG6YBI6axlp0QGcKkUNUfJq42o4G2ilohujJsjJwEUSRNJvcHVO9/GR9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQjCNoQnBoyqThjP51m70ukqPUGNi+S31OmoiqCjDmU=;
 b=hn5H8xMHo3vaNM71PhG3ZEC7neh6dIkplFLovsQ7NYNRoECCNVM7MFBnrL79iqkHMfAlK0zKjoejysDpMytLaTpJdojj/UeiPDEeSzIdonatUrKKvVo+apvZdmGdeJJWD4Q0fY+wpWAZmQL+ccCCvd5+NnGTnQ13Zozh0XpQUUqP20UyWm8KeUcnzsxkZxMtZTUnxt0HBBzOXK0ouLB9HpmY+fDmV0kV1mNRFBuV/3jN82E2eoIAIYlV37YM3MfF9mFP8dTF1zRkJRLMuSQRq2gjBJRptzMRbrTnGZpq4eLG1+URqXRAQctKuRZcjvJaM8l5JylrGhe1LfB/m47oVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS4PR10MB6040.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:577::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 21:11:48 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 21:11:48 +0000
Message-ID: <cbadbf4e-0d05-476e-8d18-49436fe52868@siemens.com>
Date: Tue, 24 Feb 2026 22:11:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cobalt: Prepare for new signature of
 __request_percpu_irq() in 6.19
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
References: <20260220-wip-flo-prepare-for-6-19-v2-0-222effb01976@siemens.com>
 <20260220-wip-flo-prepare-for-6-19-v2-1-222effb01976@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260220-wip-flo-prepare-for-6-19-v2-1-222effb01976@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::17) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS4PR10MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: d4d707ec-c1d2-45e3-bea4-08de73e95229
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTlUdnEyT3RKRW1FOHVkMFRUOXBNOEdaR1hVRkpHV0h6YTZQelVyMUlYY2ZS?=
 =?utf-8?B?U1RUUGNUK3dtcFRuSTNONzNEQjF1ZnkxbWp0ODJ5dFRneVkwZFRxNlRYSHZH?=
 =?utf-8?B?alVCdjBDMTdRZFZ2UzY1T2E0REczZWR5L0tBQnVaZ0dqekNNZzZlQ3RxMTlU?=
 =?utf-8?B?S3Q3L25UT0NRRHJOazJWeEMwenMxVzJia3JqdDk1bHF3R0k0NTRQQzlHaFlt?=
 =?utf-8?B?RzZVbHg1aXdmZTJIYzZoaGswd25uQ0J3M213MmZPNWxFdmJRbjAzVEF2ZXJV?=
 =?utf-8?B?SDBkcDREd0IwUndZcGM2N0toZ2dNdjRnK2t0NEZXSEFWVS9OK1lpUUpzTTZq?=
 =?utf-8?B?RWRzbHNIUFphZkJXRllQeTdVSE53alRWMHNtM0QzM2RVTVJneTNnK09IODAy?=
 =?utf-8?B?OElJZC84U216OWtpZUhISTFkT1JJeEphSHhGdDRyTkFSVzlPKzZyMmo4SzFG?=
 =?utf-8?B?ZFI5bDlzWHBXWllEYW1mVEk4cU1iUU9JbFpqaDdEVms0OEtaU0pOdERTWmd2?=
 =?utf-8?B?NjZXMnp4R2FaUVdjZ3Q1QnFZTVRTR0VUSXRCRStReGZ4cnNEc2orVVBMdUlY?=
 =?utf-8?B?QVJCeW9KR2ZIcUoyWmgyN3kzdFFXdjlpc3F2VEt0NlFxaFNueWF3V0NqY2tD?=
 =?utf-8?B?dE5GNnhPUXA3Zm9heVZTSHkwSDF3VWpqa3lGdjdTWjg1OFdSVm51WU1neU1T?=
 =?utf-8?B?eFFDY3VWUmx6T09BekJML280aFBPQTZUZFowSzlpd0xJZXN0ZmU3RFZPQUx2?=
 =?utf-8?B?OEd1SHhDcDh4dnBGTGVQdGdDSUtZRVg2MnAyZ1NSSjUwblEzNVpYT21iamVj?=
 =?utf-8?B?NGZQT3ZrMlQvNDFtQ1FiZ1B5TTRnQkhHNEZaTDhQb2MyQU9wcWNCTnZYS3Ro?=
 =?utf-8?B?d1pCRkQ5bVllOGxycWVucHRJVndETU9aQUVwaFgwM0xBSXcvVVRkbDJLNzA1?=
 =?utf-8?B?bGVIRGRzenhhTy83d1JnV2RrbVZtYVBXanArdDgrd2F4cXB5WVdxRjE0VXBI?=
 =?utf-8?B?dUlEb3FOQms0K2ZDUkcyeklacjd4MlBLWmU3UFRZYlphZXN4TVZCbFdsTnZj?=
 =?utf-8?B?Q1RUUEp5MVcwN2g0LzNKcUpRYkdhYVE0UE5DZ3p5UmNPV2lkdUdTVi9tL3F4?=
 =?utf-8?B?Rm03eWE2NkZsNHpPMk9PK1EwWVltRTFWZytZZm1ybjAvd1JodlFoYkFQTnQr?=
 =?utf-8?B?djQzQjd1TFlHTTdYOC9GaVl3c2ZDY1dmeE5vdDBody84Vjd5RUpsbXFkM25q?=
 =?utf-8?B?dzRyRldINENJVHpSY29SekhRcDEyRTZhZVU4OUg5TFNCYVlLZ0NDeUhEeUFO?=
 =?utf-8?B?STFkY21HenJiL3o2UzFkenNrZHQyczlhTEtWZENOTTB0NUdhUnpva1E0OUZU?=
 =?utf-8?B?QmRmZk5zSEErT0hDVmdQUWFmVFlTQWk1QmU2bU1WVlM0M0xBQTFqUlZRb2s1?=
 =?utf-8?B?YVRaN2RVd3p4R3FLMU5lTlBiUlp2TGRCMVRyamg1bFRGVG4vak9XRUUydDF2?=
 =?utf-8?B?MkhvZmJWUVY2NnlaSVQvcnZoZ0ZKUkRWNkFRTk5kM0t5ZnZXdW9SVWR0VEVY?=
 =?utf-8?B?emxSRVVyUW9oWGFnL0l0SklMU0ZtV0d1QzRSYm40OUF3dXZKRVhBdjFKS3Vk?=
 =?utf-8?B?M2hHd3pNby96S1QzSHMwQkNaT1M2d2VEYU05RDhacjhqNWN1WlZlcFJXV2xI?=
 =?utf-8?B?eHpHenlYRnJPbEFxaHJMa0xUZzBna1BiMDFWQWx2VDU0NVdTZVZFQXN5T1Fx?=
 =?utf-8?B?OWpKTS9YbEQ5ak9keFJJS0dWdmIxSysxdk9maGtidmVjalFRQ2Y4VUl2VWZL?=
 =?utf-8?B?TEdEdTIwNUVGMHVzeUJkSmxDTkFscWI4VktNR2ZYTFJZQ1lqWWFNeDk3T2N6?=
 =?utf-8?B?UmFveGNSTnNRRkJMNmZhbzFtWHRHNmo5ckFzS0d5VE1NUE9Kcm8yQWZxQ3RY?=
 =?utf-8?B?RmNIMFVieWdsTU5UM3h1UW50TnpNblBNY3l1bnFoVmE2MnBYdTF2Sm9GSjE3?=
 =?utf-8?B?dGZnM0FxemVoR1BXSGlxWllwQmN5dXN0NndjZDMxeHZ1SWZ6Ykd1VUd1ZDMw?=
 =?utf-8?B?UnR4T3dSb2JFci9GdGVnQ1Q2VjJqTC8vUWw3VVFFZVRidm5CWU40UFFtbmt4?=
 =?utf-8?Q?rLHE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0tkL3ZPQythRFU0eU80ZEVwMERWN3gxMS9aNzRLMDRDTWU5RStSejJJTDVs?=
 =?utf-8?B?SVBvUGxIdDd1RCsydDF3bHpxZGlueUJlaFV0d2duWmhUK1ViaTR1MmgyQytO?=
 =?utf-8?B?OXVrS1E1MVJ4ZURpVy93SmhDcDJXaTdyQ1ZNMVRIano3Tk1oK3JUTUE3cFky?=
 =?utf-8?B?dXF2cm84bjhmS3RuMW50SklvaE9JMzdVU1kvRXg3ZXhtRW45ZkNOdnpZSE9Z?=
 =?utf-8?B?Y0hvcTh5OWtpZnk5bkJ4Z0pKN2N2Y0VXNlgxQVp0ak5ETHlJaVNvY0NIdnk4?=
 =?utf-8?B?N25kbEtQU3plMCt2Nmw5TTAyVk54d2FRdGdkK3FmVndyTFR5Nkx2ZHJDV0Nq?=
 =?utf-8?B?dWZaSWJEa1NoQnRWY1hwRE9yZWpPejFuSVJMRDJ5dUZLVlJDRVg4ZlRNM2t0?=
 =?utf-8?B?bUVPME9GUWExZ2x6UklOazZpd0hyd29hNTFXanZ5VkpwSEpEdjlLY1daZmNG?=
 =?utf-8?B?RTZ2S1JKako1OFNYNU9sK2tDM0crZGJ3ZlcrZU1Ka0hGT3hDVGloM2xXQnY4?=
 =?utf-8?B?K051Y1E5OTFwS2RUL25XU1o3MlJsUWhMR0s4ZE1kQkkrRHpGd29hb1c5YTc1?=
 =?utf-8?B?b2IzZDJxa0dibmZoNFNKZU4vUkZ5S20xRU1lWG51UlBFQUdyM3pVNGh2R1Jh?=
 =?utf-8?B?ZjE5ZWVVaXcrL2k3N1RYc05ySDU2VEhwSmd1Uzk2Q1ZRcFY2Q0VEZitNMHo4?=
 =?utf-8?B?MEVoaURrTHNBSkkrK1ZreHZVdWFpWk50RFRCeDQvKzNVc2xuTGlIOVg3VWlM?=
 =?utf-8?B?YnhJOFlEZTNzL041V1V6MjJLL05TejY5VFIrdkpOYXVrcjVnU1pwb2x2OVAz?=
 =?utf-8?B?SGQ5bUhvazFLQ3BIWmJsMDVsS0Z0SS9lbVUzZWRnbU5CNkZubmlKQUdpbjhM?=
 =?utf-8?B?RWNpZWRZSnp3elZKYjJ4bkFtcVFra1R5TEFTL2NhWHUvVis0NElVc0F3VTY5?=
 =?utf-8?B?WWw2V1l3bWNIenYwNzV6aG5odElsbzVxRFppaGtsdVpRY3NNUUJxelRObzRL?=
 =?utf-8?B?RXAzVkcwLy9MekI1ZHBxZ2RnN2lPVzFsTFVTbnpBc01MaFpnRmRTRHpjVkUx?=
 =?utf-8?B?bElONUE3c2JNUk5VTXhrOXlDQW02Y0hUK2J0WDJ6LzdZMnFCQ0tVTFhmZ3dq?=
 =?utf-8?B?bm5BWjNMRHVIVDRTNWFQN1hEODVocStNa0dsUy9CYzFpb1p3YXAvallWWEhk?=
 =?utf-8?B?WTdqOThvRnRheUwxT2ZXZ1htWHZVd29zTE9YeGZWMmcveG5rcDR3ZEFTR3R5?=
 =?utf-8?B?MUR0TGRMTmNzZDBvanVoSEhIZktDYzkyL21sb3lRTE9VNTZrRlRlMGtZU3RM?=
 =?utf-8?B?YjhsZzZucFEwYjNna0dpQnZLcGRvYUd1ZTJ4bFhkQ21kM0pvMklMLzM0TFkv?=
 =?utf-8?B?cVJJV2RWWUg0VzltSERaZjZJL0xlc0VTYWo4TjNRSTNFYW9IdWpuV2o4blk2?=
 =?utf-8?B?S3prUkxEYWg0UG9wZlRLa3JqeDU5cVU0OTN5S2FrelB2b2VZZUtHcktVUnVW?=
 =?utf-8?B?S1lCdXo3R3NlSTdhTjdYazd3aVdOU1VUdjRNNGNkbTEzeWlEUGwxeWdJZDFX?=
 =?utf-8?B?UmxINzAwNlFwdEhPcXJtYUlIcDljYTRlK09NUi9PNlFoWE8rVWRzQURYOG1n?=
 =?utf-8?B?cVRGQXJjY2NhVlVaeFB6VTFRS0ZpNTFUeCt2cVFBaTNXV0crMU5TVE9CdnR6?=
 =?utf-8?B?UGVMbVdjKzl2M3hLcGVaNUlvYVR0RFZFZEwvTXZEdE1JVng0bHFFaW1nZ05w?=
 =?utf-8?B?OVZMS1QxOG5TbDZEQTBYa3FKa3d6U1JhQ1lQS0JWOGdxeFBnQnRzbEhlcGFo?=
 =?utf-8?B?TnNNRVJSREgwTy80VGNKREFXRHJpQXBRQjJFbTRQRG1qZnQvU0dWRG80NjBT?=
 =?utf-8?B?cUxMY21NYVJhT2ZLNEVEVHVzL2kzNU51TnR6TXFTWUN1cXkvdVhkajhmbklI?=
 =?utf-8?B?akYzNFk5c25Rd0tWZnZQd1QrMi9hRzg2cE1nMzBCbXNER2NtNDA3cDRVM00x?=
 =?utf-8?B?bElGZ3JRL3pIa29VRDVXVEQ2UlJEaVRyL0YzeVNyVXlUQUdGOTI3S01IZ1hu?=
 =?utf-8?B?bWtLNTcxajV2bWF6MFN6cEpLMUU5aDg1MFMvem04VUdhQ1YzZUgzMk1NQUxG?=
 =?utf-8?B?b1B1dlZLNHVWRXppdHNkN01DS3UrTWYvRVV2ZVpBaGxJZFRBMUNlcW1MSDY2?=
 =?utf-8?B?OWRPTnJtb21EVENZUU12Sis0M2RTWXRqeVh0L001YWJiMHBQSGRoVW5tUERN?=
 =?utf-8?B?OXUrR0srRDJyQ1pZdE5iT3JNRVhVWVZscmU3RXFEM3NEeFVCWkZEQS9zOUpR?=
 =?utf-8?B?Rml5bUFTcDdqMGhsT0p0d2FTclc0MldhakVWcFNqN09yWGM5bCtXUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d707ec-c1d2-45e3-bea4-08de73e95229
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 21:11:48.1418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnyQtIR7KGLv0sfd5n5ceCMZ52MlUM4ayvP6O5va3z2A0w6O67QiR6lGCa/F2CDK0jnq7D9dqzVL2YSsPk1PxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6040

On 20.02.26 12:27, Florian Bezdeka wrote:
> The signature of __request_percpu_irq() got one additional affinity
> parameter in 6.19 and 7.0 will remove the function entirely.
> 
> Dovetail 6.19 will introduce a new dovetail specific service called
> request_percpu_irq_affinity_flags() that allows us to set flags and
> affinity at the same time.
> 
> It might happen that older Dovetail versions get the new API via
> backports, so the re-#definement for older kernels might get
> obsolete earlier than dropping support for Dovetail < 6.19.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  include/cobalt/kernel/dovetail/pipeline/irq.h      | 6 ++++++
>  include/cobalt/kernel/dovetail/pipeline/pipeline.h | 9 ++++-----
>  include/cobalt/kernel/dovetail/pipeline/sirq.h     | 9 ++++-----
>  kernel/cobalt/dovetail/tick.c                      | 8 ++++----
>  4 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/include/cobalt/kernel/dovetail/pipeline/irq.h b/include/cobalt/kernel/dovetail/pipeline/irq.h
> index 55d9b8ff17cd08e5e8c09aec393a1e23736c1b76..df0b8ceb05c25d655a331d238e7ef8ac8a6afeea 100644
> --- a/include/cobalt/kernel/dovetail/pipeline/irq.h
> +++ b/include/cobalt/kernel/dovetail/pipeline/irq.h
> @@ -5,6 +5,12 @@
>  #ifndef _COBALT_KERNEL_DOVETAIL_IRQ_H
>  #define _COBALT_KERNEL_DOVETAIL_IRQ_H
>  
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 19, 0)
> +#define request_percpu_irq_affinity_flags(irq, handler, flags, devname,        \
> +					  affinity, dev_id)                    \
> +	__request_percpu_irq(irq, handler, flags, devname, dev_id)

BTW, this effectively invalidates the affinity parameter. Before we
could make use of it, we would have to backport the dovetail function to
older kernels as well (6.1 right now).

At the same time, we seem to be forced to create all the OOB interrupts
on all the cores anyway, even when supported_cpus is set to a smaller
set. I do not recall why that is the case, I just vaguely remember
having asked this before. And as long as it is required, the new
affinity parameter will remain NULL.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
