Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B89113790B
	for <xenomai@lists.linux.dev>; Thu,  5 Feb 2026 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298335; cv=fail; b=Df5ZiCVQDkve/lt9Kw1lM2Lvn/vMK59nAMXw1dGkiVPzpft+8ugGjOgJ1kDPSS+PjYfC/vd8cAfdpFFmpZU+rBH3GvdxV9URE6d0vHeCFkt8Uh/4dEF7qxfH9yAT2lKLfGlQVOJg7ScOIzm9qrAebJBjwn1xqeRLcbP5EpKjCY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298335; c=relaxed/simple;
	bh=ZFyg4sWPNkgFKpnnUKlHlIaqdpydBpWzEs3UogBwLjc=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=anOJurDmLm9PwhPTa8qX6P3isKlGqxxn9a+I0/PU27GhMBVxDmfUrMJMIODbtD7koSwXDCgWcS5R8v7thJxKbTe2cOJs365McsYyPDXfRQ1hnFKcBNuCOToRt7O1BNrTJdbf5E+eQuxxssdTvNbz0qdbrMXa4xlUHwVrNT+PmJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=OYDbS9hJ; arc=fail smtp.client-ip=52.101.66.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="OYDbS9hJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbWJLcMNysKKXbTJGcAjNjlF2UB/ZHfgeS3l/orthcC9u4QhiNJlgI+qYWYwTg9pasSPiV9B8wfCkeQBk0C9CT1oPWK3D0pbI+a1bMzt/5SbfbnRCs/ywpQGTlfFHL437CqSdcy4aFE+6lPQM7qBvuVRnQl3U+OMVjb6uOr0tURfn2cbLMN8wv1D5eTdg37JZaKAhgtblkwXkdbWOBqcwcUxzxkXl2bBlNlA/5Pv/DFn2s+99/IUHyFVVNJmzd0NJZviAl7FMLKVYYQhHDugYTLT16HDXmWBBSpx7g4QCi88kxt+M4D0QBJQWFl8tYCE0QlJg28ixGnXUlnVOZmOAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKUVT89cOY4TjoLBLY7qWgJi5SC3qfMdZRuUHAVNyko=;
 b=cy+/sq47SrgokW4TVZ7olpgIr4fylNRCTloAw5tJp9XBj/L/e2yWrgjxLfOJzf1AxBPFENG1TfVwPNDMM6mgPkHfY+ep6Hr6O8+z3SQGGFM5GvAjt7l0a5Fhv8eEzzam9NZX2PYafHeRBBQ6RzX7c0D9dMQddEOqh6wBqKg1HnfdDPl+J1XaH52tJ8e0UTkS9Mf0fjSGaiHvJUCaCfZVfIeknprKDJ/mMUnXqgPgudfN/euw1P9utjOjmo7Or1G65VdJ1s2tRTuY1VKglW5WC2YX3Z2zaVGlqrl9UTnBooJ0DhwY5ZNsGQNoep4gi7rASSlev+yJ4hRBAURi7H9hnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKUVT89cOY4TjoLBLY7qWgJi5SC3qfMdZRuUHAVNyko=;
 b=OYDbS9hJ7GHmPN0+vC7SJKJugmhSPJaMukR0ZpmeECtzZkpqjm5k4kyg0bl3DkPGQXO0V+UJBR8qrTT8V7qjPxId8+iZhRlTkAjGZTqCz/QD+FA94I4VpTtsftueA6vZEdueo2OWwcY2nVBkzEfx2N5fqC2NQctplolJYcnYsHnP3O2S3k9tigMwhOZWo26cdAKcnuvhLGdm9IzJjKIAtD3zO3ytOKB10IYdurfjAB5b2zI/YbSlpHtlrePaP7usJFN0NEyQkBH1DKIfRVMGrLZH1kZbkifB+YNwfqVJu74YSYRKDiUF26ZOEywlReEtyMXZiF3oPHqd8kZiN8uZ7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GVXPR10MB9644.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:312::24)
 by DB4PR10MB6069.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 13:32:11 +0000
Received: from GVXPR10MB9644.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a23d:a0c3:e7d6:f03d]) by GVXPR10MB9644.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a23d:a0c3:e7d6:f03d%2]) with mapi id 15.20.9542.009; Thu, 5 Feb 2026
 13:32:11 +0000
Message-ID: <db8c1dc5-eb36-4f68-969f-c07e408bf03d@siemens.com>
Date: Thu, 5 Feb 2026 14:32:10 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: rpm@xenomai.org, Xenomai <xenomai@lists.linux.dev>
Cc: "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>
From: Clara Kowalsky <clara.kowalsky@siemens.com>
Subject: Trigger xenomai-images CI for linux-evl and libevl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::9) To GVXPR10MB9644.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:312::24)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR10MB9644:EE_|DB4PR10MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a51a34-cfa0-4dd1-9e22-08de64baf772
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czgyNWRCVTlSSHJQS3BQeHRadXVLWlhTbFNlZE94OFk4K0U2dnFoSm1ZcVlE?=
 =?utf-8?B?N1RjdG8vV2hWVlRjdlZ2OTg3NlFna1NJRWN2TFNWTUljOFVuWDNHbVd2WHBP?=
 =?utf-8?B?VzRFQVNNKzBwamVza3FwcmhwRFJnUWFVR0xFUHkxMURZbjROZkxPTmZ6NzhM?=
 =?utf-8?B?ekozTjJZMFBYT1cvUWMvMW1iT1ZnWXZRUVR0cEVPMFZzWmgxOWUydW1IbEU0?=
 =?utf-8?B?bERNamZMenUyRnJpRHpOWENtRnJmOW9uc214SURPd3Ardmg2bnUxNG9UMjV3?=
 =?utf-8?B?NHc1cTV2ZXdHNm45cU1UWHoxbWNBOFA4WjRYemVZcDZid2xOaWtsdWRsZFFo?=
 =?utf-8?B?SFdDbVFTMy9jUStSU2xXWFFwNFkrVTZmaFY3UnlTaW91T2xGSXlZdkZpMUxY?=
 =?utf-8?B?TEt6MThIWXRFNER0bytTNHNxUXM0OFhGQjJIc1QrTGhtU2wySURxUjcxT0xo?=
 =?utf-8?B?NG5ldXY5SURJY2hUM3diaW5BOGRib3NOK1RqYjRpTGp5SGZwSUNxSU9BZUVU?=
 =?utf-8?B?QkJFb3FsKy9od294N3VicWV4ZU9rU215T0F6Ni9MMzdKUEY3SUlFZGlodytz?=
 =?utf-8?B?bEhGTS9PeCtCQWVWbGx0R1I2YUVocitmNCtxU3pIWjlPTUdKcnpBVmdvR3Az?=
 =?utf-8?B?ejAwSmRBMDR2azZ6emxsOW1zM0RiSEdPU1pHQm5iK2JXajJscytnRkx0dHVD?=
 =?utf-8?B?WlVrSFBMR3JadVVNcXFNbVRBdDNFK0ZTWHBiaDNHUUJmQ2VTRjE4dDhqanl1?=
 =?utf-8?B?cWtSV3hFWmx4Rmc5MFYvc0FXZzFCemNIT1hCMmFyNjFrUXRCVDRHUm9PS2FD?=
 =?utf-8?B?b0hiR080bGp2d1NIV1l5MStLbFl4VDlZb29QRnVwRU1Uelo4RnJWVHhoQkw1?=
 =?utf-8?B?NkIxT0RXdG0zWGxZMm1VclhMTElxVDhQTjg1WkxJb3dFSkR0QU1nczRBRmZZ?=
 =?utf-8?B?RUtFZFlsN2pGczVudUszSkZaNnR0THp0NU93ZlZ2MEEyZDRET25LdXFnODZP?=
 =?utf-8?B?SkRtZ2VvbGdpbGhKTnBGT0JPWHJIVTh2em13R0d2Ti9PenNldXN2RWZmNE9h?=
 =?utf-8?B?UzM4YzdKQTNTK3dHbUkwMUcyV0t2aWIxOUl0bnd3Ry90azNlYWJ2c0c0ZVpa?=
 =?utf-8?B?RTJSdTVJcFhmTjlJYmhVTFFQTnJRQmFCRFlmT0R0aGtFZ05jWFJvQVo5Wi9s?=
 =?utf-8?B?S1dSeVNFNnlHSEwvMjdDY2ZtWWdMdWFCbW9UVU52VHROcjh5MjdxNlZOQmdW?=
 =?utf-8?B?cDFoYzdmV1ZGWllyZkNlUThVaGtyOGJPZ0xxc244UkVydVcvSXl0a1dmZDBo?=
 =?utf-8?B?S3luSVQ0NlZGb3BFZEE0ZENYRkM4dVhXVnk2c3N1TVptd2NUNTM0L1EwcHRt?=
 =?utf-8?B?dmJYbEFDdFdXT2ZpOFJzcktoU1pCSDhXcWovbnhNeVlaOW8xSzFOUG1Oa05n?=
 =?utf-8?B?bkJZTmRnSmZSc3JMSXN1VGhsMGJORFZEaU9wWWNJRDVocHpEaW80MVVzNmZ4?=
 =?utf-8?B?SDlVL1pKbTU1NkYzZm5TVnVCZlo3elNXbTdHKzVuTVdkdkpHa1hJVzV0dGxL?=
 =?utf-8?B?a1BZVmJ0T0Z2c3JuZkJDTkoreGJ6bGdBUTMwMlpMR1JrL1VsbkVLZ1BFVXd3?=
 =?utf-8?B?WldTbzJnTVNqMVBJUCtPQUVuZmRHbkE3bHhMb2lRejlpRlFFUldIU080cDMy?=
 =?utf-8?B?NGhrcGgrTHdtSlVZUUpkUFdiaVFYcVhkaEUyOSt6V0FVQmJoWDNDSi9sSHN6?=
 =?utf-8?B?aFBxYzk3eFBYNkt3aEZNelRwQThoazR4b3g2TXlFOFJTaHVlb2NkSjZ6V1hy?=
 =?utf-8?B?THZTNDluSWpZRmVxbmlGVVFwcEZ6dzNQMTJoOWNQamVOUko4R3h6OEd5RnFS?=
 =?utf-8?B?c1BHeEFscDJuVjNYOWtaSm0zUzRKNnFiSVMwWHpvcExDSzRGK1J0TU13SHcy?=
 =?utf-8?B?QWNmNzRSSE5TYnBMTi9PekNlanBCa0t4WE90a20rSHQwY0RWWVdqR0tUYjc0?=
 =?utf-8?B?NUhLa1FFbHNxOUJ2UVRHOVptRHJORG03Z3dIQzA0R1J4aGpCS1lSdDBZTFVh?=
 =?utf-8?B?bWsxMHV0WmU0UkZmTzFDQVBWUCs2VHhLUkpHZ0VjRWVtU0JEQUpsV25TQVJp?=
 =?utf-8?Q?SBBA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR10MB9644.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEx3cm9Cakk5a29sWWVreU1pTVhWZ0xGVFRqU2YwWko0Q0NkbDlHVytoVEcz?=
 =?utf-8?B?TWhwTWprV2JlOGFOZ1p1ZEVCdTFSQXlRQlNTWVpxV3d4TFRJZmRqdVk1dVc5?=
 =?utf-8?B?YU5WUTduais2V3JGMHc1b25hT01UVm5SNDJSYVV1VmE3SVI4SEZIcVQrWlJi?=
 =?utf-8?B?S1hCc0piYXZpZlV1ZUxwaHIxNWlWb1FacDBsUlFLZTc1elBOZ0NmaXJWZlRk?=
 =?utf-8?B?TzVBb2hCQW5OK2tGRzIwa1RTMEFzeVJvclNGYjlpUkNYU2ErK0hLQk81YXRi?=
 =?utf-8?B?WE1DTzFkSHFEYVYwZHFhTEJJcXp5V3Axd0JpNmtiVC93emkwQUc3eGw1RXo4?=
 =?utf-8?B?cU5BOXQxNEVUVHhuU1BsSEFXU0U2OHBhc3BYaGpRRFRpejN0cTZuaHZMUGdB?=
 =?utf-8?B?dHhPQVErOFVTRmZidk4ybGZ6eDMzODN0UEg3R3hUSnh4VWMvdjI5WEVUbXpi?=
 =?utf-8?B?SVpiZGpxMGdlSUUwT2JQd3NQTStNcnk2RGRsMXZ1SEtjdnBYclZRUXNsT3Fv?=
 =?utf-8?B?K29rMENTR2VkaUxJaTlqNS94NklhZ0FPSzRJTjVnVTRUME5rTmJWZEl4eTla?=
 =?utf-8?B?U2F1WmtXdkRyNVFTbkZoaFhoVUE5elZXNGJpTWMxTFM1KzJhdVVQL0JhK0lm?=
 =?utf-8?B?VndqY1FRRjVXaVRmdUtTTmFTRU5Zeng2TnFnZGF5dkRGQTlhcmQrdUk4eWFB?=
 =?utf-8?B?U2NWc0poTmRoM1RJQ2plNUdNWEJUTk1YU2lQTWl3U3N0K3o2cUJEUEVWRHJZ?=
 =?utf-8?B?MExQOVgxNGZidzl0L3ZtWXBoc1pVcHpRcVJSNHdKak04SmRpM2hHTlVMYWQw?=
 =?utf-8?B?THR6YjEwMFNueFVqTnZodXowVldLRXBHZXVKSXBoajlBTU9kbVhoMmtDZHNr?=
 =?utf-8?B?R2dKU01SbjQ1dUR3NnVJZ0RwZzlrZTZFOUt5dmtudFJJcjlXcnpxY0FQVzJl?=
 =?utf-8?B?NTBWYW9vTUNKaWJwb1NlbnBHUEU4Ymp3Qnd0QUI1c3UvMVVXRnRodm5ITEJq?=
 =?utf-8?B?eVViemcvbXAyUW4wS1F4M2RsclVrTUE5bUpRcXhoaTkrWHkxTVdickw2Q3JQ?=
 =?utf-8?B?S2YxOWtPbXZXQmJyRE5OWVNJbHBlVWc3cGwrUytnOVh0czQ4YmM0TUtYTUp3?=
 =?utf-8?B?L0hyckJLVTRqMkc3U1NOdWxkL1VXMmdMd2FYMmthSWV3VUhrVlQwMHBzR1Jz?=
 =?utf-8?B?V29ERll3NitobjVLNG1VRmM2WUFieWl2dmxsWEpHZ24vYXJWTTRVTG8xb2dD?=
 =?utf-8?B?TVlLaGdRYUMyYUpia0R1SGs0U0U3aEJ4eXVIckR5T1lSNzE1V3pzWGxiZXlB?=
 =?utf-8?B?aTlTeUpsK21ZZkJKbG1rWXFqeGFxdEthUGI3VmxwcjNpMXl1cE9GKzZCTXVN?=
 =?utf-8?B?aEQxNGpRNGwvNDVpZGFwU3BDODh0QWRleVdTZjErNG5MTEx3MFgyTU5mWG9G?=
 =?utf-8?B?MjMvRTNrVkVxbHNuOERnZm51UmlWZzZ5V2gySjRhY3FqWjJiUDlRL2FMZ2VZ?=
 =?utf-8?B?bUMxaEtrNVpOMlhtUjdCYTdMR2RhWnlIellLVmhHR2ZBNGZxQURzYlpxdk0x?=
 =?utf-8?B?M2wrMnplSytnTjdpYS9KM2RhUU1wZ3FiMFA3OGRDbm5lR2tPbXo2NXVDWkln?=
 =?utf-8?B?QVVFNVg0c3RydUNDSU9FZzZNUm95Ky9XbjlpMlAwNWhKQjFnYlJUaUl3ZkEw?=
 =?utf-8?B?U0JPNjNTRytVajlWNHlmbDVjN3UvQ1VLNTZneWZ0d1BhbU8zTk1laGg2eGdP?=
 =?utf-8?B?NitpWmptQWRMZWFxK0tvUm04bXhoVmNyOGhvM013QW1GdHhsVWwyZ29UM1lL?=
 =?utf-8?B?MDNYd1lDYUJVUnF5LzZkeVBRVFB4RXlpd0NPeGtpcHFVY2RvTXNLTEVwSG9H?=
 =?utf-8?B?ZzhycFpLZm1vditKRnNTYTRYdE9NbzNkVUFUOFpCVXdoR3ZnU3pYRWZ6Uk9Y?=
 =?utf-8?B?UlBBV1pmSGZYU3ZVM0hUelI2ckdlbStVNlV6WWJSbmJBY1FhY2lXSnBGMk4y?=
 =?utf-8?B?Tml4ODNBV21MQnhESXdWcjcvSURTbTBRcFZzemdtS1ZvRENoZUtCdUpzRnRP?=
 =?utf-8?B?TGJUY1dqUnJRN1hBTWZtRVpOVG5YVHhFdzNlTEpPM3F3ZllkQU13VkhmekI4?=
 =?utf-8?B?Zm1mUjQ0SEJWUXR3R0Y0N2dmZVZ2bkc2SThDUkttRVhVWkFTck5maHR1Smhl?=
 =?utf-8?B?dW1NeUtiaEdIWDQrcGNZQUd4VTNvbGpMWHNZdkhWKzRzamRTejdJdVRhNm1U?=
 =?utf-8?B?UkRnVzFwaUtoTnZiMTdOa2F1c1NCQXl4dGJiZ2FKTXVUSnNwVklpRS9hNlBj?=
 =?utf-8?B?OE5ONzRSa3BFZ3RpRU15T2ozMWFlN0hXU0FVL2NoV0JKcy83T3p1RDk2bUl5?=
 =?utf-8?Q?P+vysVI7K74Nk6Wk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a51a34-cfa0-4dd1-9e22-08de64baf772
X-MS-Exchange-CrossTenant-AuthSource: GVXPR10MB9644.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 13:32:11.2977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRIfKXoLAXHWpuecCAORamdpMJezWLIRgYGL0Hy03VdC1p/SUfD1SPX+yeDm/F5Dsw02JlC6Y3s3K3F+wJRslchWFCc256JGer76Tl6b4yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6069

Hi,

I am planning to add support for triggering pipelines in xenomai-images 
on pushes to linux-evl and libevl, as suggested by Jan Kiszka. In this 
way, they are covered by xenomai images just like xenomai-3 and dovetail.

I would trigger the xenomai-images pipeline for pushes to:
- linux-evl branches: head (6.18), 6.12, 6.1, in combination with libevl 
next
- libevl branches: next, in combination with linux-evl head

Would that be in line with your thinking, Philippe?

Best regards,
Clara Kowalsky
