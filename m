Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2080.outbound.protection.outlook.com [40.107.104.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB86149C47
	for <xenomai@lists.linux.dev>; Tue, 25 Jun 2024 21:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719350373; cv=fail; b=NwY/7JGXzY2PjAtdhpLckw8KyAy1E6B/REJC1q6zP/wfbY+QmrV3P/MHH1eNwumVAhaJjOK9jUdeA2QWK6ksVZvJtIcXzzrACzrqMWLXcAlD62V3HH2xTlWjR4Ay0wN2hd/2ML1Onk3s+2H6rgNN+3uE0NgsciK5U1a0hAVRULE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719350373; c=relaxed/simple;
	bh=YZkOg+K38OcOGKgeCgzTcTC84V1hzeyblGVfMwysTxY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=izbf6rDCYjccYNwzZyLBjXHyc5k+CRE1KWBckQUEEq7x47RSFwUHHTSPA1wDKoVlEZoXZrh3JySlwIrZiZJPdP/DPlnpLbgFevNCzp0751gwoRwLqyWMxd2pNWAYRT/h9MNNnW6FoCVO4ZiEHK7N92d8q0fUw3PNCC/azAInSZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nKqiWSMC; arc=fail smtp.client-ip=40.107.104.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nKqiWSMC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Klj078qqCnKj/JA9CZol9W0q3iIZ3e5VpO2skJH2rP4nEN1E3lTsPVRjzEFRlATKhRPmYMIsJV6rJqdD7GBH1AGNonQUjodzTmnA4Xplu9iKXhwMZ/oFY5EuN+p8UV8SfyMNyzJsc1BzDOXWR9ys4hhhXm+iry2Oiw2XzjM8ZcoMpMESA2b6IOayzjnEacGee6AeuxIvkAsuurq5PdyT3+Pxz0bej1UYwWyTK1lprPpVj/36HP2kx8fLg4COKMtbCOAl+Kilc2KFJTNPudldrXmnQCYVotj2L9NtX5PV4xrGTXfaV8+WdI1JzVyNcZMA0YMxnORPNa2u0VlbriblYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJD/SaB91FPKOI0tX8emJsBNbI58KjZBwHuiRkMNt44=;
 b=F5XfiXofILw/AvLBBC5iZssiXiRhpCgvduvfozwQudN3gjfPrWrymf0U6UNcAMKfj1/Y3uZGZTKbtZyqahUm8X8hBkTSeZFkLER0gvQETbzsCwdpcTbVMd7qXXPX+hOY25ssomF1XfXuMqCqZT3Im4kE8Klq3Hg8EWz93sTmxIm/aOwuTRgE1bP/KRHBU3d2rYwP+cz99AgODt770mGscnI06N9VUZcYkKAraB1JGZpaKxv/EX8BhizPG08lArurvXauFU8ssizlIYwA8JsI9UHCStQZkE3huiSNkm5dvdeq3vUQwn3hu+U5g+Qz3fG7v8CN0CbcuwfFSRtXBdodtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJD/SaB91FPKOI0tX8emJsBNbI58KjZBwHuiRkMNt44=;
 b=nKqiWSMCUFXNZr6DL4bDtBUPJX50g2JdNfHrXUdtZ74788pXAqagZ/wS9e7PNtzFS7PKR03tB182J6LhfgsKPee542iNpCUQ4hsPkDp36TPfTzHh8iyCYeMkHBDy7Nfx6QEcoCVTmtM1l2UDTV45pGZk0wZSyroJouFero8qtUXD/COvL7NMdGr6RSRa4lp/msU86ETL5pseb1t4WH5QOEibxlCfloZ41DBP5+KgVkvDwno/TMUfof14Ff6XBlNZu//yJKfrbbuzNu4Qt/saleO3HRQawCe8+R+oSiA7H3eKj2T+EdLPoA9P7akmelR4zboIID3Ud6hl5GKNdlVdhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3578.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 21:19:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 21:19:25 +0000
Message-ID: <a7ac3dd9-f28e-4d83-9b34-792b6d8905a7@siemens.com>
Date: Tue, 25 Jun 2024 23:19:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] prepare-kernel.sh: Tame link mode cleanup code
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240625203815.24997-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240625203815.24997-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3578:EE_
X-MS-Office365-Filtering-Correlation-Id: a2be967d-7df0-4454-b496-08dc955c7d8e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TU4vYzBOUk4wdU5oSzRnZWcyNzJPUHV2Tmt1dGlpaWF1VWV3NFRIZzNqcTRi?=
 =?utf-8?B?c0Z3aDRQTnJub1ZYaUVxbUVQTXpJSWVDdXVQdWdKUEt1WnZZSmlobXE4c2Vk?=
 =?utf-8?B?ckRhYy95QVlHSVVqRnhJZHNCeHRYZHVUeTNMSndlZDFycFhMSW1rVDZSN0Nw?=
 =?utf-8?B?WjZjY0NkUDZRcGFjYS9XQkR0OHh6UWZmOEd4S0I2ajRRb0ljUWhPNWlDQ05M?=
 =?utf-8?B?L3c2RkVHWm5jQzdFS002aFpvWGNpK25XSXYyTVg2TWp1b2w2VXpsdUlKeXA2?=
 =?utf-8?B?OW92dFpkbk8wMnhhaVNJamNqWjlMYkEzYTNROXNuSG9QZVc1U2VyaHdVYkV2?=
 =?utf-8?B?MGNmcTJrS1hmNU5mQy9MM1pUblAvWk44R0htb0xjbGVKUzVMQlJmUjdVVVpV?=
 =?utf-8?B?YndaRGxBc0xWTVNwMGd6NFFpcmFlQ1pKNHM4YVJiZnNzUUZyMnZmQnphUGdR?=
 =?utf-8?B?Tyt6YWExYlpEd3ZGOXNyVnVJYlk5MFBaa1duSTJsb3RUVmRObzZhOHh4SHNl?=
 =?utf-8?B?VWZkL0hya08ybk1pMjU1eTlFV0U5dWV0V3hTc3dUTXI1Q0ZHdmlJbmhjOHJY?=
 =?utf-8?B?WlBYWXFoU1llcTA0Mkk1R1JvQW85NmpMSllGOCsvM1dnN25KVUNMSGRreFZm?=
 =?utf-8?B?ZGNHcURYRmlhSWlBTHlES1o4eFNhOE84OGJURFFCdTF3OUxoeDk2dVJmd0No?=
 =?utf-8?B?N1BFUERuN3VKQXRKSTAvVFJscHUvUDM1RUUwNEFXSk9OMFU4QW15RWo2MjNs?=
 =?utf-8?B?TU9oano2RmhIdlVRWDFqRmh1aExaSldHajZjTDE2QWJhNlhhaWpjdHNRQ1pL?=
 =?utf-8?B?VU16eUV4SG1DVk9KbThWUThJSVBOdUJPNitnNnFMNUQrSjZrcnFPcTR4bWxL?=
 =?utf-8?B?dTd0SThsS2hMLzVhUXN0ZmxhclN5K0JjZ3dTZnQ3OTVCMWZQVU1LVXJCbmVG?=
 =?utf-8?B?NjRyTUdrcm5zQVFJOFkxaytMSkEyeWxLdDZoRXJKd0h1WHEzbWMrZDJuUC9S?=
 =?utf-8?B?S3AyeGZFb0Y5K0JRV1FYNUt3ODdtTlVOUmxUMzJZaVREVVpaUlZIYS9HaThT?=
 =?utf-8?B?eFZ2V2E0SFQxQWROakZvU3NmMUZEVVlEZ1ZKa3AzNFQ4ZS8rbHpYbjNTTklY?=
 =?utf-8?B?N2V3YXFRUTlzOU5qem1URTRqakpqYmtFZ1MxbFRISzgrWFM2Z05oZDZsYlVL?=
 =?utf-8?B?NGsxNnZacU1xeXR5K2RHcTdIdUdPUldNVXZWem03Ny82MitZRWpaMTludzBD?=
 =?utf-8?B?bDBrSmxUV1hVZVBFZE9VVEsrdWtWd2R6RGFQU3Z4cGJSWjdsY3cyOWcxNkVE?=
 =?utf-8?B?RzhROVh4NklDNVF2bTc3WG5VeDRNWTdNZitkTjA5b3h6aHBhY1FhWVd3Znc2?=
 =?utf-8?B?dXNRZmNxaUpKQW1zSVNwYWV0d09BOUI1dHlGekxVOFZUdXZHbldqQ281Y2d6?=
 =?utf-8?B?cndZRGNvTzZ2WUFESVNOQW1JNGxyenBrTHJJdmI1QjNETHMvd3lja1IzRnlJ?=
 =?utf-8?B?VXRGUk5HY0kzYTVUell6K1hZQnBSaC84bnM4TndESkE5YVhDTnIrQVpkQ0Ja?=
 =?utf-8?B?cm51WVBzWFJSWFMvQ01GMHZQOUs4Q2JKRXFrS0phOGJsWXFoUExXTHVZdWtR?=
 =?utf-8?B?NGN5QVJpcXlmKzg1UnBRdU5ITXFEc2p0ME9RSVRHSG9qN3BtRkpLRUtwRTZx?=
 =?utf-8?B?Q2dINGR6YkxLbENGbEFHaGRyNksxR2ZGSExZdnFqRWZJbkxVMUU1bWhiWTlK?=
 =?utf-8?Q?TY8OLCy6Cluh8tvXfpwuuQh9oSSNQbJqjaDthB0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGNIQVVkOUFkZWwwVWpCY0NZN3RTdG5GRFRuU2M0UVdrUDdQMGljbVJwVjhU?=
 =?utf-8?B?ZEMvVXBoRWhtY0R4WlNTWU95SjR6bWRKeXNHSGIxa2toSGVXMUVVUkNFWHM3?=
 =?utf-8?B?b0Fxc2NhcVNiMGd2UEdSekNyelI3ajZsdWdWbXNnVFFYOHlUbEFTdkkvc3E1?=
 =?utf-8?B?RWZxUDdtdUtpbE13bGNwSWUzNkVHSVY2VlB4QjhSRVVieHZ3VUpVNVBUZ0Jm?=
 =?utf-8?B?SGQ5cVM3OTFoZHJCbytOODlQQktrMnZWajZoTmxYSUU5K1lva0pveGg1a0Z4?=
 =?utf-8?B?M2ROSWkzYnJGeDBCUHQ5QmhjVGpobmZRcCtoclk5Snp4UDRzaEUvdkI4dFdB?=
 =?utf-8?B?M1FGK3hQREN6ano1LzBLQ1poeGxpK21ZMDlQdEdUUGdyNFc3VTNDeVlPbjE2?=
 =?utf-8?B?c3VmNlE2Y214K01NRU5vVmR5Z1RpTWlVTG1SZmhEa3lzam9vVjhXS0tYSWNa?=
 =?utf-8?B?cTRWYmtpMnVMZCt5bTR4L3N6aCtOTldheFo2Wk5Yd08zZEtCc3UvZkc0TTNt?=
 =?utf-8?B?TDdPZWRSdUphQTdRSkpnUldEdGY3Y2Z0SFVBRXFza2xwbEZ0SVFTakFaNEhN?=
 =?utf-8?B?czd1NUlGdkZnSzBmYTFEci9sUG9uODFoYzVhdmQ4MTBRTG9qWTBrMDR0Z2NP?=
 =?utf-8?B?cVByaUhMbTdIcGFUNS9IZkNZZmc4cnp0SGN5aVR3cWRGNFRoSkxBSmYvQ2Vm?=
 =?utf-8?B?TVo0VWFtWlVZNmJzRFR2aXBPbEpjcThGcm9Vemx2c3ZXS3BITFZ1QzNvTFE1?=
 =?utf-8?B?c2VqdlJCN21RdDhYTTdCWnNNMk5vRDVvelZVYkluNHZ3Tm1OMkVpQzFPNFpt?=
 =?utf-8?B?dCtiRnJad3JEeExWTkJSWW9LbXZsakJFYUF5aHkzaHkvN0piZDFmZUxMVEN3?=
 =?utf-8?B?TllOL05tSUZBL2ljcE9udmgvQnlSSUViN25BemRXU3NHZjE4dFVubGt2aUVr?=
 =?utf-8?B?bnNVNXFkaVZMNWN6SkU3TEhzbHRUdzN3NmpocVJhWVozbnhQV3czODJZMndz?=
 =?utf-8?B?K25qN0RrWDFCTXp3SlQ1OXVRY2ZWTWxBZm4zOTRDem1vVkk3ZlhnWkxrSTl1?=
 =?utf-8?B?eS9kS2FMS2Zvb0NLQTJMc05xZFlSSUtTRzcyQ1Rub29DODBqbGhyczVaendJ?=
 =?utf-8?B?a2EyQk5iQ2tXMDFZT2NRVXRXR3E5dzVzZTV0VUhwV2xOSWwrSU8yUXZlMHdT?=
 =?utf-8?B?RDc2dzMrRFp6Mk5tVTY2MEFDOFN4YXBNcHRpNUthZ2RZNmhMSFVmNWZiZS9h?=
 =?utf-8?B?TEszb0hCV0NhNjNXTzd1aG5kU2h5eVFHaktXZU9CY2pLeDQzdzBZY29rN25P?=
 =?utf-8?B?ZFAwalh2UDFNYTRubk9sMllQaFdvZGRLall4ZHRYenlXb3ZGT2lkS3hsV0Ry?=
 =?utf-8?B?RGJHckF5aWpuL0JUWmtmSlNtRGJrVHltL21QVURUdkZDN0hmVktDMjk0RFo2?=
 =?utf-8?B?R1p5VUxjcUpmeU52bk1BOWp1ZHU5cjQ3a3V1Z1RySEwyUjduTnRKTW9nMDJF?=
 =?utf-8?B?TmpORFpwcCtiK0gzeXdmbCtxRkNNcW5RY3RwWHpTYVJ6TzVhWkQ0L0hKSDJW?=
 =?utf-8?B?L3l4Yk1NdzJtaEQrQkNoWG4vblRnTHlsUXdOVnpuMXBQV1BIR0dBVm5zRXNY?=
 =?utf-8?B?ZmRPNEtqRG9YZVl6MnVWUDN5elRRVmpCZVFKbGFjTkg4RXByUmtVSll2bzlO?=
 =?utf-8?B?d09udGEyK1hyMUhmeHBxSmZYakJGUE9POFdBNE4rV2lxd1lrdkFIZmlyQ3dr?=
 =?utf-8?B?UWROUGZaN2ZST1Y0ajVPb1RURGpwcHAzV1lmYk84N1F5WW1PYm5sNnA4MUN6?=
 =?utf-8?B?ajlCTGk1b01XRktwMGtIZGZXMDdxeVdhbk5BZXR4V04yY2QyVEhhcGRNdmQ2?=
 =?utf-8?B?MkR5bnFNTmdvMnZwWVZlOU4wWU02Qk5CczNuTW0rQ2J0N3RkNWhJc2E2cmNn?=
 =?utf-8?B?ZE9QOWFPdnNJZTJ0VEorclloWmtzblcya3dVVEhQVGpkTUtCem8vUTYwK0tr?=
 =?utf-8?B?ck5JUS8rU0ZWUk5zV3RSU1pOQ0NQNUpmZC9FSms5TlovS0w1SGQzd29iQUsw?=
 =?utf-8?B?RHJqYk93M0xoTlVJTnRPQW1FQkNGKy8vOEVxOUVGV3Zzb2ZRSGtyRUZWT2tV?=
 =?utf-8?Q?1og3GqayZ3L3ttuOvSJwpwRoC?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2be967d-7df0-4454-b496-08dc955c7d8e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 21:19:25.6852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2egPRpeQnIkGXZgxG5cTiJZ62zVjIUDj54+39qkxMX3oew72AfYj5kAqIsE4sPXPDNNRI5vo+NWYDc0e9baI3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3578

On 25.06.24 22:38, Richard Weinberger wrote:
> Reverse mode introduced an odd regression, in link mode suddenly some
> links vanished.
> The root cause is that after a further refactoring I have changed
> the sequence of patch_link() calls.
> 
> A sequence of:
> patch_link r n include/rtdm/uapi include/xenomai/rtdm/uapi
> patch_link r n include/cobalt/kernel/rtdm include/xenomai/rtdm
> 
> caused the second patch_link() call to remove all links in
> include/xenomai/rtdm/uapi because of the cleanup code.
> The existing cleanup code tries to delete stale links from a previous run
> of prepare-kernel.sh.
> It removes all links below include/xenomai/rtdm/ which don't exist
> in the Xenomai include/cobalt/kernel/rtdm/ directory.
> So, patch_link() implicitly assumed ascending order of calls,
> the new reverse mode feature explicitly needs descending call order.
> 
> Digging deeper unearthed further odds in the cleanup code.
> Originally it used to rm -Rf stale folders and files, but after commit
> e72d695a7 ("scripts/prepare-kernel: only purge links from target directories")
> in 2010 code tested whether the target file is a symlink.
> So $dir_opt and rm'ing recursively is not needed anymore.
> 
> In order to fix the regression, change the removal test to remove
> symlinks only if they are broken.
> e.g. when they point to a moved/old Xenomai installation.
> Also run the cleanup code only when not in reverse mode.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  scripts/prepare-kernel.sh | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index 5108737ea..0afb812a4 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -57,18 +57,16 @@ patch_link() {
>  		fi
>  		if test x$recursive = xr; then
>  			recursive_opt="-mindepth 1"
> -			dir_opt="-type d -o"
>  		else
>  			recursive_opt="-maxdepth 1"
> -			dir_opt=""
>  		fi
> -		find_clean_opt="$recursive_opt \( $dir_opt $link_makefiles_opt -name Kconfig -o -name '*.[chS]' -o -name '*.sh' \)"
> +		find_clean_opt="$recursive_opt \( $link_makefiles_opt -name Kconfig -o -name '*.[chS]' -o -name '*.sh' \)"
>  		find_link_opt="$recursive_opt \( $link_makefiles_opt -name Kconfig -o -name '*.[chS]' -o -name '*.sh' \)"
>  	fi
>  
> -	if test "x$output_patch" = "x" -a -e $linux_tree/$link_dir; then
> +	if test "x$output_patch" = "x" -a "x$reverse" = "x0" -a -e $linux_tree/$link_dir; then
>  		cd $linux_tree/$link_dir && eval find . $find_clean_opt | while read f; do
> -			if test -L $f -a ! -e $xenomai_root/$target_dir/$f; then rm -Rf $f; fi
> +			if test -L $f -a ! -e $f; then rm -f $f; fi
>  		done
>  	fi
>  

This is still fixing up patch 2 of your series, right? Could you rather
send a new version of that patch so that I can fold that in, avoiding
any bisection issues? Please make sure to pick up the version we have in
'next' right now.

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center

