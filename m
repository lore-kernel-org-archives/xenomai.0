Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0129ACC5
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771598844; cv=fail; b=GhdemKo2nsqla1njxkYVoGwyD2+6Uegp2erFb/avXquwnve+alqyyGBlJ+k7oWRp/scRXt5CKQqsZzKy3hHZKDH2IXweMUkSPvKYv8odoLD73exMcqUmcaUQZaWw9xiDEFT7UPPrnrNBfqUQhUJcz9rcSdVvdZgUGMgWHwi2zFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771598844; c=relaxed/simple;
	bh=E/4cQHxgVrG4MIcQd2l4EVMX8RbgQkbdgq6/kSwTjpw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UfG2SosP4uYnj+0IX8kkcvKc0lImaNDgrdZn9r4rONHaAoQ4Oi5XI6FKuZwAg7MZRLxc3my5yaCbn6fteZOO3b5d9hfUXrdBayQwvldmLysiAuxJzHcVWdD1gdHU0Tae8zGyDI23utvc601tiIjgmyWzYEEJTozRnTkfF4xyEnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=EP/hYCkc; arc=fail smtp.client-ip=40.107.159.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="EP/hYCkc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gpv+9VHWyed3A/c1XWcBayw6rah3dNlKuZOtK7lploY1TZmjTBnxI5Xx6Il9JVE8NNF5P4HeDyTlNTnXqFZMsGQrUhBeCYkKSAgvGK81pubXfNPQz8OnVokD0FrQLD96Kz9/ikwyo2YfHjODZlG245yR3Oh4xWpys7YkphMZ2H45zYwj+9X7VTCBC6XiICV70EHoVClN0ih5FT97hrkyUNFczPwAbpshbhAlsbqjeO6HcZbFeYleFmYPXk2sEGJgHQm6AqC2Wfxl6bD+pF+YjncUNLO7R1R2nrIGxj9hvnugLijdBOt1ZO3Wm+ngJPHXuDTJJEnGTJOpT+GIDvZAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5BIYntDuf455WVkCg5BciecnBpkJF2fMaLuj95LtEE=;
 b=Jz+2iaR4nhs9so0Tu6WidWFq6PwSQIBUb0FXrvLx6saQfo0uPgms1EsuuWEgtOBg3AqGybUBhRA6xyRDNugoEI8el2e2LiTXZqEUUI6jtTD96OVcgXbHLyRV/vww1QU1pwq3+lwTO9CEM6qif5DQPg787bbySJNueUtt6E6i5kPPWfzrDJRlIhB52Vqk9ebGQdSNOl/Ge2c3QKNlPV/nfFCsuxz3iV/sRwPm6c3QHB1ehz2PjS/i8Z2bmLFrlihLLnAC2oJBA5goi08pcEqld9J7oJwxCKnFLgjIcUr1amiKYgRLhERp4bM1rmGtSCQR08ZRjnkLMhKMxzqbzVWoWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5BIYntDuf455WVkCg5BciecnBpkJF2fMaLuj95LtEE=;
 b=EP/hYCkcTailnekllS5CDu5fctyctov2NQYJIXJdGxc5E1BdGjc2D2WjGFvOyESFPJYJXTQM4VIIwuiMPvZaqJ0KtJPHybK+grzhXgCSDLPzL02g0bIsjgy3/78xxhECky2jh2Rk3AAkcplzayV9QsgbZcehRyxmq1+7i1wO9WwEqOZRmVqlHyIFmN0ZUB00sbU5+wkLHYN41IJfQlGsjGoxHBstWOrbF2YVZHzqJ17Sd4LC++lrhNwJUsQ71aE33T5GmKFokaYJcvBLBPr73c2N350f71VdDxXN23RkUW3WRP7sM2Zewi4ykKFKWLIvnKXjkFSzNF7MdrOs/6vhKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8646.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:234::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 14:47:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 14:47:19 +0000
Message-ID: <651c9c4e-78ac-42a1-8530-2c6b2502ebd2@siemens.com>
Date: Fri, 20 Feb 2026 15:47:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/20] lib/cobalt: Introduce wrappers_time64.c
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
 <20260220-wip-flo-fix-time64-32bit-native-v1-5-731c773e72cc@siemens.com>
 <91cc0a1f-e1f7-4ce0-9607-606839d0c01c@siemens.com>
 <579b891e2b25c8e86a2f878aeb4725b61c14d13b.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <579b891e2b25c8e86a2f878aeb4725b61c14d13b.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0252.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8646:EE_
X-MS-Office365-Filtering-Correlation-Id: db8e0c22-d833-457b-9a7e-08de708ef2c6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkV3YVh4SEZtSGJmWk9BUXdtOHFXZlVzbS9xeGxnUGVNVTc0ZG1uNVI0Vm8z?=
 =?utf-8?B?dCtla3dqOXAxZCt5QUtoV3ZXNk44Tk9XbE54TnRxOVNYbjZKSEV5Q1dBbDJQ?=
 =?utf-8?B?dGV0clAwTmJFTVJBNC9sNUdzeEVYVk50MlJDY3JXaVVPcTZjaFJIekMvc0NM?=
 =?utf-8?B?YmpzREVGNGxzMzJELzFGclorREtvSlBXeUFmb2NwK0x1K1Q3YjJCb2ErOGs1?=
 =?utf-8?B?QUF2aEkxNE1GeWVVdDc1VmYrcElRdUFHZTRlakNReUtLMFZZSWtodUttWmpJ?=
 =?utf-8?B?bFVGZTN4NEhYNUJ0SnF3VEt4emFjblcvTXhodEhrVGxvTnk0S2xQMzgrRWYr?=
 =?utf-8?B?RmtGbk1SZ0ltcHg0NElpVWlQL0xLdEIvd0dTamN0Sk5lZUNCWWVpcU53enVM?=
 =?utf-8?B?VlQ4aGMyZUJ4aXl0SWNHOEdjczJNVlowbGxCTmVBbkdjVnpnTWV3bTlUOURr?=
 =?utf-8?B?RStIc3lENkhoQjVPTTI0SEV3cTJWU0plejA3Y0F2TkpSb2c0TDk5OHVoc1Zp?=
 =?utf-8?B?aU55WExXT0RWZW5rTy93UlVFcEtMT1pPQ0VwOVRWaDg4RDdOZVFDdW95dDZp?=
 =?utf-8?B?UEd1VWJKOGpTclNIZzdnbi9yYUlubDZVK0ZTaENHVFpweGlWak1MYVpyWm44?=
 =?utf-8?B?UDR5V3REbUNBREF4TXJJQ0o0Sm1OOXdqQ2t5TTJQeE0xM0ZVd3NxUElyZGNq?=
 =?utf-8?B?RmdZUVJiRzhtRnp2YjZDanE4WDVoMzZtMnVWR3U3MVk1SmxuZlB5OXNiVHNO?=
 =?utf-8?B?a2NsMW5VRDhiSUNmUytaSEsxbUVPMi9RczhoeVhHOExMWUtvRXJKb0dMeWx6?=
 =?utf-8?B?WElCZlNLTGVjY2lBS2R0ZUxsUTZ5emphRnVXR2l3OFcrdXgyeW53cGhmVnJv?=
 =?utf-8?B?cjlsaG9XQWdXTGJFNVl1dlNzSWZMM0hUcWYyaFlzOHQ2eFdDV2k2a3dXN2lV?=
 =?utf-8?B?eVg1VWNvMGhxVEtFNFptU2dJWHdrazJrQVRTSXl2aFBDU1ViWG1wZkFWeitL?=
 =?utf-8?B?QWp1dUJmc0ZqOVdpQTZlYytKZEhWbnBpSk9Xb280aDBUVGN5V1ltbjlCL1J6?=
 =?utf-8?B?Zi9qSW5QRTJGQit3Z2kySFJOV0N3U0ZuWnlndktvOVU2N25xVWg4ZHNlZGFK?=
 =?utf-8?B?ako3L1M1VFlhSVVVQTcrclExQm1oUW9aeWo4NVBqZmxEN0lMUWdHT1MvZzln?=
 =?utf-8?B?MzM3YmZLK2k4R29uNFF3aHhxS2pBSWVXOGlWNVZyWWl5TTNoRU5HYXZLcmh3?=
 =?utf-8?B?ZlU3dVZma0F5R2ZXUG16V1dnN01yRExGSk5ieXJ3blJQZjZ0a1dudXBkT1p4?=
 =?utf-8?B?OEJyVWRKMytIRFYzMDdoMUt1T1EyUGcrbGJLeDRqckdxRld0VXZONHZLR3lu?=
 =?utf-8?B?S2FWaVA0QW5KRSs1VUFEU0U2aWJPelVIK2dVNnQxWWVzVXJWaloxK3JBbTRs?=
 =?utf-8?B?ZHI0Yk1nYkZxN0hNalc3dlkwVzJqdVpLNkVmempra0dmS242MVZFU0Y0cnNV?=
 =?utf-8?B?ZW11MDRiNlAydVljcVdMQ0RxMGNJdzAxcnlIRnVwaG9Pdlk1dWtEN3BRbXg0?=
 =?utf-8?B?U2xJUWFHMHV3eVVPYXRFSEpFeVdVbGV3anEwTVRTN2lOTW9rMWV5RXVyQnhn?=
 =?utf-8?B?a1lUbWI4M3BpN2ZrM0NGajVxcFJBVUlFVzBINjJSY1JRL2V0Um01dWRUNDM0?=
 =?utf-8?B?aGpBZjlleCtBbnZKVi9QNGdsWjlLbmJXT2MzOFdLUUN6WmUwT0Y0cGhyOTVP?=
 =?utf-8?B?MmtnYnZ6RWpNMkpybXR1c0IvZE9GSmFSV2tVaExwQnRiT2RNWHdPMkFoWnl2?=
 =?utf-8?B?blJ6c0RRdUFYTWJScDZtZ3YwVURqYzIvQWU5K3RZN1o2S1JEQ3NLOGx4cVVS?=
 =?utf-8?B?enRvVlZmdE9HV2ZpL3N3MytMWjhESGpEQ28xSS8rUUQ5KzI3bTltQXVuUnNI?=
 =?utf-8?B?a09qTkJHK2NRbk5UNEFkeXFQWU9LMXBtdXhhb0Q2ZG50ZmNnMzV2eVFGUVlD?=
 =?utf-8?B?QVlEOUVFdHhWZktIc0NEMnpTVFJKZjRacmMrYUFsZW9ORTVxR1NtUWFUSWFW?=
 =?utf-8?B?N1RmVDZpSXllZ2NQdGhuLzk5LzFWdmRsYm9Eb2VUQlFzdDhNTVNpeDZpdjE3?=
 =?utf-8?Q?cuBQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjlHTGFRby9STmc3TnRFNVVGRDBPZDBJWVdudHl5VFJMS0l5cnpvMmR4ZWhW?=
 =?utf-8?B?NGgwOHZKcUswVE1UUVU3QVdhZWcreC9TUjNFNU43TEpwdGxiL3V1d213ZGJI?=
 =?utf-8?B?Q1BnUTRuODNqT2xaN0hnREdwYVpRSkNDN3BzU0R4MnpQVUtweXFkV0s2TjhD?=
 =?utf-8?B?dnltTUlwVTFFUDQvQ2FVUFV4ZnlQbVZaR2psK0FVY2xRWk50QTBDM21ieFF5?=
 =?utf-8?B?YWtlbWdrZVNxTjF0cGhEN0RDQWdNV2ZSQ2FkUDlYZUQrZzRGWVFocENySkZ4?=
 =?utf-8?B?VXNIUzdyelBhMXpHTnUvdWNyWnJ1U3RhWTgzUFkvQXg1K3hGY2pNMnBReXBL?=
 =?utf-8?B?ekxueEtXMExhdnVVcnFkZ0FScmpHUWU2VmRRMUxLZ3hIMWFGSVl6czhYa1li?=
 =?utf-8?B?NlRXQW94WUtOSnVSN0Q1SHJ1WEVJM3lyUEpRdFhLTHpJZEkyNW0yTmFXaUdz?=
 =?utf-8?B?TnZkR1hob3FBN3BvWXdCRVRDd2ZBUVdyQ2JFbUpJYjhNbTZpTGZuSkVnbGxn?=
 =?utf-8?B?ZXBRNmZEczAxLy90U1M1NGJGNTVpU3NaKzlXbk00ODFCbG5icnI5eUtiWUw0?=
 =?utf-8?B?OGdUT2xHTXpxVURmeERsYy92TEQzVjdDbEViL0k4cmhMbVJpNEJsMTFxZ1ph?=
 =?utf-8?B?ZGtSN2FmTVV3WHU3YStIR0RnZHE1dXNMSG9CMm80dFU5Rkgra0E2cXFkd0pX?=
 =?utf-8?B?bHlnRGFlN0pVaVoxb0xKNkFnVlNWZFFFU21mdFB1ZXQwN3VuUTk1UnNONXY0?=
 =?utf-8?B?cmZoTi9Vd01hY0xTanNrSzRoMVFZSFh2bkVTeUdvVTNtV2VyMjlBZXBMQjVy?=
 =?utf-8?B?TVJkK0JhK1FEVkhPMzdqSDFMMXk5eHk2RHdaVGtVZTRld2lyWnk4a3JFWmNV?=
 =?utf-8?B?UmFnZDZKWUs0NFBpM2h2RWliU1NyYVpUUzMzVi94aDFPMHBjZG9EN0ZpTDdo?=
 =?utf-8?B?bXFXa1lGaEgwOUJVbXpNOGttTXZ6QnFVaVQ5R29PbVdTeVNyV3ZqWWNnUlNs?=
 =?utf-8?B?R1lyMSs5NTA2MDB6dmg0dVJJbkxBUHpzMkV5Yzk5akhmV01RdGFxejBpanFa?=
 =?utf-8?B?YTdwRHRFSVpMZFVQcVRRTS9hQ3BhZXY0enAxV2tyU1pjbHcyZFMzU2NmQXhm?=
 =?utf-8?B?dTB0cFlqNG9SUjZzejJ0am14a2xpZmQxOEhJSmhDdkNtR21JdjlTbVl6WlBp?=
 =?utf-8?B?MWhaanQ5ZmJXTkMzeXNvUUgwb3lWbEhyaGV3bUJOM2Q4Z2IxMnJOVzB5YnNK?=
 =?utf-8?B?d1gydzA5ZW1qL3NnWmgvTmJ5blphNDhXS3dESFhFa3hyQ2J4QXdKSFJRTW1Z?=
 =?utf-8?B?U1ZvcFlLejUvY01NVlJkbFFzN2x4dXlvZHZiM21NZ1VYMVc3dTJMLyt6ZTZs?=
 =?utf-8?B?TzVYNHg3eWpqNVhIU1pobm9CRzFQbTJDWk16RFF6V0lWQmMzRHRMZlVuai81?=
 =?utf-8?B?cndQVW45Rk1JeThHUXdTc2o4Vk83bmsyb3VzZDQzS2hsZ1lLQXJQRGE2d0pZ?=
 =?utf-8?B?ejdMVVZ1Zm05Ykw2aEdGeGh6NnNnbzhoajd1QTNuSHpYR3I3dVR2dmhQKzlM?=
 =?utf-8?B?TDRxQWNWSU8vZ0M1VzM4MUtaY0RKYTM4TGxxN1Q3RTcxWTJod3hqdXdldUts?=
 =?utf-8?B?Uy9nWGRBN2JRTGVmZEd0MEdpU3MzMmcySUE3ViszVHVpTVUwb25OMmtnSkZB?=
 =?utf-8?B?Z1VKR3JCRWo0Nlh3RUpmVDNEZHhmQUtXNHZFbFZHNEJEdHUxeUk5NVdKeXlx?=
 =?utf-8?B?RGxveXZMc0MydzRZVE0xUGNGR3c0RWhSSHhSSWJGakxsYlRlNE9FV0ZVd2JB?=
 =?utf-8?B?SDA2K1ozcUFtOVZBTkd2UXMxL3gvbVFabFFJR0trczMyMHJEdG5PNDdkNVpH?=
 =?utf-8?B?dEpXTGRlMUt1S3lFOC80elZHNFhoa09aZm5CR1VyYjl4Wk9ISXBYQ09UbnlT?=
 =?utf-8?B?bEo3UE01QnFieGdnRmFPdC9tdWRqa0NCQlFsKzRQZVpSKzhJdDUvV0VOWG1Q?=
 =?utf-8?B?c2tqb1JUdE1pS2FjdFN4bFZEWUgxYTNoVmsyaFBKMERTajJJR3pWd1F6NFM0?=
 =?utf-8?B?R0JPMzExVW9oQ29iMDFxLy8yYmhHMkYxQ2FWOUlMNitMcGV3bFVDeFBBa2hU?=
 =?utf-8?B?eThFNGdOYy9OazV6YlJ0WGhGalkrQnBURHpHbFd4UmpGTy9tdUxWUlRMWVJE?=
 =?utf-8?B?TWhZTjNBVzc4bUM1aW5aYmh1N25KR25yTHBGU2xXUHlFMmRmSUxhZUtMcXl5?=
 =?utf-8?B?dWZya2hNRkFseVg5cVdGbFNzY3BzdC85alhsMkNXcWNJRXZkR3M4QVEveXg5?=
 =?utf-8?B?RVlPOVRvSzhvV3h3SkV6MUNvUDVvZWhvK3RhV1hjM09qTVJ3Sk43QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8e0c22-d833-457b-9a7e-08de708ef2c6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 14:47:19.5144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: At4CPYPqfloJ7r8pmJ/gO0hbi324MaGHo6JXG3Qr5NqXEqi2cTO9HhZUHj/arRWAq1IgX2p7LVgulVOqpxPcEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8646

On 20.02.26 15:46, Florian Bezdeka wrote:
> On Fri, 2026-02-20 at 15:36 +0100, Jan Kiszka wrote:
>> On 20.02.26 10:08, Florian Bezdeka wrote:
>>> All COBALT_IMPL_TIME64() services will be moved afterwards - step by
>>> step - into the newly introduced wrappers_time64.c. At the end that
>>> should allow us to compile libcobalt with time64_t support leaving
>>> the native time_t services in place.
>>>
>>> Currently, all native time_t services are replaced by the 64 bit
>>> variants. That is OK as long as applications are rebuild after
>>> libcobalt, but we try to remove this limitation now.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  lib/cobalt/Makefile.am       | 3 ++-
>>>  lib/cobalt/wrappers_time64.c | 6 ++++++
>>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/lib/cobalt/Makefile.am b/lib/cobalt/Makefile.am
>>> index f461e570ed42a0d5cbc43eabb373c3c9edd83bad..17e203f9015fe2bb5306609e4d51c62f3a725780 100644
>>> --- a/lib/cobalt/Makefile.am
>>> +++ b/lib/cobalt/Makefile.am
>>> @@ -43,7 +43,8 @@ libcobalt_la_SOURCES =		\
>>>  	timerfd.c		\
>>>  	trace.c			\
>>>  	umm.c			\
>>> -	wrappers.c
>>> +	wrappers.c		\
>>> +	wrappers_time64.c
>>
>>
>> So, a should we do a wrapper_off64 for mmap, or put both into the same
>> one? I don't have a good name for common one yet, though.
> 
> Both should be possible, I think, but testing has to prove that.
> 
>>
>>>  
>>>  libcobalt_la_CPPFLAGS =			\
>>>  	@XENO_COBALT_CFLAGS@		\
>>> diff --git a/lib/cobalt/wrappers_time64.c b/lib/cobalt/wrappers_time64.c
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..4c4e0db0650b49f46cbd6d9ecf7cd656bb04bbe4
>>> --- /dev/null
>>> +++ b/lib/cobalt/wrappers_time64.c
>>> @@ -0,0 +1,6 @@
>>> +/*
>>> + * Magic ahead:
>>> + * This file is compiled twice in case y2038/time64_t support is necessary
>>> + * and requested. The first time with time64_t and a second time with native
>>> + * time_t.
>>> + */
>>>
>>
>> Header, but still no copyright notices...
>>
> 
> Yes, I forgot the license headers / copyright notices because I was not
> sure if I should add SDPX headers or the full blown license text...
> 
> Any preferences?

When moving existing code, better keep things as they were. SPDX can be
added, but it should not replace old statements.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
