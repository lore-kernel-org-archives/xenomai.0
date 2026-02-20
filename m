Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012053.outbound.protection.outlook.com [52.101.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82B31B111
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771580218; cv=fail; b=ckSTnwNjqv6mSiVTpMmdPkKG+FZUCdG+NT5UCa3gehEjVXEfVMdFo4X6O5QQ6HFufhO6ajxRhiuuC+emTytby+jOopRha0kh0YjkCd6zYJNSCU2RDv1ibCGn4fkGeOlbVzhp0uxFuRDqRaVnHH8aiwTAZ+NbIDQfXDDRDNmOshY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771580218; c=relaxed/simple;
	bh=80PSIg3ltTtJQYdpBDwQ27EWgjATf//7AHqwqPa3l9E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rVtFYIObtygbryeamUApcdqbyKW8v766mH+V+E6sj9Xf7mSGSFEvbMCO9ALpYNThxMBX2GRAyXJPSyE8SYKP8XGUhSc9XGPsLlm7OpZ/0r9w33necmcT3589NG12ND29Ohc5Sut1rn9tCYbpnNMuBEd/ciK/BNxwQ+08nb+9sQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=JVgdv0CW; arc=fail smtp.client-ip=52.101.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JVgdv0CW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pluA0WvsQ0KZ4+Rmg8sCa7jXSLRPcEVWpNpckvmSqvyX/oBlPWd9VR/HeiL28S3SemlCc/QoE1Xio3rEuRTfLob1r13qRWWQPYE+beFzG5kOc7IepegrCjPtn918mEWojavXxaPm+zJjDiU0/N0w094yhMB/Rale7RO0WVAGc7vOtGq+beCOYo5fHNecnsMa4TnHIf6OsHlNOmB61/HE56EA97GMPlO6v7MnzY0YUnlDoETjOa1ByWE5uqvIJgHhCFpV0AZFSrHXhRrNAwKn5RSKv+LBPaFeN3xIRxYMqg186UYr6Wr2ReT6SgEmz0LZPkC/KmKwfrvcRDr/kkTeQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQp2DG1zXrLD149I4iipwi9wedZtd2YAAxxJn8LaUOY=;
 b=gVUCds2TfjnefolozgULdXDG6VkrgwvS3vbESqE1Yx9EQoUA5K2CUgnYm9uy06DVKHccuw2rmXt5tjj6Mc0/kSbIlTcSqxKmM+SggH9408BxxHvnO+b9V8QBPXIranPO3spHCXXVxxpHwjjbEbDSIQWawA66ns4bU4T41FzdgtFJBHdqYMDBn4m5hKQYUdtex6ya1HEJ+/su7KBEwzyQySDAfaAKCoWXwqf+CtsriFok+cWdqCsfZ4GzRuj2AzKqAaoPosHel0L/Y1gSg912sVt7nSPmRy2v2Zb/0twF+d94uXOT36KZnlnB6jMC7t212FyRMIyC7+7HVKx4Sulcrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQp2DG1zXrLD149I4iipwi9wedZtd2YAAxxJn8LaUOY=;
 b=JVgdv0CWJVuGmAzMfgyIzdZvAQ0Eu6bAn2K/+6ku0AHLyRhT56ir1lf+RBxqfKJ9N2Z2Tl0uPOKwcTDpslZYR82nIRi+uBaxsacNYsCrzmWNpD42FOLEvZmWDVV1D/5sTtLQCw0KlsDYlIWe8ioZHPTkl1cEhoP9Dcy3bFfk6/Y77fPUNhPZnygmzls6UNuAIvYyg+NsLh7r4kbgJEgUD+x4PbvpVmwOfUvouJXzTYGNpVTUaPhdp2EVM5Ia5CNxdIGDkZGPY+ghSMTNR8hWlg+zYhz2azjXW2E4AHkptEFAOI1mvPQMT81FwZKbBIuaf4Yox/l93O0JaRudkr9eng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3148.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 09:36:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 09:36:53 +0000
Message-ID: <faebe432-dddb-453a-91d1-77ee48a784ca@siemens.com>
Date: Fri, 20 Feb 2026 10:36:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] y2038: libcobalt: Allow both, native + time64_t
 interfaces at the same time
To: Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
 <87tsvbhigf.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87tsvbhigf.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3148:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e90151-d33c-4e45-29fc-08de706394d1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3BRVWxYeEhuSkw3MWdMSXFvbjJGVkxFWjNKcWtoeDFtSG9vMmRRb1E4bUNk?=
 =?utf-8?B?K0lvYXpjTTNXVXJwcTJYUVVnRGVodUcxaWRPUkJDOVNzUE14WlBYQ0VWSHZ3?=
 =?utf-8?B?QUdRSHU1Z2s3RWs0SEpIVTh5cngxakRRdzFFMTZnMXZCSVFDZEJmTVozWjly?=
 =?utf-8?B?dFZZRU5yY1YrVW9CNXpKQ3BuZk9wcE01V3oxaW52U0ZFSGYyVFF1czlMOWhW?=
 =?utf-8?B?QldhZmJZU3lJM2lwL3NvNmM4b25GdTFSUGZhNS9LOWxiTFY5Mkh3dVRzRVpD?=
 =?utf-8?B?K1hhL2tVQU8zODhRQWgweXpDZHBRdndyWENUWHdZN3dJRU9laVJERmdwOTZw?=
 =?utf-8?B?TTh1N1paano0cXFQaHlOSVhxZEcvVzdFUlA0M05JNFpIR0E5TlE1eEVoV2FN?=
 =?utf-8?B?UUtUc2lBOUFobXBFKzdFS1Zva0hzcFhLZWRwK2ZqZnUvNTBNcGJSajFCVUhW?=
 =?utf-8?B?RnZQOUM3bUhUMkI1SVJTaTJJc0NNRTF5RjMraEI2emtPQ3RWaXlIK3VEK1B6?=
 =?utf-8?B?cFdSZmhmb0ZLRGpnUVZFNlhveGIzZmlHNzU2aXNERktFNnlKMkM2M1I4NFhB?=
 =?utf-8?B?L3ZVbFlTZzRGeW1JUitmd29JSkEyNG9GcmFqSGJmS2RTYmcvVHBadzBlRzA1?=
 =?utf-8?B?UzYzVyt0L3RieWhtMTNhUlIvQWVtalBNc2VxRytLNCtnRzVzS0lMa2pnN3dF?=
 =?utf-8?B?RVBYcGZSOXQ4SGxINDJUYzFCOVlwTnJoNkZyeFdCVnhWeUpKc1hOWURyTWxh?=
 =?utf-8?B?RERmbFlDL0R0ZWNmUHBhR2E3dGE2djMxNzlTa0kvU2JhUk1HUlNQV0pNSnl2?=
 =?utf-8?B?TzNaTWFva3U5M29UZFlDamV3bmpKbVQ4ZlpwWEJPazZFL3ZHRVZjSG8wY25q?=
 =?utf-8?B?ZXNCZ1BIS3JobVNCTzVralNucUhQNGtrOWx1b0t4MHJreFE4c0oyZ0gzbkVi?=
 =?utf-8?B?RFVwYXV2QkFjcytVaFdCQkRmZmhkdlY0T0llNmV3OStJUmVzaG9vcy9wYytM?=
 =?utf-8?B?dnpyRHJYU1A4TjcwSU9jOHNka29aZHRvcVMrOE5OV0pVczJ3b1JsSmZud3d4?=
 =?utf-8?B?Y1M4bDFsNE14RmRndFN5YnpSWkVxNG0wMW5ZUzdoZS9lTWNyQmlXb2QwQmxr?=
 =?utf-8?B?THhVWEZOakVhOU84NHJ1WlQ1L01QQ3dDNFhZaldyTUs1Tm5DbnRLcnVCeHZL?=
 =?utf-8?B?SXUyL0dYdDd5Z1pYUmF5ZjhFZG1oOUszem00RHQvcVlXbnhueWxkY1BONGwy?=
 =?utf-8?B?MDVqdldnd0JTWFhVa1RVWURFTWIxRUtDZnJTS0hxL2g3b2RtdjhUeUZIcGZ0?=
 =?utf-8?B?VS94d1hNaHNGOFhYd0luV3lsdm9udHJqNXJXSnVCZGlNcm9RcVRSdVdQNElW?=
 =?utf-8?B?akdzalJlbm5JL1VDV2cvb21Cc2hmVkp1TVdRenM0SUxST1JoemVhS3gwUWxo?=
 =?utf-8?B?ZW80b1ZPRmVlQlFQOVl3TUhkbEFqUDNxeHNrMC9VZE9PSTVaVTN0bktvcUdM?=
 =?utf-8?B?c0tKdSt5dGJ0cVJMOFJJOWZsczhKdW91a1NFMllJVUp0YTI5MVZ3bktyY1RS?=
 =?utf-8?B?Q3oxb0FPL0dWZHpwUFdEMmxLNFB6d29IQUt3SlpGTlJqVGNFZThDMkt5QmZ4?=
 =?utf-8?B?TWxTT3FPMDRvdU9TalV4SVdWbHB6YkJEaDl1Y0ppU0dlaFRadlNJcXp0ZEhw?=
 =?utf-8?B?SVV4OU0wUDROcGN6UDcxaFlYRmtadG50dklDRzA1Z3Qxdy9WcmFQc3VpTnpn?=
 =?utf-8?B?aU5PcXJSdlV4WHlHdUlCWlFwZC9SYnAzVlh1eEdWYmIvb1EzM3RzbVk3UDFq?=
 =?utf-8?B?OE82bHBIaG1RWHRPK256Y1VsbGxIQXRFbXFNSU8rQlpIKzZza1V3OGIwNFFQ?=
 =?utf-8?B?NzNEMzN2ZlRDelN2d1pwbnhjV2RQMDVNL2JISUVvbGU5Z2wyb0NSNzc5c1dS?=
 =?utf-8?B?cUEvR2YybXQ5YXFBRzRsSlBkVGdiUXEzTVZsaDFoNXJheGN2S29XR1QxdFJZ?=
 =?utf-8?B?UW1rR1UvVmxsSEI4alg1RmEyZUNjakR1YVhZb01rODRCamw4bEl6ak5yL2VN?=
 =?utf-8?B?dzMzTU1pN2loUFcvVnpUYTlmeWNpcXlTQVRkb0UvaDBLRFZtdEh3bDVVUDRq?=
 =?utf-8?Q?3CjEI7dISImCr8y/DWa62Mqw1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDdZd1gwTWUwWEl4ZDNIYXlHazdYMXV3TWp6RVZFNVNVcnRHWVpGN1laVXNC?=
 =?utf-8?B?NlZVZ0RsMlBQWDRsUzRQTWhxNXNURndnbktkSm1FdHlZeDBOQnhtZlp3QS9E?=
 =?utf-8?B?dkJ3b3JDbFQvRGR4V3VyN0YrM2ZMalpETGhnREd4b2VITWttOWRWanp2bVFE?=
 =?utf-8?B?NzVnS0UxOXhYVUQ0SzhBdHF3V3hrMWlUa2hycm5kZGhJS3E1Qm1CRUxMOTdX?=
 =?utf-8?B?T0o1d3V1MGo5N00xamhjTDVaTG50RzBPM01WNjFqZVBNaW5nazFndWVxS3Vm?=
 =?utf-8?B?YWJBRFE4U01ldzVyTHpQd1BTb3VUcXFBNmNxWWxUR2lmM2J5YkdQNmZRdEE4?=
 =?utf-8?B?N1NtdFBvaGN4YU5GMEd6TjdNQk1OakhoOWRodjBEV2trdEVqek1RbXpzaFZM?=
 =?utf-8?B?aUR4cnNyY3Z0MHRpUloyVTIyRFVyV0xVOWtzM0F5c05idDUwU002dHBNWG1p?=
 =?utf-8?B?MjkxRTBoVmJFWXF0dFREZEZwazNIMndyalB6YThZU1dCYzYwWUoxNlJyNVJ3?=
 =?utf-8?B?a1RINWpMaHJ0cSttdmk5OUVwL2xMMFFGTWc1Ykc4SGY0SmxmYUVScHhiNno4?=
 =?utf-8?B?NDJ5TDN1c1hDeGk5RlF1V3paVXNkZVJ6NVJhVGk0SHZJeExTY05ma3dGeWNE?=
 =?utf-8?B?c20wV2xTS2FFaVU5UzhPaHlPMUd0MHRCZ2FsWVpwSUV5T05vWXBtRU1RNXBI?=
 =?utf-8?B?NngvbzBuRndlTGU1QVA4OWt3STI3MzYyTnNhaWs2WkJRNFFNZGE3Ukp0eG1w?=
 =?utf-8?B?emtQOFpvRERWTXRwalV5QlRrcmx0djNFVHBpQzJMQmVORXQzczVMNEZwcy8v?=
 =?utf-8?B?NjczY1Vwa2JxVlJ4a2cwV2dldnR6M1NoL1poaFdHU0VXdkpOM05hZjJvbFpk?=
 =?utf-8?B?TG16UldtWFlBcXYxR1NVRW9YYnBkaVV1SmRFQVpiZ0w0cmNhZ0tndmxrdjNE?=
 =?utf-8?B?WjBZcGtISFFLblBxUW5SM2pXMURhSG9TUWxrbk0yMlBCLzRlUThJZGR1QnFs?=
 =?utf-8?B?em9sdjJhb1ZUU0hNZWpONjlBVm1rV01WeEEwK3ZqQ1g4N3prMThhaTdZNEU5?=
 =?utf-8?B?NldDaEUrODhGTkxIekpTcmp6bWxGeklBeG5za0t6bUNRK3Y1c2gzU3pncFZl?=
 =?utf-8?B?bFJhMEFxNmRtSzlGckE2RHJOUStKQ2p6VWxkcER2UkZrNXcxa0hkeStLcnd0?=
 =?utf-8?B?Zk5LWHhJZE96bzFCaHdpY0V5NDdtRzJ3b3ZKN3AxTWtYbHJkSmVmcnRTNlIw?=
 =?utf-8?B?QTNBaFB6S1NGVEdUVUloTE14WWFLOVgzNjRlZnpGWDVoYm5LWG9FRmRFYVF2?=
 =?utf-8?B?cS9RT3VvcVBxNktBOHRnZFhZaFlIQWtwNWhVSWN2TEtBZFVXejc5cEV1SnQx?=
 =?utf-8?B?VmtTMnZJVjBmZUdabHhQcWRobG5obXVpYm96UmJzNnoyczBpcHduZUxoczN1?=
 =?utf-8?B?d1NEMjBwWW5ISTJNS3Zrb2FTVWtjZE5TVnpOeVkyRjB5N3pXZ0MrK0dKT0pJ?=
 =?utf-8?B?YjZZV050QjlCQjUrRVBRRzhkNXpNVUU3M3JsSjNxc3orMVBMK3pCS3dRY09y?=
 =?utf-8?B?YlB4Z0lkMkVwa2hxMG43SlIvS3JwVmhBMzdDeHEyR0RMRmdwNzlaOWlUTDh2?=
 =?utf-8?B?REdaVlYrSmJlVmRyTisrTG9sdEF0QmpNb1ppczNTZWtzck1jWlpPUjVoNkVW?=
 =?utf-8?B?d1krc0k0RlBXKzNDTFlrWEswdDVBUVhtbGpkbmxMcHVVL3oxVERiZ3piV0Vw?=
 =?utf-8?B?YWp1WWtrbXF5dmRGalRSeFFCdTVZK2I5djc4ekloYmtlUVcxU25abGZYbUdO?=
 =?utf-8?B?d21vSHpWOUVPVi9KR0NtRVZHcWE0M28zY0ZaU3FYMUV1c0M0WFVMd0ZkUFJh?=
 =?utf-8?B?aWtuMXdDbGY2b0FralBrdVg5RWdWR1ZsODZFZy9ZWVRSSTRFUFJEWUxZdnZt?=
 =?utf-8?B?WkEzUDNObkYvVUEzVUgvK2JMOUlwOW9CanIrcnY0WUpJUGExRmkvOUlUeE1a?=
 =?utf-8?B?TFhYaUlUK3p5c2xkajVIT2NScFhYQ21JZnE2VDJYN1d3TTZqMFdHL2MxbWlG?=
 =?utf-8?B?TTNmS0ZLUnNnVHZSclUwNnE1MWZoVTlMdWw0dHRHcU5GMnJ1VWZ4bkVuVC9o?=
 =?utf-8?B?TFErWFFJZlM4eTRwcFJqNUZ2RC81eUNzZ3ZEZ2F5eWNJWEZUYVNXYTdrWi9k?=
 =?utf-8?B?K2IxaU9SUzhPak5DblhGMFpBL2lOSk1wc3B2R2tQY25XVUlTbzB1aVUzdktL?=
 =?utf-8?B?c0hyaDhFT3BIQW1OWk5vOXMyRHEzV2hmVy9ERkI4RFZjM2tlc0ZadEkvY1Fi?=
 =?utf-8?B?ZllQdTBzWWtWUGdpbUlZb1BheXFtRnYwa0lzcnlEU2xweTNpMXRLdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e90151-d33c-4e45-29fc-08de706394d1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 09:36:53.5474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7OITyNGK7Ax6N81X8yDHMCLO2I2XZ71h3skWttTWdqDASnzHzZqtrNVgn/oyYqD4cYOVl6C5TuxYq4MGDQMIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3148

On 20.02.26 10:28, Philippe Gerum wrote:
> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> 
>> Hi all,
>>
>> The current time64_t / y2038 support switched libcobalt to time64_t
>> only, removing the interfaces for the native time_t type.
>>
>> With that series applied both worlds can live together in one libcobalt
>> build which should hopefully increase the backward compatibility a bit.
>>
> 
> Is this series re-enabling time32 in a way?
> 

It's allowing to keep the time32 ABIs around without having to use
--disable-y2038 for configure. It also resolves that we were changing
existing time32-only functions to time64 where glibc actually added a
separate one (see also
https://lore.kernel.org/xenomai/cd03fe98-7237-426d-91c7-c6eae63a617e@siemens.com/T/#u
- which probably needs a rework to align with this series).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
