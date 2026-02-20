Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013037.outbound.protection.outlook.com [40.107.159.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E135920D4FC
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771601486; cv=fail; b=KZvnxaJAz3SMnO90zcl0BlebpiUChDr1h/Cn3jEdBW+h5KN5HieTsF2Yx0AUcXgDUxEoUjVMysRRvqBpLOaiHMnAGjxWvDZMPlMbMhtr3Vz4ie+6zTKL31Gw6I3ebelLMU9KpZxj0M1d0KObiOWg+soI22QT5C6bZ35S3RKYG5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771601486; c=relaxed/simple;
	bh=oQBr2yOmCIq5ppGSzIvoTFHxzUPGlI6rIPDi0Yn6oiM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mXXlnX8ahfhTRpkiQLkvmCxbaU+ajm0m+aLfMgJRKAa6FocPvPRAxoFk8cEWhsFR9h5ksWnoh7eLZb5jz0oieT5SZEAWo354kxaWbVNsgeiH1lBaQ3lgj68+gtLA+stdnuaU0KXDvweksEbWC00ZjC6w2Uq7TIAWdwuYl12d4Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kAz4XTQr; arc=fail smtp.client-ip=40.107.159.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kAz4XTQr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q600eUf+DgFmI7tYa9TXQF7SSAh64dWKeodMAOlpHlli2iDhYtxJZA1kf129GQTmsjcf5WfVFR+WE/bSCIpq5X/vQv+yy4Iah98rQ7G4sQqF2+PRxrR4zl/tUok6JUhCwf6ZEDI8AVIKSpx2OjN9vo/y79GoWoNI9Yl0a6CiIgY++T+44RJIfHwnRFUnw9lLjdd20nMUocgQRXWW2GHJY3rAUUK+G0+lGr6xQr+mueU9AaZPuj9CNbrSD66CZ9gY+JPN1xHBixNwcJeJVDeDTkcDNlHufCwD78POb6Ghj0F8nt9iBmycBEgd4RmUEnD1w8l/nrLyremvd1+7zQiikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sz/34Lht23CUWkRfpUe3kOkOhIhMMKBFN1sMNPgaTQg=;
 b=uA1NjzlOlecQGLwb7KZ2tyESW9NH6hWwDa3ssPLTyDPHqB4vCLh6Y1QdGg5wLtg2e0bIJyhePBMTIEDqNAokZYhOlzdqcO/BQQeIWtmgeKW0vkTJqvOqP/hXyjFmQyUsP7p3ZRuhnDhKC+l7StbVmQP5shdN5xDPrkDlrJtBKG3cOH0KFPDt5F4MlmO3CGUs7eQf2Arl39OsaDRMV7fUc905EU2f8HVmQ3Vo+XJhRQZJKIInhSeIoPYsBGuPEmBtK8a7HdFmT+ZnaD/xkFzqpx8NMaguScdb/jRCT0XcYGyZwDqNHQZqo3EgQYZBHvwOhZOtIh+ylgOK/SeHV31Aww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sz/34Lht23CUWkRfpUe3kOkOhIhMMKBFN1sMNPgaTQg=;
 b=kAz4XTQrd+LehFl8D2Na/DOJUf1aZn12kOPEDNJVZiHuszVEb4KXeMjtHofOazL9FFpETVIUyIyBI++pW2cu1zpb57G8X48+BUrCxAC+6PkGIW55YMaVz3j+lEPMVAdL+l7vXAZ7BBrsSlTfjeR1eRUfeEq6Fp71UL4pI1EQaeeGzDoC5sllOruFv0ER4C0rgSTtRz/kspTh5AKETaVpoW1SfyJm7xTOlzoVp6MLpzdlZqSwG7M52AnnRWzkhdGRydXRrlGQFqSpY/cnHP5SfZ9K+cXUcPegRCUS7uoOrDZZ4fSi4kdu6QILficqEMaBbWg6u88/NdbUXFZDcm+JDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8059.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Fri, 20 Feb
 2026 15:31:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 15:31:21 +0000
Message-ID: <f5275c77-b91c-4a2c-8476-7253a13150b2@siemens.com>
Date: Fri, 20 Feb 2026 16:31:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] testsuite/switchtest: Add support for Dovetail >=
 6.19
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <20260220-wip-flo-prepare-for-6-19-v2-0-222effb01976@siemens.com>
 <20260220-wip-flo-prepare-for-6-19-v2-3-222effb01976@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260220-wip-flo-prepare-for-6-19-v2-3-222effb01976@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: d614d927-7f28-4387-4ba6-08de70951964
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzBUN3ZuRHlOdUd6SEljelNKZkM3TnhjRjdtNk5DbHRmSDZxTlRpOGIzL3Nw?=
 =?utf-8?B?aGFremkrUUJDWVM5U2VEVStpc013RjZEckhCMC9zcCtmZE1DdytuWjh4cW92?=
 =?utf-8?B?SEVPbHVVYVoreVJ6R1J1NEhKME5CZFBoZTFKUWpXVk5rZ2lyVDUxUmFEdTZP?=
 =?utf-8?B?bXVuSFpGenZDaXdidHZPZ0tTSzM2cXlyL0VUNXhFRVYyMmFiaDg4blpDYjN6?=
 =?utf-8?B?eFU0dEZqTjNJQ3A4Ri84YjNZZG9VTldxZ2FJOExRSGZGb245N0tDcFQxWDVJ?=
 =?utf-8?B?YTdCTTRPcnJYb2JzK2lwU3Q3MHp0NXgwMGZqaGpoa0xnTThyVFdPSXFpV2pt?=
 =?utf-8?B?VzVQZVdXZGRmam5YK3J3bTd5UU5aMllFblNOeEY1R1kvUTVvdFpUREsyaGZF?=
 =?utf-8?B?bi9RS2hlcCtFR2h0Vllmd0YvWUNqdE9QZ2h1RXgrT3NkVU9ERjFSZjJrR2lW?=
 =?utf-8?B?M091STVYRXRyYWVKSjBvbGwzUW4zRDd1MjFQdDNhQ3Z0RzlWOThVMGpwdmRk?=
 =?utf-8?B?ODN0dUpSVnIzRzJFdW84SjZXNlArTkxIR2F5cXlFc0ZIaFZTNjJUZURtTUxp?=
 =?utf-8?B?QjBuMmRXYm15dEhScnlNSUhwRnQ3aGl0WmNoTVhnUVpUK0pVTnpvelNsUmpE?=
 =?utf-8?B?QVhLT2RWQWhoTTNJd3l1aWQ2K0VlTkJNeEFRQnltSUczV3lnamFtWHh6RjdT?=
 =?utf-8?B?Y0JYVkJ1N3NsaS9NUW95WW5pWVAvcjdESy8xOW5LQzc0VC9TYy8yYlEvT29F?=
 =?utf-8?B?L3RWRW5HMU15R1dTT3RWMWpjRm1sbExaTEJZcWlPUlQ2Zm00QmpTdlVKcTla?=
 =?utf-8?B?aGIwM2FZWS9JdE9qcXlubFQ3dmlvTUMrcDBubHg4V3ZnKzBxcWhLdGZHRFJ0?=
 =?utf-8?B?K2pBS1Q1Z0RzdWFacW9GVVVXekVKRUxoSzVCVkZ6M2tubzdOUEg5bmtWQTdI?=
 =?utf-8?B?Z2ZqOWpBSFRiTW5QQmdBNEF0RVF2cGlpVkMyc1dpbWtiZ0hqNjVDKzR3Tzkz?=
 =?utf-8?B?Z2lYNTRPc3pYRWFMRUxBdkhJWE5FNTFLTHloT280REdITzhYeS9KUXh2VDBE?=
 =?utf-8?B?VlphWEFGeDg1STREVmkvVWhqcitVOWpFL05RaGVWZ00vRDljcEJxaWNnSENK?=
 =?utf-8?B?WWJMYjEycldybmh0S2VncHd1akdXTHA3YU1BRTRJNjBlZGxFV1h4U002Mm00?=
 =?utf-8?B?ZE9TTmZNdnRLWktzZWdFYnRiQUZUKzk3WUZqUDNIRm1iRHRpa1FWV1dVZUYz?=
 =?utf-8?B?MFNSenJjQ0hLRnNocVQvd3Y3Z1NEZUN0Y09ZSUdNcmQ0NTN1eW03S3BaNWZh?=
 =?utf-8?B?ZGhxdVFtcWF4VVFJL3IrRytJWU1pQy9vQWlzN0J1MlBmOG44TDZkZFVkODNF?=
 =?utf-8?B?U1g2UVBvNVRma2tObzZwZ1RGdlpWc01INWZ5YTFtQUV5UzhrL0c2RklLTmln?=
 =?utf-8?B?TzQ3VDZwWHdaSWgxMzhoQ0RTYm1xRHprVHAwaURJNkFML3NpQ2t0QXlWVlRR?=
 =?utf-8?B?a1FlZy9YbDRIbXgwcTJxaURpUFVEYWREN0F4blNkQk9keHBiWVJqSzlmUlRN?=
 =?utf-8?B?YlQwVWdHcHJ0NGhDN0NuYS9wVURlQnpncDl5bFZiWmVlWlZzMEVsTzJsY2xa?=
 =?utf-8?B?T1VwZzVxd3EzQXl5OHhIN1V4WVQweTZ1Q2xVaUNwZk5iNEpHa0labit0SjJa?=
 =?utf-8?B?K0EyMHFmMGlVSnl0MG1VTzBrRDBYTVcwNTZTblBteHFKaG9LSlRJZ1cybXJn?=
 =?utf-8?B?YlFETnN5NHhSdk5XVFFDOTJYMGptODJiaUxkdFBXcnZZOFcxOC9wR3FKeWNY?=
 =?utf-8?B?azh1TU91RytlZThqY2pVdUVhNWpDZnRDT1BONmpSUjN1cmQ3ZEFOMzFJMzBB?=
 =?utf-8?B?cXNsSytiQmhlWWhhK0t0a0xWam5mMGZONEY2QWRxb1loUVlxOFgwVzdzWEY2?=
 =?utf-8?B?YUhDbTNobVE0cmhlUENsbHMrOGVhZzRsSFoyRldSd0Z5MThLb1lROWsycFZN?=
 =?utf-8?B?T0RYUmVLd0lwUlJEdlBCU2l2ZUJGZmlXMzZvR1c1UnFqRnlQL1RKcmlRUFU3?=
 =?utf-8?B?RkJPcHZhcE5wZlhSODFXSWZwWjYxM0JEUlpkODdxby9kRENzdXA0U1BXZENw?=
 =?utf-8?Q?B2Tg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm1KWm1nVnBkeEw2V2F2RWpsUWkyaCttQW1LMUJMVkNUcG1MRFRub3JJSDRv?=
 =?utf-8?B?MllXL3BlOHhqK2tJNUlneDZHdXNtb2VlVEgyR0pZQzVSckpEME84YW12c28z?=
 =?utf-8?B?Rm4rRXFaYTVLd2ZNV1gzS3B5WWJ4RVBkQ2NLUEdheWRHUFptbHpXRUhiK09z?=
 =?utf-8?B?UVl2MXRjb3JiSFJYR0JSc3l0bkxkb0FtTk1KMmZMSlE0NHo0OFZBbmZ5YnI3?=
 =?utf-8?B?RGdRTkJ2STR0bEVDQ0dZeEM2eU9EUGRXcjFJakdqaUxObG9MMmU3b3Z5d1J3?=
 =?utf-8?B?VEY5WXBQK1hPRWhoWmEzLzNhYk5DSVN2Y1pxZ3BBc1JnUTZxYXJWbnhZM3R4?=
 =?utf-8?B?QktCNllCdGtQam5iYnp5aFA5RG9aZkpvL09tSGNEaERsK3E4dDJVbWxaKzkr?=
 =?utf-8?B?MENMUU1ZQXQ1TFQvZnJCU1htOVQxeC9FeGZqc3h1dldUdWhqNTlzMHB5NC95?=
 =?utf-8?B?R04xSlhNSTJrNUF6dkhpKzQ2eUFOaGtRYnRVbFdKNWZ1SVc1VGNMdU5jcUhX?=
 =?utf-8?B?byt4VEpYVW96K29IeXRsaTZSbnVKY0VYbU42Tm1jMXBDTFhTeCtKdHpmeHhx?=
 =?utf-8?B?WTVyTjV2ZDNHeCs3dXQ5Mk9JRS9UbGhTbDRKSDgvdm1rMkxhd25BUHh4aUwy?=
 =?utf-8?B?MDE1WnJBaGJpODErZnU3ZkZMdG1GbXNJdnZ5emJyV3lHVk81UEgzNVpiWUY5?=
 =?utf-8?B?THBqRW5LWVphZ1N2TGUwZVNjbS9KVHpqRm1XKzdEaUZvalVSY1ZNN1Y4WU5K?=
 =?utf-8?B?amFhYWdxWXBoM2JOQ0pXWURZUVF5cThKc3Z2Z0tzWHlhaER4MURJcUlOZW5F?=
 =?utf-8?B?b1BuUzB4cW13dnZJQjZrTU9xcmlLQmVsaTIyMTBkb0VlbXZBUmo0bzBueUpt?=
 =?utf-8?B?ZURPaUd2aTcxWHV1NURpTFFuZDFhdlIxSHZlM1k4WGtJRUhLVm9CeFdPMnE0?=
 =?utf-8?B?Z3FsbFVWVk1idnExNEJ5RXBmR3RtVUxtMUNPNGJSZHViN3ZKclJSaU9FTEtx?=
 =?utf-8?B?dmI2VklERlJBcXVQbEM1ZEpsSjJrbEg2N3FoQlV4Z3lmeU9FamhMblBhZWwy?=
 =?utf-8?B?OEFQUi9nMjVDMnhURzhmeHFNU2xpRUp4OFA1M3RaZVNIamRCK0pkbVRZQldZ?=
 =?utf-8?B?Syt0VlJBcjAzVU84eXcwbVRpeVlVdjdoNmtiaU5jMkdtOG9QeGZ4OWJ5eVpQ?=
 =?utf-8?B?ajFoTHpsU0RJQWpuNEFMSzAwN1lrMHFYSE5sN0QwRlFQRFhLNkhqbWRzT1o2?=
 =?utf-8?B?NmdzamZyU0JNenVhSFQwaVYvYWYrVlpVZXFxcUNYd1Awdll1eEdOSXlqSmcx?=
 =?utf-8?B?MUR5eVZ4UVhnejZUWjJDOGF3SWdqY3h4Z2toOTRDKzRHdzlkTi9kbUhRL1l1?=
 =?utf-8?B?amM1dDl3RnJneFVmQ1Q3VlhWcnVkczdQN2U5bGt0Mzk5OFZac2xHcm5GSVNM?=
 =?utf-8?B?dmRCOE1nbzg4MmFlbXV5TGdWaUJ3eHErUDVwbFk2Y2hzc1YvUEdrK1ZmS3NW?=
 =?utf-8?B?RHAxTWFFVlA1cUxobllZU0orUHdVZ0RHT3ZuSkwxaUxhc09saUdyNlJycjhl?=
 =?utf-8?B?ZThmK2VzOGVaRDQ0MUFGeGpMWDdPQXl5dnBVVitWcjRwcXZnbVNrRzNyY1lG?=
 =?utf-8?B?emdJVjlTbGVxSEFDSnJOdE1qNnhuOEV1UUNoSEFsZEh0MDZhbFJOeU5LRnV3?=
 =?utf-8?B?c1huYk53c0ZIM0JsMWZHb1oza0pkNjl0TGMwY21hbnVOT21LSjRTSVRwdWJr?=
 =?utf-8?B?SFlWVmlPWmNjS3owVS9NUSs1MnB1WFI5OUsyaUNoa3N6cXNHdEJTdXBBb1g5?=
 =?utf-8?B?MC9qelBKaDhUa3g1ZHJ5THBKVGtHNVBGOE1MYjdiQXZMbUZ5eVQyMG1yc3ph?=
 =?utf-8?B?dlZ6TWZFYlg3bDFNT0JTUVNhMGxhQWtsYmY2dmRFb3lLRk1Wb3AwamFMTDhQ?=
 =?utf-8?B?VVB3QXdEcWFWZUR1QW5Dc1ZYY1dEaXB3ZDlrSG1vZ0dtZy9nMzhBWmRVaXlQ?=
 =?utf-8?B?UW9SSTYzeDJIQWN3VmY0MDJnYWlYQnBQMEcxOXlER3dHdS83L29EdEVlUG04?=
 =?utf-8?B?WUVrN29DYkxYeUZLUE9ZUGVrNXp0eHBBekt4QTREeVhCdWJWVjV1QXRLNlZy?=
 =?utf-8?B?NzJ2N2Vkd3l6bWVDcDJTSXRRRk5vUTB6a1F0eXJMd3lRbVd6QWQyYjN1RTZE?=
 =?utf-8?B?MjBuSjZtb3hPbDd2bUhiSGZwWGVDd3ZrQyt6c09OSCtuRXBjMzlOcThwMTlp?=
 =?utf-8?B?SmlTMXQzbWN4S0liQ0h5ZlhtK0gza2tsZzg1YnVDenZ3RkhsRzVaOXZlK2Jr?=
 =?utf-8?B?Rm5weUNmU2dsSGlBY1dPQlhsMGx3TklFV29qN2FyQXlraGZQVjdSUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d614d927-7f28-4387-4ba6-08de70951964
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 15:31:21.3176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQcoZaHe7IGULtir84pB3KdBxqO+PGPzUwMxQqs3x6BP+5uXaaxd7lGbpgfQ+E71YSu7GDS301Wtkmsg+AgP9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8059

On 20.02.26 12:27, Florian Bezdeka wrote:
> The background for this reworking is a recent change to Linux in 6.19:
> 
> commit 4fa617cc6851 ("arm64/fpsimd: Allocate kernel mode FP/SIMD
> 		     buffers on the stack")
> 
> expects all (non-preemtable) users to provide a buffer that is used
> in case the calling task is scheduled out. NULL is only allowed when
> preemption is disabled.
> 
> preempt_disable() has no impact on OOB tasks, so when an OOB task is
> scheduled out the fpsimd code tries to save the FPU regs to NULL, which
> (obviously) triggered a fault.
> 
> To be able to provide a struct user_fpsimd_state located on the stack
> the complete FPU usage has to move into one function, now called
> arch_cobalt_in_kernel_fpu_usage() and implemented by all architectures.
> arm64 needs two implementations to stay compatible with older kernels.

Can't we keep the test logic and the FPU setup/teardown split? What if
we provide a wrapper for allocating a state on the stack of the calling
function that - where needed - is then used by setup/teardown? It looks
a bit strange to that "rt_sync" event inside the FPU abstraction.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
