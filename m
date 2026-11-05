Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793903489;
	b=pyb4dRJ/LUXjVFyouSEOHOSgoKzGM65TQSbvVerX2O+OoAGVvcLBNSZn2lWTNYCQbFsI
	 3fCucDTirA/jDOlE3iyNC7WMWX+ib+ReAO+49iFUXuVDJlO5bmDD89YagZOxFdetybpMJ
	 xCpN4J8Xkq5Ky9lfn6AwzsHeLZZk5g/DkzZWwRW2fq3kXCkey00DGT0OKamPhfXDeOtS2
	 PrzEjz7zq3+MoWkoifKyJTpveCEJQL0LHyfxQOLq12YjapW5SBZo7ErYUHugUZylVVEn7
	 dAuOpHtoxJDsclUYWEUVlxqArgkf8Etppuy7mYnCwEnUOKBBY8TmX0zn2T38tdN4ZOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903489;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=HC32DjMB4yXT4jbipzvLoSBJo76q/Z2g07WlTpHdCoY=;
	b=u+BkLFM6SnT01lxdLFUXZ19kWKqBEPHsearU9j/Le1xnM8OOLethkfborKgL9REGpyRl
	 iZrhFo7pGLE+tkFkMMYe6ugiymCbUoueEyEtXGYfeVe7ndt0mLw3GSbt/V4k814flm1NE
	 lbpkpYEzY5NmSW7JO6SWGqd3yWzjtl9ixJEJj6E3nyAs8rjPxGoVewiDvpnDwysvmx/jR
	 kuCbc6oIP49ZudyWlkit/+c40luzw2QM375EYN/1mD9EpFiBiy0Ai5Yl85AJyceDqb7c2
	 430KhSveeGWIWRO6A+3kvRtCvATViWLQPL9fhX6RSyG+U/ubyuPduklIiwSiMiSZbww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=utFu0L1Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.10
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012010.outbound.protection.outlook.com [52.101.66.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3197B606A31B
	for <xenomai@lists.linux.dev>; Thu,  5 Nov 2026 18:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3197B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=utFu0L1Q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzdXAr0dspbWY5StZHi6LqjlOh7hlOUAtDcQ30yBWC4GicK3ak86H+OewFHl8jN5kBSl7KEHIqqix6Y78YyrhQv6hzGT4/SmWUJt402QW1Mr0HgaTsUqDpmVeE/NLEBFysTPKz7FgxzsMk2DZfSzZ89iMg2smDBbc9d2MH3vxkHSg+eTDZrDQXqrAomO/eqQS2/r2vTeH1XqOB4qW/Sv68Lp68Q02HoEKtGrObvLfqsRnJ92GkzoR7U0a4kQS0in93RBA9eKox2Eu288qC8BfFdpUn4zKyRO4o6H5tT6OghP9u0Bwb1aaeB2BW2yxMtgA48OCNlE0Yz7sObGe6q2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HC32DjMB4yXT4jbipzvLoSBJo76q/Z2g07WlTpHdCoY=;
 b=MHH2qqNDqvUJNYxAcvkviqU9Tc+sMv9HMRJMV77j50IMxRK9N3TqawMSfT2W1Lw/1gyyBDsDu1Ke2Xrr9aTOts9RE+Q6oWuhk2vTFGwGojGvjasud0PomOnyMPFK69+qmMw7FNJLOpvyT0C9C5nXnPX5ROaoDNtRDbd1ncwraSw4gdiiMWqUmKKVeyM8TEQCyKl7vl1aSGXttQN4n7RQX8l0hvpyXNhxRd2BmPPl9Qahsav02QATKwKscSGL0HzF3yjqd1jDse+yrl5nRNyRMMiSuZJp1LA4SzQFdfHp005gxY/GWZQJRqQUX69gD7gV1eAtJsAJHHyjign2Xm3r5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HC32DjMB4yXT4jbipzvLoSBJo76q/Z2g07WlTpHdCoY=;
 b=utFu0L1Q561V2ubSZQS5J0wC3YT4hBDMqF4ePLCrqCJ2RtQ/hFdRzttHJlWrTrWqFcU6Iy7XLrvIWCW+6YEd7GI21Y4D1tNm/oRUp7vmo0I6dFZLT8K8DT5AWAXVfXEaAd+QE/UAPzeaRzMXbbkojS3FVSrim1zWmFyIdDZ9lLK2wNkFSx5kAsyOYKDxEtrxM76bnHyS9LbF3GoTn7CCL07JuFpY9JDgVWlxwoXaJETK/sb9Hn/OT0ilj6n4kP5tOfLcKps3IPkKC9GN+SkndYAAyh7kfLrSxjO3eWSYm9tbLschp6ookl7AjLP+pvVgqKm+F3SvaYDgadT4oTrnGA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by VI0PR10MB9694.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:33a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Thu, 5 Nov 2026
 18:31:24 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.003; Thu, 5 Nov 2026
 18:31:24 +0000
Message-ID: <6d2dc7fb-83c4-4056-aacd-825a77868872@siemens.com>
Date: Thu, 5 Nov 2026 19:31:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Fix missing time64 wrappers
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>,
 xenomai@lists.linux.dev, Florian Bezdeka <florian.bezdeka@siemens.com>
References: <115efd-6ae0b780-3-36f80d40@211094435>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <115efd-6ae0b780-3-36f80d40@211094435>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::9) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|VI0PR10MB9694:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c9b1c27-662e-4354-e523-08df3b6afef5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|261009223027099003|261021121427099003|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261028144727099003|10067099003|18002099003|55112099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	od+ut+LIbxn2g3DrZ39T/i1HMguT3OGuS029aNsSFtzF3BWwvrZ3InDW0P0wSQLdFHpaR0cFtkq5gNIMCn9+kW23i5ZWBWCrnCtN64/wTEGKWjniv8vg8OGRrejhYtX6u+zl1t9hhPDSM02s3CVt5rG2SUs+1qxdluvFEdmowoKQCFbSjQYywHn0PTqb3CrXfbNo6dKUrQ7zt1Ps3vZYGou9wRD2FsT33qed0qkdtt/C0ePlEBMJEkS4m1pBmAIR8xOMg2i9MqhyMeqIs6cRCpv9ZjzwRKRJBZSEQaGSL2SzGjjBtLB+Ch+Gdm6iF9DplQbl9jlInr+yE+kcsk2lqoIS2hS8KtSRul1bBsm6HguUVFAxGepIt6sQkybyrYQnrn+paWdWwGUDSx1t7eJDSeeDq5+IoAVeDsKWTeNTsbOs5sQv4pZimsOxyPCSbTYQ/J5nQ4wtEP0O36AB0W6aJ7vHhcY7XjOiaTexoRMW+JYvWTuAaYw2Iu5CGhHDvKhI3injK624Mm/Z+jzGL5KFNnzwMQmxU/OLz6F1FDPgZuUNzciNdKEKKQ7ZmaD/Mit52NDbLwjf+WB15HXx+h2tqoMiA/62ZGEyQwA9Db+3E4vhM9cfDyKXCcCH+RFMVXCpxbFoOnSXpiuw2RxyfycHrLpCqN0bfkq6HCszA/FM9M4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(10067099003)(18002099003)(55112099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wi9ETUFhcXYwSlcyYTlnL3FoNmFtM0Q1T1VTem8yRXI3RjJxL2JMWk53OVVv?=
 =?utf-8?B?b0V0bUdiUnB4TFRNVWxSeWhVR0RmL2xjTXpYODkreWo1bzJVSEZvMUd5aTNv?=
 =?utf-8?B?M0twR1dCbWpaSlJRbDZmOFNUQXNUTFN4amVYZjhoVDdsZUZmVHN1UTRPK2hs?=
 =?utf-8?B?bFdrRjB6UkFvODR3dStlMitvWkZhMGZJZllURTFLakpkNzBQM1gyYjNhMjN2?=
 =?utf-8?B?Y0lUcGRsL3NNQmdKUXl6TXpkRGFnMFZJcWE4L1l6bnRIMXQwUjdnYS8zM0I5?=
 =?utf-8?B?RlRSRXZEcDdudGlEa1pUUmtCNXN1TXNRbXowTUliejEwdkpuK2FDZmVzcFo0?=
 =?utf-8?B?Y3lxUWJHNWtxTkdXQS9IRzNLUVo0ZUVvZlE2dmgrSitDYnBVanpOd2tXNFJR?=
 =?utf-8?B?SDkzQ0l6dTNXYUZpK2RpSVJVWHAydjVYaGxiQyt0U3hCR1NxaXlhTUplYk5T?=
 =?utf-8?B?eVppN3ozT1hvUURlbXlyNnpNS2Q1dU5vYVFhSDJ3ajBSWjBvSVkrZ0RmdVJQ?=
 =?utf-8?B?TGFNR2pYdzVpUXN6TzUrenZoNDgvdHVyN3FnL1Iwc210WjZwMERVNEJ0Vmln?=
 =?utf-8?B?MmZ5TmhtM0pYN29iSnNpalhTTW5WaGUvd05hcmlXOG5ucG1PZitWNWs0UG1D?=
 =?utf-8?B?ZFFCdGJaOTE5Z09NaytZczRjV0lhUGVWNlVzNWlrUHVrL1prSzl0b2hsYnpt?=
 =?utf-8?B?Nmx4T0h1aGJDalFSTUdGd1pPa0ZOc3d5d0hWTkZJWWcyVVJqZjBTWW16a2Mr?=
 =?utf-8?B?WkdmbFlhK3JqVmt4UUVIeFJCb3NMcitwTGJiMHNkTFFKMVZQaHdwV21vdFp5?=
 =?utf-8?B?bURaOVZOYWM4Vy8xQUpPWDljbm1wc0VzOUpPaHJlOFg1M3MzU2VXRGxQbndJ?=
 =?utf-8?B?aW02bXZiKzJlNzdzb3RwSURlMVVKRTIzV3BwYks0OVZ5VjAzMGdQcUY1ZEFt?=
 =?utf-8?B?NFZjZkVPK29YbFNSR3RHZG90WVV5SUo0ZEplam0wWmtjOEMyQXNZUGx6SDhx?=
 =?utf-8?B?L2IwT0pYUVpWdUFZNklJNXFiRVJpUGVCb0FRdjJqR3Y0TkFGaWZKdzU0dHVH?=
 =?utf-8?B?TGxoTitjSW41bTZUQkYrbmxSZW1qOFk1U3J0QUNDdkZHN2ZQejVlMUJ5VkRQ?=
 =?utf-8?B?Z01kMHZOaDZsTGJDbWNoM3ltcWZKNk9VdTEvM1RTQTZ5d3JudG42dm13U2Nj?=
 =?utf-8?B?TFpYWWlOVVZUbUxhOEJrUHhoQTZYcEpFSGxFOW01VHJsQzE4MnQ0Zkk1MDh6?=
 =?utf-8?B?Q1ZYcGEzNXErWG9VWnFtZHo3a2RIcks3UzJWU3cwOHJleVA5T3g1cEUwTGtD?=
 =?utf-8?B?RjRFL2k5bExUMElQOVU5WXAzSjkwTzBCNkNCLzRYeTNSZTM1SGQ3cS9uTG5v?=
 =?utf-8?B?UFZsTWFzMjZxa0xvSzIwbVBtWXFNMWVrMWxQQTZOUVd4QnNKWWFRbWxWd2pU?=
 =?utf-8?B?WXU1OFV1WTgyK3hCZncrZG44NmE3cFBJQnZMUnRLVzFYYUFBSm9CdHEyUUc4?=
 =?utf-8?B?NjNQK05sQXJIeUxsOFVIY0J5YlgyeDhtWVlGS2NaMkx1Q1dCRTRwbzhLTnNw?=
 =?utf-8?B?VjlUbk5hUktCb3BnZkNYTlV6YlVGVGQvZ3BBaUtVczhpV1Ava1BFUUhWT2t6?=
 =?utf-8?B?R2lJdUU5QjhyUUQ0bzVmaHFoZ2dubGpOYlRCblYvREV4VFFUZEZMaXc4TUd0?=
 =?utf-8?B?K2RnZCtVNFRVT3JhSlVWbEd4OWR1OHdLSmZVRFB0bXo5NWVoTmc2NmJiemYw?=
 =?utf-8?B?Q0FjdFJRM0l6b3hTeDl5NFdPcGJRK0dqVXZuSk1XcXVVcDN3VEhCUWtJNGhq?=
 =?utf-8?B?US92NnYrbklPNTJSL1I0bGtMditib2dIWCtaNU82VTJrMllTbUhIOG51aGRh?=
 =?utf-8?B?QnNncisxaEFyMjhTMHhIbFlFa0d3TEZOMzAxMXFrTnZ5TERyc2xZSnE3ekxs?=
 =?utf-8?B?NlZkeEQyZEtoQnBtcXpONEtObThKZTJhOHcwamprTDBmdi9tV003OCt5bnZ3?=
 =?utf-8?B?eFl5ekpKNWErbCs4QkF2dTZIcFdyc3VIbG95RVB6dzVzeVl2Tmtkdis5MUtm?=
 =?utf-8?B?TEhnZTBIYmZqc0VGNDcwazM1MVlIYTVTalNDSW1sdjRqeUFhVjZSbi9mOUQz?=
 =?utf-8?B?dUtxcnhGR3VZZUpYQ3o3SmpqdU9kZGlEWHpGSXBPa0dlQTdyQitQSC9MRlhx?=
 =?utf-8?B?SjFpcEJmV2hIVjZtcnVTUUtmcVFXRVgzdWhtYW5ZeUZydGR4MEJhdElJM3Vt?=
 =?utf-8?B?L2pjNWFtUm00b3pGQU1qWjA2L1NYTTNoKzNvcm9leUovazBRWGtubnpmR2R5?=
 =?utf-8?B?SnlUeU9GanpXa3hXUm9LU2ZYVmtRQ0M0NzZRNjhPdU9mYXNnV3RTQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9b1c27-662e-4354-e523-08df3b6afef5
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:31:24.1510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afTWLUMHDA86HPKhilyp4SxRtjbc0xdMaR7IJZYXiLKkYkU4AqnIvWbHvBL9mxC3aUW7ewb7UBWXWDj/QTWIWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9694

On 27.10.26 15:39, François Legal wrote:
> There are missing wrappers for 64 bits time in xenomai 3.3 :
> - __recvmsg64
> - __sendmsg64
> - __sendmmsg64
> 
> For __recvmsg64, the only options which shall write to msghdr.msg_control are :
> -RTCAN_RTIOC_TAKE_TIMESTAMP which always writes RTCAN_TIMESTAMP_SIZE (64) bits
> so it is correct to route the time64 services to the native "time_t" syscall.
> 

So, in-tree has no RX legacy where we would have to differentiate the
between 32 and 64-bit entry. And TX does not use the field at all in our
tree, as Florian noted (and asked for a remark here).

But downstream drivers have no chance to handle that case, right? We
should note that as well.

The change is basically just pleasing the linking issue that arises from
glibc trying to differentiate the compat from the time64 case, enabling
separate handling that we do not support.

Jan

> Signed-off-by: François LEGAL <devel@thom.fr.eu.org>
> ---
> diff --git a/lib/cobalt/cobalt-glibc-time64.wrappers b/lib/cobalt/cobalt-glibc-time64.wrappers
> index 0bf895ca9..483a8ce24 100644
> --- a/lib/cobalt/cobalt-glibc-time64.wrappers
> +++ b/lib/cobalt/cobalt-glibc-time64.wrappers
> @@ -8,7 +8,10 @@
>  --wrap __mq_timedsend_time64
>  --wrap __mq_timedreceive_time64
>  --wrap __sigtimedwait64
> +--wrap __recvmsg64
>  --wrap __recvmmsg64
> +--wrap __sendmsg64
> +--wrap __sendmmsg64
>  --wrap __pthread_cond_timedwait64
>  --wrap __timer_settime64
>  --wrap __timer_gettime64
> diff --git a/lib/cobalt/rtdm.c b/lib/cobalt/rtdm.c
> index 00c1aaf4b..264de8ace 100644
> --- a/lib/cobalt/rtdm.c
> +++ b/lib/cobalt/rtdm.c
> @@ -254,7 +256,7 @@ static ssize_t do_recvmsg(int fd, struct msghdr *msg, int flags)
>  	return ret;
>  }
>  
> -COBALT_IMPL(ssize_t, recvmsg, (int fd, struct msghdr *msg, int flags))
> +COBALT_IMPL_TIME64(ssize_t, recvmsg, __recvmsg64,
> +		   (int fd,struct msghdr *msg, int flags))
>  {
>  	int ret;
>  
> @@ -301,7 +301,7 @@ static ssize_t do_sendmsg(int fd, const struct msghdr *msg, int flags)
>  	return ret;
>  }
>  
> -COBALT_IMPL(ssize_t, sendmsg, (int fd, const struct msghdr *msg, int flags))
> +COBALT_IMPL_TIME64(ssize_t, sendmsg, __sendmsg64,
> +		(int fd, const struct msghdr *msg, int flags))
>  {
>  	int ret;
>  
> @@ -312,7 +312,7 @@ COBALT_IMPL(ssize_t, sendmsg, (int fd, const struct msghdr *msg, int flags))
>  	return __STD(sendmsg(fd, msg, flags));
>  }
>  
> -COBALT_IMPL(int, sendmmsg, (int fd, struct mmsghdr *msgvec,
> +COBALT_IMPL_TIME64(int, sendmmsg, sendmmsg64, (int fd, struct mmsghdr *msgvec,
>  			    unsigned int vlen, unsigned int flags))
>  {
>  	int ret, oldtype;
> 
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
