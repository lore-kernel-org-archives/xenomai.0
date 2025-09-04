Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5DC7081F
	for <xenomai@lists.linux.dev>; Thu,  4 Sep 2025 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981009; cv=fail; b=n8Ww/aujbLh+1xdNMhZVk/92OSCd9X+xxCkRhkYxZgyKTCY1H8x3gWLhS95Y/pMKEPr99SuD5sdvbN9qeRLiRVVR34ycmiEddxYn4oN1EH9F8NeSHC1uN+HS54FlYAE9CAlUsTqLrVPykumM/0rFApjdZyejo3aJfiOsP1VGLBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981009; c=relaxed/simple;
	bh=j2QO+EXlnVkD5Jrusm0MdjVo6Pyakyvt6bhCF7GVHqM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QUCACE2W8exKguHyzMYgjWSd3yxX/M9uxz0nAPP1VvDrfnHd3TUqBZxKLU/auHdKBHV4gi7D3xZNFdpRKq1pdAc4Dc6/7sOoPLKjhHaY0O2Zdy7fnZrZ8EoXMRqyEJShYzEZxx1sjIeU5/p25JOrc57nl214GMn04+n8FKCNJT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xWttAk30; arc=fail smtp.client-ip=52.101.65.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xWttAk30"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OawyrD62yB2+t20wwPqVOpTvkbbmUWWvYQDsBfT0nwPPHjwIBi2aIj0xu1UoJXhZps0yHxuO2SkmgMngQowppkKSkGpDgJNB9S0auSS6V7sbA+SMRN+Ko7VFC+5r0OiFGQEQmWsAKYHIE87noWfHM928Rfv1AfQfmvke7R9IDx68ZnyOq9x9ucPEhnAMq8ql5cS7iEBRa+ic2pzVYejl0c7UBkK9gK7atFAxV3YIy+FosftP6OcoJw1wZkqfvBOFgpdWG0AYTZ022A2zimf8JzRggE1IxTOQpBooMc9F5Tb55IgBV/dErk9u6rx8RUUXSLrqDQnx9zA1oBhX89todQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9yQ7fwZraVg/Ro1DpsYSZ498TKOUuO6E/9jjaP8+9c=;
 b=wxN9K5L8Diz7s+GXYKmyOgUH3fZYS2u8LDhaW0rcr4oCNcye5I8ImibxoU/638vdy3DePwjDXVNNB/QNXLYVOjS7RjqLr5kgoisz5gwcLhm+hX/UkNMI9MDTeBAHdtlFdxE6DNV4E3Eb+FewSbMXhsvLrg2RUtVmbjS6Omz8NNa5v3iGN8fLX9ti/UWsoKwfQm9bWX7ylkLJoJzRE9Zf5xECDR6Jbvpeydzo78z1mS99pX9ygsTD76kMZDtYpfoCWxWizYlYH80wwi9RIzm4WzP1UiRXhbBVMea5bxkD6gV1/3Qw5YxopOZ14FK1gVfWhnIj9XeV+yHaxArVowdHJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9yQ7fwZraVg/Ro1DpsYSZ498TKOUuO6E/9jjaP8+9c=;
 b=xWttAk30OUxKBCHOvWxesnR+VZByZ99yUPv89AzeDKLiegxSl2ikFs3gnvY2O+pFoNMt8Tpegb/pwWXjBHM7VJGvi/SIlbWmJS4lsjpVmofvRq3W66vF2G1tmNM6Iqve0N4q8u2sF52aUBBvyzwC56GJ9fFGw7mlwme9hCf0yF2IrANrLQ03cU5ShwoC6GIGKCGKIg2KoLqpXA/kbTpn/GWxsILZ0FhJJm9xxIJS8hJ9UgGpKM9OkhaPdiViNR9yZ6U+sUurlnwrSUDhr3FWcZUhJduUQ/wUt/d2fQg2mEDQUqXTJ62t557/qzeBosov5BQkDyYFjtKdmRAVgdHHlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS4PR10MB5646.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 10:16:38 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 10:16:37 +0000
Message-ID: <0e0d9e1e-7c65-4326-9661-dc7ea895dc8b@siemens.com>
Date: Thu, 4 Sep 2025 12:16:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ci: check the device health
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>, xenomai@lists.linux.dev
References: <20250904093014.2037482-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250904093014.2037482-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS4PR10MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: 322eeab8-3bcc-47c5-ec9a-08ddeb9c21e3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWtOWktTdVpTd1lQNGsycmpib2Fld3l3enhjdEdKcTlKQWY1akVXY1FXWlZ1?=
 =?utf-8?B?M2d0YTZMNHRia1k5Z2w0ZEc5dThUSE92TWtvUFRzOWFDLzdxOHNLbUdvVnZq?=
 =?utf-8?B?ajJ2S2pkQU11VE1IVkt3R0lUeERLb0ZFR2VvekoxSWczcjEvTzkyeWZTa3JU?=
 =?utf-8?B?K1FFNk1CWXdzQXlNUkdMbmlXL0hhSTJYVHJVTjQ3WE1SelFtek8vOVZ5MlB5?=
 =?utf-8?B?WEYxRWx6QWxIdkpWL0pFWUpxV3pZWW4wUXgybmJzNlROR2ppc0Z5a0twUUxG?=
 =?utf-8?B?a1M2MitJWEs2RDZWcm5nZGQ4c3p3UFo3Nk0wR1B5MU1zQkR3WDQwN3Z2cFNG?=
 =?utf-8?B?d054UE01U2pXdjkySUZhbmpXRDJuZUtmWmQyV0hCeTZHd0tUS2UxWEN6clJq?=
 =?utf-8?B?bGNYZUpZaWNhZUsvU2dSa0FlbkZraTllYTNITDJERTc3RjhPbUVjNVdkNVY5?=
 =?utf-8?B?ZjJKN3ZhM1czNWN4SWkwSk83TGlTZFo0WEd6TmxzbnJ1ZTdGRVdVNEtDMXVz?=
 =?utf-8?B?OUZDd0Q5ZjIzRVZGUTRYcDZKQnh4WGlZSkVqdlAvNDBkclRWNk5DRG9uTWNv?=
 =?utf-8?B?dVdlZWYyL0RrUEFaVnU3ZmgzV01UbTJqSGk3RC93WEtZSVJkK0JFZDVFTllB?=
 =?utf-8?B?WGM1L1I4YjBkdEljSWM1a1JHeEFZQ0JCcXY0ZWdWTmo1ME9GL3lBYlV6Njgv?=
 =?utf-8?B?d3NYenh1UzVMUGRXdFZRazVtWDJFRDJmMndsTTZPc0NjZjRac0ZkYzZZaTVk?=
 =?utf-8?B?dFJsTHJpYm9KWWdWVGpGN3hET0lXUmVyL1BERERCelBNVkJ1KzVaNGViL2dm?=
 =?utf-8?B?R25vcXozcVh0d1JJNUhqUGhWdy9GODZCdW5vV3AyWVc5N1BEd1psQUE0STNG?=
 =?utf-8?B?UWd1SW9GQUdjVW9VQmdLWmlyMU13VUFob0ZkYU51QloxeVFOckhFcTJzUE9P?=
 =?utf-8?B?U252WHR0QnR1NGQ3WWE4dWRSRm1Wb3NnVS92elNObXRHQStIZ2UxeWpsdy9x?=
 =?utf-8?B?VzRNS1ZnQnJuUHEyOWI0Si9vSlFJeVJ6KytIaHdMQlUvY01zZ24rK1NLL21h?=
 =?utf-8?B?ZjVhTGhFWVNRV0hJRDhGbjJpaXJRdzJLcTY2RE40N2x1QkdhMGNxTlpZaVRw?=
 =?utf-8?B?R2ZHZlJ4S2tEL050dDBBdnBTN2dFZ0VlQ1I3bGtKUzV5NnV5WWw3T2p2NDky?=
 =?utf-8?B?NGQrWDZMbm5QTk9qaytFSVdxclNJbVhSNTcxZThHd1dwcFhVSE1QT3I3Ym5z?=
 =?utf-8?B?R21PanpDQ3NzLzAyWXJaYWhBcVdYaVBtMUVCeCtWaUF6MHlWOEFlOWdvM3Fi?=
 =?utf-8?B?WWpScGNkZlA0MkhzNkRLVFRCL0p6NE9GcWRYTkQyQkMreEw3cVRITnVsVVZx?=
 =?utf-8?B?cTFBV3AyRE5peVZ3Sy9KeHF2Q2dROU1YSWljNmlLb3ZWZEQxekYrMUFHQlBm?=
 =?utf-8?B?MXNrbzVKRnJqR0pnWjl4Z2JkV0ZyZU56eGdNbUdBM0hPQVpOcjFmSjFzOUxT?=
 =?utf-8?B?WmZaT0pDT0c3TVFJbURHMHBsWlpIbGxlREtycGpnbXRrbXJCUEtNbmJPWFNE?=
 =?utf-8?B?Mkx3VmNCNjNmZXIxRWRIbTFqajlFeFdtUFZ4M2F6QktjNW8rWUtvaWw1RFVC?=
 =?utf-8?B?OXhQS1ZZTXo5SWdiNWxUR2V2T24raks4N0pXYzR2UG9Ed3RZOUZ2UDVUVy8v?=
 =?utf-8?B?eW5tS0dOQ2M1bVYyR3hwVzlkYUloNENsNzM4SllXcGFlaXU5TGZNSTBlbmpV?=
 =?utf-8?B?M01zRmtQL0w2TzRGZkpsc05mdGRENEE1aXd3T2FES3piMHBDZ2FPS2NiWUlN?=
 =?utf-8?Q?XSvVKCoavn4OPMIwb2tmdv2WLOIAMpQgHE7kE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE1IUGl3c0FwOHZveldzb3ZLcTVldjdJTDhCQVdQeUY0dThNYVlNZXl2NEpq?=
 =?utf-8?B?ZGVLSmdVYmRNZFNBNzFNOEE3RGdYTEhUb3pqS09keUplVjBFVWp2WVRHT2VL?=
 =?utf-8?B?aW5KcmFvdEFkN3FOblRWQUkwa0lDTGYrOWVLNXJpd3NYdUY2NzBsbTJ5L2o2?=
 =?utf-8?B?T01wTkY0ZGNNVFFrV1QxTFJNUnNsUmU0YlVublI2OUU1WGtITmNzMC80Vzk0?=
 =?utf-8?B?aDRlMUg1cmc5aVFuYVczbDNrWnBKcEM4RWFHdzhxVVc0NUNMdkxYUmt2WFQz?=
 =?utf-8?B?YWt2UEF3NkZRcUk0dDBHSzNJU0kxUUd4c0pxR0hkOTNGYkdwVkp0WENicGdw?=
 =?utf-8?B?c1FTOHMzcm5LclArb0pBckpTSllPMVljVUlPZldYYnQvVHB4VHB0TDdXWTBR?=
 =?utf-8?B?OUF0SDNUT2RGazY5ZHI5QkV4alJIVWxiMEh2QmNmSTBrVlRTd1JZQjNZRUpQ?=
 =?utf-8?B?TVhBQlJIYXBSdmI5WTNpZjhUUHVQVVVsQ0IzV3BDeHlsd0NiRENMWHh2YWVk?=
 =?utf-8?B?RitKU05YelQvbStzWlpHVU1PWXpteG1Sam4zbXNxa3hpdmZudjBDQnZuekNJ?=
 =?utf-8?B?WXdZZCtrZDQzcXp6OXZrUDhHSDBHMzlOTThnR1pMV1NzY3NXR1BhcE96OHNs?=
 =?utf-8?B?eGhZRlYyN3ljbDRPQnJUZk52V242U0dlQVptZjYxTldwZmhCRGYvNlhabVhi?=
 =?utf-8?B?NURwNnZhTUVCRzFlZWlSQzJ0RmNGWmNjcktxa21VTkZ4eFJnYzJ2QzJwM2Vv?=
 =?utf-8?B?UFVoMFhDaHFadnNybE15VU5sZnRUZ3hpaUlqMU9SbXIzblFjUzM1WWF6eDNh?=
 =?utf-8?B?dlBPdlgrdlFYUWowOTRNVmRaQmowS2FacjdYNXZIRWY5TWpScnhTSjhFdkta?=
 =?utf-8?B?ZHUrdzlDRWhoY1VPeUx0RC81Y1o1bERTcjdnekpkaGN4V21DbjU4NDcyQ2k4?=
 =?utf-8?B?Rlh6bTVYNzU2aVgrNXBKQUNiOWhkWnIwUTJkR1Y5ZGFXOXY3ZVA2NEc2QlZZ?=
 =?utf-8?B?bXZHVXZEU05TYllscUVzbVpNVWJ4RFdXRTJsNHVDQnBOTXN0eXBkY0d1aS8x?=
 =?utf-8?B?c1pleEx3Z3ZJZjNIUDFoNm95eXd5RkpNeWwzVTF5UlFiUXFpS0dRbVFGUnhU?=
 =?utf-8?B?eFFnSHpHSUZhU1ZRQ1c5WFgxVG5yb3V6QS91M2pGa0hjZmRRblJ3eWNTd0pX?=
 =?utf-8?B?azdnSGpOVzJHMDVkWW1oNnZFT1lObjV5Qm1CejVPUFlENG4zdlhTU1FsdUdY?=
 =?utf-8?B?SWdvOVoxcERkU0VsVVZHSDVzdUR5bHQvOEhHT0Q5UFNLeWo5UzU3Y0RsNkRj?=
 =?utf-8?B?MTZrOHlJYXlJb0JxOFVudFJKT3FvOWxPZzA0UWJRTDhNeUkrL3p5SmRDU3Vk?=
 =?utf-8?B?ZDZ6dUVaTi80QWZqQ0xQRTRJVGJuRlpGNzQvdEJJUlBOMDUxVjZVN2xaQkhI?=
 =?utf-8?B?SGhTekwyU0p6L2ZnOWQ1Mjh6VHU5OXBNYU1CUFFnckpmN29FNWFtaWJDby9K?=
 =?utf-8?B?d0prK3Z4QlhUQSswWitTM2dUTzZTOGdCL3dRelN1Yno2L0R1UG1VWis4MERm?=
 =?utf-8?B?NUt6L3B3Yml5K0ZSWHprMjZxSUt1UkFIWHRCbVFzWHJOZXFEMTNSZWdzcXlE?=
 =?utf-8?B?b3ZjL1QxcFJmOFRsbm1tWTc3RThVNnhWRytVMC9HVHlSc3ZpbEZ2UlFBeDlL?=
 =?utf-8?B?ZGY2cUJUK0hBeklnTjQ4eHcvMVhVVExwdkNmdHJtNmpVOVptendKNXBqbG5r?=
 =?utf-8?B?ZmxZTnpBSHA2cG9OUExaMTZPL0NWS29IWS8yb1J1alFKL04yUDRNb2MybHhh?=
 =?utf-8?B?SVUvVVgyZ2dWcU4xMXBuVnMzay8yVFkyNzdOQy9IeFlPU092QWtOYXFMNG8w?=
 =?utf-8?B?ZmVCcURqTjNIU1RIbWdWQUxQM3ZhS1Vwc3FSZm0rUjNHOFhjNkZzdnFsampp?=
 =?utf-8?B?RVUwMHNKVFAveDBtdmNwaFpTQzhwWko0TDhwZ0U1VTV5MkJhZzhmYktrMldS?=
 =?utf-8?B?U3JVdGxrL2tPemdJVk50ZllPUlFNTUYrVTNleXhseGZGbS9WSXVlT1FRTGVW?=
 =?utf-8?B?eG85emFMZUY2MVU5Y3B4bGQzeWtHRzBzL3lSOFl4Snp4WGpPVE92VjFQRnRu?=
 =?utf-8?B?UGtqMW1wMThCSDV3TUFab2dnL1BCcWdOaXJGNXN5YlgvSldqZyt5bFpLM3lY?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 322eeab8-3bcc-47c5-ec9a-08ddeb9c21e3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 10:16:37.8236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnDvFXQsnI+fNPwoWl/ZZX2BNg5H1tOGbqH+3shqEi+LB7HIyonbgIfTIDqC1Qu/d4hb9Hp6CT6PUHnU68taaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5646

On 04.09.25 11:29, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Check the device health and the device state. If the device is not
> healthy or the state is not idle try for "WAIT_FOR_DEVICE_TIMEOUT"
> minutes until aborting the test.
> 
> The default of the variable WAIT_FOR_DEVICE_TIMEOUT is 10.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v2:
>  - simplify get_device_state by returning directly
>  - correct white space
>  - Add documentation for the new WAIT_FOR_DEVICE_TIMEOUT
> 
>  scripts/run-lava-tests.sh | 33 +++++++++++++++++++++++++++++++--
>  tests/README.md           |  1 +
>  2 files changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
> index 5545dc5..2293872 100755
> --- a/scripts/run-lava-tests.sh
> +++ b/scripts/run-lava-tests.sh
> @@ -24,6 +24,20 @@ get_first_xml_attr_value()
>  	grep -m 1 -o "${tag}=\".*\"" ${file} | cut -d\" -f2
>  }
>  
> +get_device_state()
> +{
> +	device_type=$(grep -oP 'device_type: \K.*' "$1")
> +	devices=$(lavacli device-types show "$device_type" --json | jq .devices[] --raw-output)
> +	for device in $devices; do
> +		device_json=$(lavacli devices show "$device" --json)
> +		state="$(echo "$device_json" | jq -c 'select(.health == "Good" or .health == "Unknown") .state' --raw-output)"
> +		if [ "$state" = "Idle" ]; then
> +			return 0
> +		fi
> +	done
> +	return 1
> +}
> +
>  # S3 artifacts
>  artifact_url="${LAVA_ARTIFACTS_URL:-https://d1a54g2tyy2hl.cloudfront.net/artifacts}"
>  # public master
> @@ -42,12 +56,27 @@ TEST_TIMEOUT_MINUTES=$((TEST_RUNTIME_SECONDS / 60 + ADDITIONAL_TEST_TIMEOUT_MINU
>  export TEST_TIMEOUT_MINUTES
>  
>  echo "Deploy artifacts from '${artifact_url}'"
> +test_definition="tests/jobs/xenomai-${TARGET}.yml"
>  
>  tmp_dir=$(mktemp -d)
>  template="${tmp_dir}/job_${TARGET}_${CI_PIPELINE_ID}.yml"
>  
> -cat "tests/jobs/xenomai-${TARGET}.yml" | envsubst > "$template"
> -
> +cat "$test_definition" | envsubst > "$template"
> +
> +echo "check for device"
> +time_elapsed=0
> +while true; do
> +	if get_device_state "$test_definition"; then
> +		break
> +	fi
> +	time_elapsed="$((time_elapsed+1))"
> +	if [ "$time_elapsed" -gt "${WAIT_FOR_DEVICE_TIMEOUT:-10}" ]; then
> +		echo "An test device for '$TARGET' is not available"
> +		exit 1
> +	fi
> +	echo "Wait for test device '$TARGET'"
> +	sleep 60
> +done
>  echo "Submit lava job"
>  
>  test_id=$(lavacli jobs submit "${template}")
> diff --git a/tests/README.md b/tests/README.md
> index b6421b4..b8288e7 100644
> --- a/tests/README.md
> +++ b/tests/README.md
> @@ -111,6 +111,7 @@ The following variables are used and set by the ci system:
>    - `LAVA_ARTIFACTS_URL`: optional variable where to get the artifacts for testing
>    - `LAVA_MASTER_URL`: URL to the LAVA Master
>    - `CONTAINER_REGISTRY`: Container registry server to pull lavacli base image from. Uses registry.gitlab.com if unset.
> +  - `WAIT_FOR_DEVICE_TIMEOUT`: Timeout for device health check. Default is 10 minutes.
>  
>  - Image deployment settings:
>    - `USE_S3_BUCKET`: Set to `1` in order to upload build artifacts to AWS S3

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
