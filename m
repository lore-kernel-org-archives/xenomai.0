Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A5E158A3B
	for <xenomai@lists.linux.dev>; Wed, 24 Apr 2024 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949352; cv=fail; b=u0K4wXVmyubIY1DvLS9h+0gPV69ctBat6sC/bHOrsVWtWB7hm0eL5LbVe0FQnswHXjFWiBISOY1PiIjP5zVrDUtTTfqhCdnFqNHNmCBXsktksTL7O1NORaz5OA4IDmGM8vprSxTsBsQGmUGifhAOoJoXrtcT4EGNbmYIQNpi9O0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949352; c=relaxed/simple;
	bh=sB090GqElg3XWQpH3bUz7KFiXF5x+SHLoI8GhMxDgBo=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DU4ZeBfjPzhxbl1T+qYl/M3mD78pV4/iC11+65p84dS1F40nzeGf+WZxQdIIwDUO7EGoCClahePYSBn1u2Ilu0EZkXDMQye79k5siYgt0btehwMaGmMJXaN9HUbhzMeHzuBDQJnw86AkvTpa7TYdHLSBvYOa0bxvc0pYr/CUHhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=L+5iqhLe; arc=fail smtp.client-ip=40.107.104.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="L+5iqhLe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZUjswRNKQxhpMF6Ga0JNSP3U+vp5SlWiFcYn8JK4IDVKy7n74AGath/NCsZTKZjKYxe8f45b1o0MR2kkJN8Zk6K/6yCttlhJQ6p3KmouzC0bjYtq50Eq0Ll70oJ+oQnX7a80KNuKJWQ0i4lFW7C4ktCOq4CVqTm0bn2GU8wltkpsqBO9b8fdU55d79EDIQ1F//DG/3m8pctcJD5eefU1Y38oA3j9pxWuatXvK1aU+NEEmteXJz8LluGHW8Xfxowx+e/FvGocA9tOEy+brvDWrbkurWHx2zheJOkLPLYRlamW3DmgyBoxbFWL98ne9Ml2P6idxk89mWtdtxFochM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULgaFsnzBrBhZ4C8Qz8p2QLjrTMwEHQ9NogM+bO32bI=;
 b=Ue1TmwyaV4yVtFlvkm31jL4RBvlfxuDyr3o4PIEviKe3rVm+jh9+fokAQTZ3VjvhRGT8Utvu3VjZvErcjbFgu/LQU6fncHmh4n+TKIs5K+yX6h6mbD1vITQ+K0auL+Hemo72mv/yEXjZ+dGc+VIUeExYm8rFS3DDf96lKBc0U8ayk8nJO99O5BGVWEurR0ew3txstDN+2ivtC4xkyiXKhe2G+OR1vGZHt8ty2x3Net+4pPdML46vibSY4VoPua5fID96+3xuhdv/f6W56UddKY9O4BuEjJfwzGB8iV3qUqOw/8XBsmw+y20C+sD1uPwWc+rxegpDIIh5DXVNjR+R0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULgaFsnzBrBhZ4C8Qz8p2QLjrTMwEHQ9NogM+bO32bI=;
 b=L+5iqhLeD4+5EgeFDfELAQGdgQ+LgrciteXYKqotKyOeP+kusgLH2wJQsKFCvosbi/ISzivCSBkYZHFx0GjlcD6GEtsH2EWok38YFgrZYyAB64UBHNwMsaL9XCzjjIaDXHD/GPnGxJd6BBy7Ir/XYTmUoqtH0iFdXKeaUc4Jtl7JwkVvicKgoiCb4TZd1TNAaUiHSKq6AxFi2prn20sp1UbxwQABSN/Q5+fmSdbwm7Z5Dtn4FNZ3VD2JMxtl5jt98OmQyJCRC9V4EavwMehdsoYardWXXGuG3jxN7jl7M2eJla3Yc7cP9UGZIlchWO23CcUvUNjQKi1vN3ctAlr3Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c3::21)
 by AS2PR10MB6750.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 09:02:21 +0000
Received: from VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2ce:cfd1:878:41ae]) by VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2ce:cfd1:878:41ae%5]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 09:02:21 +0000
Message-ID: <26503f75-0512-44a4-b044-4ab462c23075@siemens.com>
Date: Wed, 24 Apr 2024 11:02:17 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re:
From: "Scheler, Fabian" <Fabian.Scheler@siemens.com>
To: xenomai@lists.linux.dev
Reply-To: xenomai@lists.linux.dev
References: <87o7a0yx5f.fsf@xenomai.org>
 <20240424085922.41944-1-Fabian.Scheler@siemens.com>
Content-Language: de-DE
In-Reply-To: <20240424085922.41944-1-Fabian.Scheler@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0006.namprd15.prod.outlook.com
 (2603:10b6:610:51::16) To VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:1c3::21)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB7672:EE_|AS2PR10MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: effc1e2b-8f86-4b26-aac9-08dc643d405a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGtLVUh4RzZsQXFXelY5OUZiMjlzTWZBcklxeWkrc0pIYzVZNWkrUkJjeWY5?=
 =?utf-8?B?VURzRndybG1XV0poVGVBL2NkVGE1eEtjTW9KSk9wUzZGSFMySGFYdENRelFk?=
 =?utf-8?B?RmxZaEprckZnV20wc0lCOElic2FOMXJpTC9VbWhaUFQwOXUwb0FMdElISGFw?=
 =?utf-8?B?SklYODBhTnpqTEhILzZjZWJyM1lqMExhcHB5Ym5mNzlnTXVCdXVMb0Z5QWtw?=
 =?utf-8?B?bkk2a3ZTd01VTTcxa2N0dnhUaFZCWWlUUlFibEIza0ZDMVJraVpHLzZEVjBD?=
 =?utf-8?B?QWpDRlA2cmluTE9oRW1jcUF3TGdmNklZVTA3Z3J0ZVJnSVFCWVNhVHBPeDhy?=
 =?utf-8?B?YVdHQmxWOXltTzZpS2tHY1JXZy9qZkUwNlR5cjNwLzFqbzcwUXBZOWdyZHor?=
 =?utf-8?B?N3EzWkdkNXRuTVZXZUtEeTJsTk1MaVFDNVNtM0RCVzM0bkZIL2dNeHpIMUI3?=
 =?utf-8?B?TmZ2SFVmZC9WT3YyU0hPMkhTUmNHMk1OL29NSXltSnR4RzRHVWRWdHNJU1dj?=
 =?utf-8?B?eEh2MW0yaDFjaUhwRDE3YU9ORU9qS3BPZkV1NWlUcjdCZ3VKRkhIMGtlelhn?=
 =?utf-8?B?aHFndjFZNnNISWpublhtRU1yanJwVFJldWQxWlRDeGhmc09BeEFNbk5rNFY4?=
 =?utf-8?B?dTU5TDA1Q1pxZFZKOWc3eUY5OGFEUGRzS0JHVnFvK1FobVU0eDRWSmhKNERE?=
 =?utf-8?B?dnp4WExpRFAzV2EreUQwK1c0QllzblJ0dDVsMFN5UWtmVTM5dkdVWCswUE45?=
 =?utf-8?B?OFlZeEdRZW5NaDQ5dkZpSnZUL1RJS0M1S3JEdUgxL0p6b0N6RTI3cldaTVlp?=
 =?utf-8?B?cFRsZUNSTXpSK2trOUxmNGI4T2c2N2ZadHF0OGpMekFKUlh3dG5yK2pRZWpD?=
 =?utf-8?B?S3A1USt5TGZGYUxZVFMvRk5TU3JqZGNtSVk3SlltK0tyRUpoV0hkd1l2V2pN?=
 =?utf-8?B?NWVucjZ5ZGQwRlRHb0VoRUVlbXV5b2JmdFZVc2c2dHkzZVBiMHBsZE9wekww?=
 =?utf-8?B?YTFuOWh5MG5zcXoxTnlwL2U5RFN4NUIwQWJ0UjVkYWZqeDFseXZmOVkxWFJT?=
 =?utf-8?B?amdLYVRhTzA5UStNeG1ScGFTUllTQm5IdUc5RGw5S1gycEl6TTNEa2MvWisw?=
 =?utf-8?B?UndvK2FSMEUxN2dtOS9wT1FJQ3d0NEtRRVZJb213TzZEQTJQckJjeGFkV3Qx?=
 =?utf-8?B?VGZXT3gwa2dVTklPd0FVdUFmcEp4YWM3UDI4dUtQaWMydWVvQ1RRcnBFU2Va?=
 =?utf-8?B?VUt2NFEvZlVUNk85STNDcmhMdXFtQk9uSWtodDcxK2N1a09aRi9vMFNYa01o?=
 =?utf-8?B?RWdyWjROWTJCUlVMb28xNDBaRnVoUkJTS1IzTmFEMXBHY0FhWFRsYU5zV0dY?=
 =?utf-8?B?cXBBbjA1SGxaMEJ3RS8vdjI2c20wb3NXc0hKNG95bVRCL3JZVjUxZG5Fd3dM?=
 =?utf-8?B?OEJrallxQUQ4cmJqeDdXWXYxOHVid1RoTWtBYmJjMTNNTlh1NTJGVm5sQzZv?=
 =?utf-8?B?czR4b0NoMlFwVWlWMlFIVGJTNTdqMHYwZEhNWU9mV01hU2N0RHdnTjZSU0pF?=
 =?utf-8?B?S0FndUt1VUlCWmttQXVSV2pkcEFseGh2MEVURXIzOFpjTzJ4V3d0aWFHbmcy?=
 =?utf-8?Q?VtEGMVIb9EWPanRuShtK2JuefMYrt7xK1wYXHeYwTkzU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzJ6OHY0TTdZb3c5dmZBajhXNGZxWlUyRXMxUWo2U2NveHllWXFVOHBJb1BG?=
 =?utf-8?B?V2RGY1B4b0JHQ1RXVy9kQTg1cVA1TlRqZy85YW5UN2hJUytWYkx0WC9oVTQ1?=
 =?utf-8?B?RlNoSVlqQnlNK28zYmRVUGR4OXJBRzIxQkx5OHhDRjNzWjk0VlVXYk9wOU9a?=
 =?utf-8?B?RGhsSjQ0NjYwZUtObWkzcm5XbXhhaVF2Q2kyUE9oVEMzcGhxZnhRZVJJczlE?=
 =?utf-8?B?aHoyTFp3ZmpvZ2RFMXdjV3VoTVltd1RFaVBQWWtwdVZBVExQb3BiSktXUVFO?=
 =?utf-8?B?Z0dHZlk5S1FzTkVWcVpjTjlQK1JHc3JVS0tZTnFzODZWTml1UWo2cWc2MjZG?=
 =?utf-8?B?bVA4aUFrMFZ3Y0Z1YU96U3ZmWURWRzN0QWpvNnpQdG9OcXljeVFoM2VoMnhB?=
 =?utf-8?B?M3RUeUhiWGx1dEUxYXlVdkJ1aXdVQUFrQTRQRVIraFZjQUo2a2VrMmRkb2VV?=
 =?utf-8?B?N2s4MCtFU3FGUG5qck5XditQMXZWSWN1UUxBN2FYUmhXUjlmdFEwMHdGa2Jq?=
 =?utf-8?B?Q3creDBDZFhBSnd0Y0p5bFZwc3ZSckR4SnJnU0VUNFhQYlI1NEh6TUR6bHJW?=
 =?utf-8?B?bzBPZzE2bjhtWUZtek00Wk11a0NOaE03c3RxOWlsQXZqZ2MwMTQ1blVud2pC?=
 =?utf-8?B?K3ZNZllUQ0JtUytPa2FxUFZKWmxWUTlKVUh2cTIwcHhXb25zNUxIcHl6ZGU0?=
 =?utf-8?B?WVpBR1I3S2k5cFlhOEdLazh2eTRqY1FsdXhKOUZhU3hac0lvZS9zZVptWUZu?=
 =?utf-8?B?UE5SU3UyV3dUM0V5U3Q4UDZxWElvUm5Kb3FCbmZOb0JDSEVxZXVLNVRPSnlH?=
 =?utf-8?B?eGNnY01UNUJpSmQ0NTV1V2dmYzNtZUwwZEJuV1JPWjd2ZkoxaTFmMFFJVTl2?=
 =?utf-8?B?NTNwbFFJTlg1ZjdOYVlZaHF3eWpBSHdrT3JpakFEY1ZQRjhmUmw3QTdlWUVU?=
 =?utf-8?B?VGI1NzFwOWJNcnJXR1VVMkdaWmRQNURCMjN2SXFBV2o4UnRnMFBhcVpIWWVP?=
 =?utf-8?B?NDVYS1NDWkVjTUdNRDN6N1lMUFBhTEFZdlM3WVlmeU1HdVVhb01xNUxldVJJ?=
 =?utf-8?B?K0orZjU4QkNuUENLaGVEUkxCUldqaCtsSGh5V0kvMGQzU3ZuY0xMRVVnQjhG?=
 =?utf-8?B?WVFKOUREekZsUWNTaDZPUXJlQ3FJVTk0Q3VGa0p2OElWTnJrOEVzQXdCS1hx?=
 =?utf-8?B?a2Vta2hzL1FXbndZeGM0Tk8xQlVGa1BTdnowMVg0TWs1bXpFS1NVT3RZRWVG?=
 =?utf-8?B?UXI4WWw4KzV3RTBQMHhuUEZhNzNsaW9yZTZlU2N2S3VrQzJ2RjJ1ZkJLd2NQ?=
 =?utf-8?B?cGVDakxlR1J6clZkRzFROXNnVDVuck9BeWlqMW5HUVNOeElMSVFZL2l6ZzZF?=
 =?utf-8?B?LzJySlRHaXlIZHR3OTZvVzEzNm5HWWF1TG43NFNJRXpmR1dIZTBMMWNna2gz?=
 =?utf-8?B?YVVXOWlrQ1dycC9GVU1kSzRxTjY3eGpnT0R2ODUwNmtrUnhNQmVPK2h1aG56?=
 =?utf-8?B?RnpsbXIvbFgxampEZ2YxY0ZSMGJIdHd2N016MEFmWmhHT2hycE1CZHRwWDdZ?=
 =?utf-8?B?WGdObi9LcG1DWWo1c3NKaWFnMC9SY2VOOVN1NTdybHV3ZjFsVWJSNm56K25p?=
 =?utf-8?B?bkEwaUhJMWJ4K1I3ZjBpbHY5UHA4R29uOWhCTW1kQUFoQ01pd3g0VVRxdVNQ?=
 =?utf-8?B?Z3BjMWpjSlkreVRLdGRsNGVTU3ROaFNxbXVNZTQyU0dVMDFtUVhDdDdwNkh5?=
 =?utf-8?B?TmhJSTRtOCtoSFRLUlh6aU1mTWNGZkFnUDF2MFZMQnF2a0k3MU9QVWVrbFF5?=
 =?utf-8?B?NnozVmFMdEhPS3pYQUNnRDM3WjQ3S3UrNTlyZjdvb0dkOWg0ZmRwTnpnVVV5?=
 =?utf-8?B?U09rdUc5VkI2a0VWOXZ6OVhYUWFNNVFWWE5HZVdTK2t0Q0hYaGZPdmduWlM5?=
 =?utf-8?B?NXppQktZUFplNmN0VVFIT1JtYVpMc0xxdUZsdU9URjNKSUt4ZGErajlaU1Br?=
 =?utf-8?B?Mys5MkFUMHFtYnZ2Mkc4aHlBRHNFL08wM1I4cEFNbFR3Yk9Kend4bXdwdGd1?=
 =?utf-8?B?QWdHS2hSSUJydDVmTUUxY1lPZFZmMnhLV0VqcGJwRGdFN252KzNTWmVWdXhy?=
 =?utf-8?B?WDA0NmtwL1NKRmRVYkxxOWw0cjIrM3ZIaUJwNUlkMU9raWM0eGdZalduWE54?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: effc1e2b-8f86-4b26-aac9-08dc643d405a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 09:02:21.7785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MEjqDV+jIXJMtMz5KZYRljKG0JdQQfeKUohdbzFaRhzDxAibRSkIwJHWHvx11QJoyh+af+lHImo901D2YZvPY8sLJNgLeygkIwk1IwxoLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6750

Am 24.04.2024 um 10:58 schrieb Fabian Scheler:
> 
> As suggested by Florian I revised the patch so that the correct author is stated in the commit.
> 
> Ciao
> Fabian

OK, something went wrong here - this simply is additional information 
for the revised patch.

Ciao
Fabian

-- 
With best regards,
Dr. Fabian Scheler

Siemens AG
T CED EDC-DE
Hertha-Sponer-Weg 3
91058 Erlangen, Germany
Phone: +49 (1522) 1702973
Mobile: +49 (1522) 1702973
mailto:fabian.scheler@siemens.com
www.siemens.com

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim 
Hagemann Snabe; Managing Board: Roland Busch, Chairman, President and 
Chief Executive Officer; Cedrik Neike, Matthias Rebellius, Ralf P. 
Thomas, Judith Wiese; Registered offices: Berlin and Munich, Germany; 
Commercial registries: Berlin-Charlottenburg, HRB 12300, Munich, HRB 
6684; WEEE-Reg.-No. DE 23691322

