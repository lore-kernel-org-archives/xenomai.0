Received: from azn-pfx1.westeurope.cloudapp.azure.com (azn-pfx1.westeurope.cloudapp.azure.com [51.124.89.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6233612F3
	for <xenomai@lists.linux.dev>; Tue, 24 Mar 2026 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=51.124.89.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774353317; cv=fail; b=c+ewsQH5KumsPw8W1ZofNKE/J/E5Esilyef4dxCZyxpfFWKIRQHW6ycwkC4DuLH1APwbLEd2oIKqNLSER/qf68PpG0WhJNbMaLKmlzU82qmcdiY7F2Xx2gn0y9roGCtTEv5KkfR4KpJDMQnfUjR463UtIpRAr5tTxoMiyhXcGZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774353317; c=relaxed/simple;
	bh=yO6CwfblrweeWyEXCqbmc9/Gn27LMTx47E6IqAzKggE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version:Cc; b=kxudlOsqHTVKQGLr1Jlg0KgeR4zovKn+gdOmZra+VjRFDnrOkXwT8qjAPV6FsHswYy56YMj83TvbnhzRhlWv74AGm2AB1E7RUWcHS7YSR6ss6SMpV+bKhTTf7aUpKmB4W+X0h3EUI1vcWu+k5Y9LOpLkNmVf2/Te+fk/uHkuDGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adige.it; spf=pass smtp.mailfrom=adige.it; dkim=pass (1024-bit key) header.d=adige.it header.i=@adige.it header.b=scayTIVF; dkim=fail (2048-bit key) header.d=blmgroup.it header.i=@blmgroup.it header.b=lfiLJxDS reason="signature verification failed"; arc=fail smtp.client-ip=51.124.89.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adige.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adige.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adige.it header.i=@adige.it header.b="scayTIVF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=blmgroup.it header.i=@blmgroup.it header.b="lfiLJxDS"
Received: by azn-pfx1.westeurope.cloudapp.azure.com (Postfix, from userid 1001)
	id 4368F800C41; Tue, 24 Mar 2026 12:45:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 azn-pfx1.westeurope.cloudapp.azure.com 4368F800C41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adige.it;
	s=selector3; t=1774352756;
	bh=yO6CwfblrweeWyEXCqbmc9/Gn27LMTx47E6IqAzKggE=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:From;
	b=scayTIVFKENyv9BNd+nTD5cr2rpuAAn2xOZ21RLCBFWGablggJXFbSvyzIABiuPU3
	 BfUY0Pr6u9N9VRjU2xHaPsXB1z0s/qM0k5NYBKsTj7zgB/Bs15HO12l/9UDycm1i2i
	 1cty4d/UKmneePHVS9LiMoSdC9MWyYXZ/p2UPb+c=
Received: from GV1PR07CU001.outbound.protection.outlook.com (mail-gv1pr07cu00104.outbound.protection.outlook.com [40.93.214.100])
	by azn-pfx1.westeurope.cloudapp.azure.com (Postfix) with ESMTPS id 000EF800C41;
	Tue, 24 Mar 2026 12:45:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 azn-pfx1.westeurope.cloudapp.azure.com 000EF800C41
Authentication-Results: azn-pfx1.westeurope.cloudapp.azure.com;
	dkim=pass (2048-bit key, unprotected) header.d=blmgroup.it header.i=@blmgroup.it header.a=rsa-sha256 header.s=selector2 header.b=lfiLJxDS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCfIuY5h2yDh8TOaCGp0etS88i5Ax0IJu/or9t9DZGaHoofdfTyVjEA2AQBm45aiYpEV0iZg+4Nc/d1NGC1/kn2KocrhqPDkDcoPxZFihiujxD4ksketiiFdCiNEA/Nb34rHome3yC2fu2aJvQnV3biZPBVpTqa8d1xOrxXGBr4ns5zF5lvt/iYo8KgLxqC0kbLriin5bPbQbSRv878SnwdGtRCy2XoMOJ/7McjUdsz9rFF1458+xsJh4au1NQSSRyeFCD61W6T8pmNlYGMiKEQok4dIqiBWxTbTHZ/RJowpXM1soGqZE6TNkUr1lw3d4Z7f3mL9VtZIZRWIXCAheA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yO6CwfblrweeWyEXCqbmc9/Gn27LMTx47E6IqAzKggE=;
 b=SVUmj92fDwqzqGNZ7+P1Ovd6Ankf2cTMZI0OtaGrStKK5WB14DDRin3pQB8VgR8Vd4B/n4oPc2R5PSqMB894m4TE5Jpbq/cQPGKNaOKew3NZOYMPGs/4hwJb03A8HKnst0iWcjmE4d6gme8pO3oPnMXsIwz65Z6zi0NwfNpaSaXaYK/MOCBS7WbDf7lIdabiXapKvt/jKQBdcjusyYUw/e7dcCdre57Ivr1/ZDZspmEVmhMvTpEtVTWNCLtZTl7nBt2CZNDgKX/5PJE64URCZG3MCNB0QJwgehtnq0IQH0BsdjfU1ZxKcxrcJzVbV5bUogoGVEmXcLs8oN10rfbFng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blmgroup.it; dmarc=pass action=none header.from=blmgroup.it;
 dkim=pass header.d=blmgroup.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blmgroup.it;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yO6CwfblrweeWyEXCqbmc9/Gn27LMTx47E6IqAzKggE=;
 b=lfiLJxDSHhj7y4J/cCHVVDXvc5w9mLfORWrqN2Ile1V7gfnb5plQkBkNz2FOOu3177taJqlnrGTyGHaX2J6Hygu1GPI/b0SnHy9+km0ju7t3waZBA5eMWR9NL/rfYHCd3tiO1iapGgNWWVCOzp7h/7OI5GHATgp6pXn1q4z9oWTKC0mMJyMci6CbFFs3dIhFMtFSfGG4wYeujqL9gjRAlfmyl462qMO/JpPjvjgWD9PFdVXHIWVcOqI6eB/ocuxx9m7dgJW0Roa1RlMnGMghX/6pWO/sMUZ5WrbpwoDYBeqM6v4E6L5aWLBJWc4pkeKCcsJUpf+3E2Z7mH3WhfeqOw==
Received: from AM9P195MB0885.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1ce::14)
 by AS8P195MB1727.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:527::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.16; Tue, 24 Mar
 2026 11:45:54 +0000
Received: from AM9P195MB0885.EURP195.PROD.OUTLOOK.COM
 ([fe80::bcfa:ef0a:9c6a:485f]) by AM9P195MB0885.EURP195.PROD.OUTLOOK.COM
 ([fe80::bcfa:ef0a:9c6a:485f%7]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 11:45:54 +0000
From: davide gandolfi <lasertech@adige.it>
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: R: Xenomai 3.1 application compatibility with newer kernels
Thread-Topic: Xenomai 3.1 application compatibility with newer kernels
Thread-Index: AQHcrL2PJqEHJzeZi0C3qS5ELQ8M+bWgMpcAgAAC/ACAHXcogA==
Date: Tue, 24 Mar 2026 11:45:54 +0000
Message-ID:
 <AM9P195MB08859BF49B0D7A2488C085FDE048A@AM9P195MB0885.EURP195.PROD.OUTLOOK.COM>
References:
 <AM9P195MB08852B8E9DE3958539FA4EABE07DA@AM9P195MB0885.EURP195.PROD.OUTLOOK.COM>
 <AM9P195MB0885C2567A22284ACB34BD1CE07DA@AM9P195MB0885.EURP195.PROD.OUTLOOK.COM>
 <60cbd1b8-160f-4a99-8ce4-eef6434b27fb@siemens.com>
In-Reply-To: <60cbd1b8-160f-4a99-8ce4-eef6434b27fb@siemens.com>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=blmgroup.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9P195MB0885:EE_|AS8P195MB1727:EE_
x-ms-office365-filtering-correlation-id: f5ccad5e-920b-4601-efa9-08de899ae7cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 Td6JPOT7uNjfTw20DScplB2aCVzazeD443tzuF3aosblbNyelZm0oxtnuC2N4mtVFJj2TxbWsvsBAhRoohSfhNrB3n4WPXeCRG0XOhq01PHPphRgDC1MsAp6SH8lrowyWy/iGw7tgZVgUHVlpUt9psvYUJajvq27WNPNaRe7gi2ewR9GbJkLf7HWOgqOvRSJpQPN3NCbRiOofiRM5svbXfLlPfj2nN9QtaIMjFKQOYtylThq6HmbGwbuYAK9pSEX4mQmxWHFNlgepBgLFQc90ZKN0hFGNGvPzJ864LHg3LeuQu167ZXAqw6XqfidV+RI9SJpik+CgHUWjipa7YO+jdqY7DGC+wYPv+yXV8ovnoS2u7yVsN9BNg7hYtdGwLe8YR1Fnc3dHq6Y0TcRavkzPL8unlImqP5uduGaicrKsjM4cuB1k0Aq1QmhJHOE2ko+6NsQ89juNdGbLZci4rluN+Muw3wrwkiUVsSnKZjt11xZ8tiogPlPrYiINjaG73OTUHxhHlHP7qVoBpw6yawGwyeWn/hZIg6z8ziFXV74SqyChAPNhq22adUSOuGDnsn9mlTA2W9If0XCA3UimfXG7RCKAf+SUSUo8LiIg5+K/ijS+mMi+vVRip3FUdZwJwVfG+cVE1dIksBrCHVk5foWOusQBlaOlE1xylXs4MLa6r1JT1sqgLFJcQQ7u7kYVZd0LGcRAa044CqP55JP6EB8ruV2qESlLVrber+zwB0edyPRTRoKck+frAl71cZT9dSk58niKWvTNskcoUYWpc+sTKz2sDaGiDIOyOMrabr+DjE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P195MB0885.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFdGYkJUbzFUUXNVS3lKQ0RBYSthMHlwc0UwdlFubVkrSW5YT3AvdDRXaHB3?=
 =?utf-8?B?MzlOdHh0a0l1M2ZxT3VtQzRpZTR6MzAvTS85Tm9DUlJDbDcrQk5XN1VxcEN4?=
 =?utf-8?B?bll2UG14U04wSjhrcTRqcUc1ZzFyMlBFS0hTem1aYWZpQXBsNXZXSEU1Ly9l?=
 =?utf-8?B?N2hSYm4yeEFnM2pUd3BkVGhMc0FNdS9oN2R5OHF3MzZPclNRcE1kTXpCbTBV?=
 =?utf-8?B?bXg0c3piVzBPWnZWU3l0K3o1TzlpMGtsWUxRWjRqby83ZWduWG9IM1lJc1Jw?=
 =?utf-8?B?V3hmNUVMRlprVmdIalhlNWdCNUFGMEt4amRjSm9KL2lZYkRicUQxdHd5bkFH?=
 =?utf-8?B?c1dYaGdycU1GNHJmcDUxeFkwVDQ5UHFwQzRKS2ZvVXZtc0ErY0JzbFRPenRE?=
 =?utf-8?B?L0QxUml6dFUwL3orZWNCd2drS1BpRXB0bURFclFkL2NBVGVoei9aSHpRUnNE?=
 =?utf-8?B?b3c2bEVTMlhiS2VMK2YxUHF3U2tBeVBQalpOeGhYbHh5SndLREJVU295dDF0?=
 =?utf-8?B?dy90eTNFb2NjSCtocE1hdFVoK0Z4NW9XL3pkY1AwdEovbXZhdTV0NW1WNG50?=
 =?utf-8?B?MDIyZHp3MlFRZlQxWWZ5NnlIUUE5R0JGcW0xaWwzcUEvTmZZb1FBd0NrVHJS?=
 =?utf-8?B?TmtCOGs1RzRoRDRLMUc4KzdvMUxWRWpRVEhxSEduWnppN2dJckhKdUtENEw5?=
 =?utf-8?B?emE1ZDZEWmJTZ1BJNGU0Vmxqc3RpT0JTNWtEbmM2ajNzWmllWXVSc1Nyb3V4?=
 =?utf-8?B?azVGRjBHeVJrTVZNQ2NPS1BTREdRQnBJZkVyTTJsSnBYSlNvYVEwNEdoWTVv?=
 =?utf-8?B?UnhJVm1mY0NwRFYxakRSOXVCWVdKNm1oQ043YTJjZVMzWEZsMnc3RXp5S1ZT?=
 =?utf-8?B?Nk1KL3Y5QUQwdGI1Y0JIZHI4VWxnN1BmS3lCZUJ0WFpVdHB0eVY3T0w4RlN6?=
 =?utf-8?B?WXFFcG00eTgrbktRRGVFSHc5N0IrR1JwWi83NG5nWUZUaXRiOUwzMGFzblVl?=
 =?utf-8?B?d0ZKTTlSUTNLd3dzTEV1d1NxOEdFa3EyS0JNWDl3MU5zdWxJSHBLbDBuOEpL?=
 =?utf-8?B?Zk9sTFp6aEZmMTB5TU5WNmpoMG1iWWdUZGZqZ1B2VHlLZUJwR1lnUm82Tlgy?=
 =?utf-8?B?eUdEaXh4VTZzYzB6SmVKb0ZNWHcwRjlWUzNkRWIxekluNlF0K012MXNXangx?=
 =?utf-8?B?WUNkcVR2VHhDMjlEN24vUFRtSEprV3pSa3NmYVNiRW52ZFZPK1Q0N09WMmMr?=
 =?utf-8?B?bzc0OEJOR08rVzBzVXpMVmxvVDZFRmZLOW5TRFNnWGZ5YzZybXFYL0kyRTJl?=
 =?utf-8?B?UGo3dDBmL1RkZjd1L3JhNkN1QVA0c1lqZnd0WEcvdlNoTWlCY3VVUTVmODhI?=
 =?utf-8?B?QkgvbzJpODMvTHFzTjdrOGNwRDdpZFprQ3h1a1pZOUxVOTZWWW5TTzY5eXBW?=
 =?utf-8?B?WFErUDc1TEJKQVhTMXRHeklMQVhPT1Q4L3I1N3V4SkM0Yzk5Y3AwTVVjUk9j?=
 =?utf-8?B?anduN1JORWlEc3Ftd1hYK2VIY0VQSUpKUDk5dDcrNUdWdC9jRk81MmptRXRO?=
 =?utf-8?B?REh6ejJsNkVBc25leVVRNEJIUnpSeTRVYnoyV0RIeVYvQ1lXNm9yMVdoR3c0?=
 =?utf-8?B?bGhqK05WUjhLY3JlRUJXSXh3TkM5OFVJL1hGaFJRMmVJM3FNeTczYTR5b29E?=
 =?utf-8?B?Z0EzdG9GWlp5ZjhTcytrSnhlOWR5QnQvRHA5bHpnazJEOWhBN0ttR05CTDRE?=
 =?utf-8?B?cnlCdXVJODgzOFNtZ1JlYUNQeDgvdlM2TGJ5YkRYTnJVeEdLcUl4NUN5Ly9T?=
 =?utf-8?B?UkZ4bUpXOHJ1bnl5b1luZWVaNEpiSDJhc2FMNkxoM2N2UzloMXNJbDg4bnpK?=
 =?utf-8?B?THNDZVBPcTE3dE5jTWpwMTlWS2IwSHE2WEt2RnU4RnZFQ3VCZWJCSUFKTHVF?=
 =?utf-8?B?WlRRZ1M4bVNTZmRPd3ZxeG4yVGk2bFlqT1hlaFlzOWl6M2k2YlJkdXBWQndC?=
 =?utf-8?B?bFFUUVpkdnR1b2Zjd2tNMEM3Z2o4REpZMW9lTUJhV1E1MzN4LzVYdTlNZDR1?=
 =?utf-8?B?UmRUUTlLZXhQQ0w2Zk84TWh0MU1HbE42dThYK21jKytzVnVRR2E4RWdGVU1k?=
 =?utf-8?B?OHY3cWNCT3lXdTUwdDYydzVnU29NQWRRV1QyZWpFZVJYZkZOL0gxRDdVZDgz?=
 =?utf-8?B?QW1DcE5YNE5kQ3JoY1F0NW5WYi9qQ1lqVWF3OTRucWNvOS9IbVc2aDN0eEg5?=
 =?utf-8?B?dnhuU3ozd1VMNm9keVVwZzNKenQwSUtDNWVCaU1hQmZNU0M1RU1vUW8rS0Rw?=
 =?utf-8?B?Rk9Ccng5bkNMWElQbm11TUU5allEY2FsMTBuRThPUENFMTdGekwvdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ZfD20pup7WRjKLgtBZc11cyJiX6fi2fnj2YEE7zIJXLYrotUj+Mwv/2xSn6Sm3feT0UaszwhdYn8LkOZKFg6url8NCM2pntmgZYH0t/bBe3+8L2dpOoTuXZ6sZcQSjEOOoWOjzQYcop1LdGBptiEc2OMa9kMUgn0ZhaAMcdCbVp+JTd2502M2uRbvruXDPDeA0GHs2fmBV0JRWXlMcVho3TpHnZT4Bo7CHy5gwfwE9SoTml5no36e9ECbJWTI/2otVT/PVJq4yAWDITsLD4Oh+6kaWVY1hdJLEiFigdki1r4+AHTJHRMQTX5Ug7NZ3pjsTPWius6SKyOehUjLrQcmg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cb/BHqowt1LCCb7wB5Y0+FAuwIWgVz2ZjAH0NHmOzbLIYLvF/CSPZvj08ewU1dadMQ7K6BWegGebmEFRk1q7Z1BNdjy0seLpqvBwtmJmntRKyaUYwPNHbj15rcE9A5+b9vUP5mRIEY0rJyrMqB2w/K9t2kSX6jZV994ZY7yh2guIZUibZJQo4QaoXMBpt+oc7wuDPcrYpvx4xiEa/F6ak+QEBTebEFUXUGypf2ubuklQRffMVO9Ao7c4xt23Z/RPfKeX9Lpj6SzR35bBxCLesehWouwA6BngDVFFc6kR8zYPvyn0Ng0zh5P+VR70weCl/1BkZ27er35xrThganaGUtFF+00yq5NYumCh7xnd/L9f6CJ6xotGKb+qu6v0feg4AZtWDvJmIARviEdhNT4wbSzgu0Ozet3vNsH9Hi2FmxfLkUb02rrqgnjSwoBEhIAoOzU2MVKBgGUNXDjQsf4YxtMQCDtJbzjr6ZYWRvopjejFUIPFVKQyDceWFDOYF6Jq40zXD4UAg2tdW+azcZzY2JJi6/3Ww4SfP1rlu5irqiUCtSvFTxXDIkHcX4xFzS9KaV1Uo22vcfl+nefSS/QkMb6H/GhPHhl5/jl59f8cV9nY2Sdl0PvDYJzH9MLmvnWoctdn8tRUVNS5s5EMHZ7KWw==
X-OriginatorOrg: blmgroup.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P195MB0885.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ccad5e-920b-4601-efa9-08de899ae7cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 11:45:54.0300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7c75bcb-c343-421d-900e-e426af0269ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LS3EXjqcaKNMs7neCsWZ6LvoxHVUkJcGl0rDqYaK09djdMoNyCP8yN1dulAsyJSOYvIR5HaL4afxdksvjOoQ4vf5wL/98EJvo6uwbaf8vSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1727
Cc: 

RGVhciBKYW4sDQoNCnRoYW5rIHlvdSBmb3IgeW91ciBpbnB1dC4gSSd2ZSByZXZlcnRlZCB0byB4
ZW5vbWFpIDMuMS43IGFuZCBjYW4gY29uZmlybSBpdCB3b3JrcyBwZXJmZWN0bHkgd2l0aCBrZXJu
ZWwgNS40LjI5OS4NClRoaXMgc29sdmVkIG91ciBwcm9ibGVtIHdpdGggdGhlIGxpYnJhcnksIGFu
ZCB3ZSB3aWxsIHN0aWNrIHdpdGggdGhpcyBzb2x1dGlvbiB1bnRpbCBhIG5ld2VyIHZlcnNpb24g
b2YgdGhlIGxpYnJhcnkgd2lsbCBiZSBhdmFpbGFibGUuIA0KVW5mb3J0dW5hdGVseSBpdCBpcyBj
bG9zZWQgc291cmNlLCBzbyB3ZSBjYW4gb25seSBwdXNoIHRoZSBzdXBwbGllci4gDQoNCkl0IHdv
dWxkIGJlIG1vcmUgaW5mb3JtYXRpdmUgdG8gZGlnIHRoZSBpc3N1ZSB3aXRoIHRyYWNlcyBhcyB5
b3Ugc3VnZ2VzdCwgYnV0IEkgZG9uJ3QgZXZlbiBrbm93IHdoZXJlIHRvIHN0YXJ0Li4uDQpUaGFu
ayB5b3UgYWdhaW4gZm9yIHRoZSB0aW1lIGFuZCwgbW9zdCBpbXBvcnRhbnRseSwgZm9yIHRoZSBi
aWcgd29yayB5b3UgKGFuZCB0aGUgY29tbXVuaXR5KSBhcmUgZG9pbmcgYXJvdW5kIFhlbm9tYWkg
cHJvamVjdC4gDQoNCkJlc3QgcmVnYXJkcw0KDQpEYXZpZGUgR2FuZG9sZmkNCkxhc2VyIFRlY2hu
b2xvZ3kgRGV2ZWxvcG1lbnQgRW5naW5lZXINCkFESUdFIFMuUC5BLg0KQcKgIHZpYSBwZXIgQmFy
Y28gMTEtwqAzODA1NiBMZXZpY28gVGVybWUgKFROKSwgSXRhbHkNClTCoCArMzkgMDQ2MSA3Mjkw
MDDCoA0KRsKgICszOSAwNDYxIDcwMTQxMA0KRcKgIGxhc2VydGVjaEBhZGlnZS5pdA0KQ8KgIGMu
Zi4gZSByZWcuIGltcC4gMDE0Mjk2NzAyMjUNCkPCoCBjYXAuIHNvYy4gMy4xMDAuMDAwLDAwIGku
di4NClfCoCBQcm90ZWN0ZWQgbGluayB0byBibG1ncm91cC5jb20NCsKgDQrigJxBaSBzZW5zaSBk
ZWwgUmVnLiBVRSAyMDE2LzY3OSBzaSByZW5kZSBub3RvIGNoZSBsZSBpbmZvcm1hemlvbmkgY29u
dGVudXRlIG5lbGzigJllbWFpbCBlZCBldmVudHVhbGkgYWxsZWdhdGkgaGFubm8gbmF0dXJhIHBy
b2Zlc3Npb25hbGUsIGNvbmZpZGVuemlhbGUgZSByaXNlcnZhdGEgZSBzb25vIGRpcmV0dGUgYSB1
bm8gc3BlY2lmaWNvIGRlc3RpbmF0YXJpby4gTmVsIGNhc28gYWJiaWF0ZSByaWNldnV0byBxdWVz
dGEgZW1haWwgcGVyIGVycm9yZSwgdmkgcHJlZ2hpYW1vIGRpIGRhcm5lIGltbWVkaWF0YSBub3Rp
ZmljYSBhbCBtaXR0ZW50ZSBlIGRpIGVsaW1pbmFybGEgZGFsIHZvc3RybyBjb21wdXRlci4gTOKA
mXVzbyBub24gYXV0b3JpenphdG8sIGxhIGxldHR1cmEsIGxhIHN0YW1wYSwgbGEgY29waWEsIGzi
gJlpbm9sdHJvLCBsYSBkaWZmdXNpb25lIGRlbGxlIGluZm9ybWF6aW9uaSBzdGVzc2Ugc29ubyBz
ZXZlcmFtZW50ZSB2aWV0YXRpLiBHcmF6aWUgcGVyIGxhIGNvbGxhYm9yYXppb25lLsKgDQoNClB1
cnN1YW50IHRvIFJlZy4gVUUgMjAxNi82Nzkgd2UgaGVyZWJ5IGluZm9ybSB5b3UgdGhhdCB0aGUg
aW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgZW1haWwgYW5kIGluIHRoZSBhdHRhY2htZW50
cyAoaWYgYW55KSBhcmUgb2YgYSBwcm9mZXNzaW9uYWwgbmF0dXJlLCBjb25maWRlbnRpYWwgYW5k
IGFkZHJlc3NlZCBvbmx5IHRvIHRoZSBpbnRlbmRlZCByZWNpcGllbnRzLiBJZiB5b3UgaGF2ZSBy
ZWNlaXZlZCB0aGlzIGVtYWlsIGluIGVycm9yLCBwbGVhc2UgaW1tZWRpYXRlbHkgbm90aWZ5IHRo
ZSBzZW5kZXIgYW5kIGRlbGV0ZSBpdCBmcm9tIHlvdXIgY29tcHV0ZXIuIEl0IG11c3Qgbm90IGJl
IHJlYWQsIGNvcGllZCwgZGlzY2xvc2VkLCBwcmludGVkLCBmb3J3YXJkZWQsIHJlbGllZCB1cG9u
IG9yIHVzZWQgYnkgYW55IHBlcnNvbiBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQu
IFVuYXV0aG9yaXNlZCB1c2UsIGRpc2Nsb3N1cmUgb3IgY29weWluZyBpcyBzdHJpY3RseSBwcm9o
aWJpdGVkLiBUaGFuayB5b3UgaW4gYWR2YW5jZSBmb3IgeW91ciBjb29wZXJhdGlvbi7igJ0NCi0t
LS0tTWVzc2FnZ2lvIG9yaWdpbmFsZS0tLS0tDQpEYTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBz
aWVtZW5zLmNvbT4gDQpJbnZpYXRvOiBnaW92ZWTDrCA1IG1hcnpvIDIwMjYgMTg6NDMNCkE6IExh
c2VydGVjaCBBZGlnZSA8bGFzZXJ0ZWNoQGFkaWdlLml0PjsgeGVub21haUBsaXN0cy5saW51eC5k
ZXYNCk9nZ2V0dG86IFJlOiBYZW5vbWFpIDMuMSBhcHBsaWNhdGlvbiBjb21wYXRpYmlsaXR5IHdp
dGggbmV3ZXIga2VybmVscw0KDQpPbiAwNS4wMy4yNiAxODozMywgZGF2aWRlIGdhbmRvbGZpIHdy
b3RlOg0KPiBEZWFyIGNvbW11bml0eSwNCj4gDQo+IEkgaGF2ZSBhbiBhcHBsaWNhdGlvbiAoYSBs
aWJyYXJ5KSB0aGF0IGlzIGxpbmtlZCBhZ2FpbnN0IFhlbm9tYWkgMy4xIChJIGJldCB1c2luZyB0
aGUgUG9zaXggc2tpbiksIGFuZCBydW5zIGZpbmUgd2l0aCBrZXJuZWwgNC4xOS4xMTQtY2lwMjQu
IEluIHBhcnRpY3VsYXIsIGl0IHVzZXMgUnROZXQgZHJpdmVycy4NCj4gTm93IEkgbmVlZCB0byB1
cGRhdGUgdGhlIGhhcmR3YXJlLCBhbmQgbW9zdCBzb2x1dGlvbnMgb24gdGhlIG1hcmtldCBoYXZl
IG5ld2VyIGNwdXMgbm90IHN1cHBvcnRlZCBieSB0aGF0IGtlcm5lbC4gV2hhdCBhcmUgbXkgYmVz
dCBvcHRpb25zPw0KPiANCj4gT24gdGhlIGlwaXBlLXg4NiByZXBvc2l0b3J5LCBJIHNlZSB0aGF0
IGtlcm5lbCA1LjQgaXMgc3VwcG9ydGVkLCBidXQgaXQgaXMgbm90IGNsZWFyIHRvIG1lIGlmIFhl
bm9tYWkgMy4xIHN1cHBvcnRzIGl0Lg0KDQpXZSBzdG9wcGVkIHRlc3RpbmcgYWdhaW5zdCA1LjQs
IGJ1dCAzLjEgdXNlZCB0byBzdXBwb3J0IGl0Lg0KDQo+IE1vcmVvdmVyLCA1LjQgaXMgc3RpbGwg
dG9vIG9sZCBmb3IgQWxkZXIgTGFrZSBvciBuZXdlciBwcm9jZXNzb3JzLg0KPiBUaGVuLCB3ZSBo
YXZlIHRoZSBkb3ZldGFpbCByZXBvc2l0b3J5LCB3aGljaCBpcyB0aGUgbW9zdCB1cGRhdGVkLCBi
dXQgSSB0aGluayBpdCBkb2VzIG5vdCBmaXQgd2l0aCBYZW5vbWFpIDMuMSwgYW0gSSBjb3JyZWN0
Pw0KDQpDb3JyZWN0LCB5b3UgbmVlZCAzLjIgYXQgbGVhc3QgZm9yIGRvdmV0YWlsLWJhc2VkIGtl
cm5lbHMuDQoNCj4gTGFzdGx5LCBJIGNvdWxkIHVwZGF0ZSBYZW5vbWFpIHRvIDMuMy54IGFuZCB1
c2UgdGhlIGxhdGVzdCBkb3ZldGFpbCBrZXJuZWwuIFRoaXMgaXMgd2hhdCBJIGRpZCBhbmQgdGhl
IHN5c3RlbSB3b3JrcyBmaW5lIHdpdGggYmFzaWMgdGVzdHMgKGxpa2UgImxhdGVuY3kiKSwgYnV0
IHdvcmtzIGhvcnJpYmx5IHdpdGggbXkgb2xkIGxpYnJhcnkuDQo+IEluIHBhcnRpY3VsYXIsIEkg
aGF2ZSBzZXZlcmFsIHNwdXJpb3VzIHJlbGF4ZXMgYW5kIG1vZGUgc3dpdGNoZXMgb24gDQo+IHRo
ZSB0aHJlYWQgdGhhdCwgSSBndWVzcywgaXMgcmVzcG9uc2libGUgb2YgY2FsbGluZyB0aGUgUnRO
ZXQgZHJpdmVyIChub3QgMTAwJSBzdXJlIG9uIHRoYXQgYmVjYXVzZSB0aGUgbGlicmFyeSBpcyBj
bG9zZWQgc291cmNlKS4NCg0KWW91IGNhbiB1c2Ugc3lzdGVtLWxldmVsIHRyYWNpbmcgKHRyYWNl
LWNtZCAmIENvLikgdG8gdW5kZXJzdGFuZCBhdCBsZWFzdCBmcm9tIHRoZSBrZXJuZWwgcGVyc3Bl
Y3RpdmUgd2hhdCBpcyBnb2luZyBvbiwgZS5nLiB3aGljaCBzeXNjYWxscyBhcmUgaXNzdWVkIG9y
IHdoYXQgb3RoZXIgcmVhc29ucyB0aGVyZSBhcmUgZm9yIHJlbGF4ZXMuDQoNCj4gDQo+IFdoYXQg
YXJlIHlvdXIgdGhvdWdodHM/IElzIGl0IGV4cGVjdGVkIHRoYXQgdGhlIEFQSSwgaW4gcGFydGlj
dWxhciBmb3IgUnROZXQsIGNoYW5nZWQgZnJvbSBYZW5vbWFpIDMuMSB0byAzLjM/IFBsZWFzZSBu
b3RlIHRoYXQgSSBkb24ndCBoYXZlIGFueSBzZWdtZW50YXRpb24gZmF1bHQgb3IgY3Jhc2gsIHRo
ZSBhcHBsaWNhdGlvbiBzZWVtcyB0byB3b3JrIGZpbmUsIGp1c3Qgbm90ICJyZWFsdGltZSIuIFNo
YWxsIEkgZXhwZWN0IGJldHRlciBjb21wYXRpYmlsaXR5IGlmIHVzaW5nIFhlbm9tYWkgMy4yIG9y
IGl0IGlzIG5vdCB3b3J0aCB0cnlpbmc/DQoNCkkgd291bGQgbm90IGV4cGVjdCB0aGUgaXNzdWUg
aW4gUlRuZXQsIHNwZWNpZmljYWxseSBhcyB0aGF0IGNvZGUgYmFyZWx5IGNoYW5nZWQgaW4gdGhl
IHBhc3QgcmVsZWFzZXMuIEJ1dCBsZXQncyBjb2xsZWN0IHRoZSByZWFsIHJlYXNvbnMgZmlyc3Qg
KHNlZSBhYm92ZSkgYmVmb3JlIHNwZWN1bGF0aW5nIGFib3V0IHRoZW0gZnVydGhlci4NCg0KSmFu
DQoNCi0tDQpTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9naWVzDQpMaW51eCBFeHBl
cnQgQ2VudGVyDQo=
