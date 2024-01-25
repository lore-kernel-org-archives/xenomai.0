Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5A61C6BC
	for <xenomai@lists.linux.dev>; Thu, 25 Jan 2024 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173897; cv=none; b=ac9sCajgoXEFtEQfaW+rCv2O/YFQ4aXPNUPYfDY9J2UONDmF+BIEfneIbcYCAe/TTBQXSEICG29qwlJ2y4yZRU6l0U2xrRIe4OqLJuPd0+6NIIaoZtEfAfQdQb9uOKvBredJ+8TziS3u46zQY+yzsnwRPkD+ZcZKp6dx6bLJ3xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173897; c=relaxed/simple;
	bh=UUPYy5uNvpRuBK+ahkAg1J0JGftTF68IVeSTdyx4ozM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WOIPLrWM/srJj0mJLncbcX0HeVyJQ+rgFi4NlvmJBCB5BGu+RyWWJvZUHFLrHhEz89FQDYKP7f+jRmIItH3b+5BWVFnrsUzT7so5e8Pqv0bg/aBjhVF/xB1S5Lwa8quFYEKylzfDZfHy3pNxqrImURE2nqPpQI0YkngG9DK9I3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b=aTCqCREH; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b="aTCqCREH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706173884; x=1706778684; i=jan.kiszka@web.de;
	bh=UUPYy5uNvpRuBK+ahkAg1J0JGftTF68IVeSTdyx4ozM=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=aTCqCREHysgw9YdBX9ziWKQptZ369OX+4jyztjX3lQOSPvCPQlzkNfjxWhGw4GUk
	 dxxuT2/OerE4LBhjaUmDd1cQCHkhvS3vlrV8zjaRJprPgG9pqgz9mY77or3TO7PRB
	 XX+P3geky8Nc2pNPmmdNKp16l1WzbY4zRYhzjwx1QmGln9dRShGMcAFk3EgGurDxT
	 yOMZg8KUTmY6wwMrOSum45W7m0UHnRonW2TrlPJZW4jj8CrwmvE/1pdN/83C7EzhB
	 1U4wBEzJjlAwTXEpjhQ0GOQWMAML4n2Gc/MrFT8lQHM4FCjbK6GwMG7RT070no9uB
	 YXi0b2ogyRNpuC5m0w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.10.10] ([46.128.89.130]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDdy7-1rKv0e3QO7-00AkDQ; Thu, 25
 Jan 2024 10:11:23 +0100
Message-ID: <3d503fce-67cf-4946-97a7-8eb159cdb22c@web.de>
Date: Thu, 25 Jan 2024 10:11:21 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Reminder: Xenomai community call on Wednesday, Jan 24, 2024, UTC
 7:00 AM
Content-Language: en-US
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@web.de>
Autocrypt: addr=jan.kiszka@web.de; keydata=
 xsDhBEq0i8QRBAD2wOxlC9m/8t/vqjm1U9yQCT6OJ2Wbv/qys9DYM0CvcOTDMWQwmV1/VsZj
 KR5YgB5NPt+To7X6x5cjz15AGnx5Fb8Wnrq8EF9ZfHMwb7YMx1LdPYPDnXr37wE3XupFmkHB
 Mes4htyX7Dz8LvKDLnli4IsAmWG+kV1JI6LWKXLpSwCg8JRq4SWoB4VCQxbH3GjntgvwNc8D
 /2q5Dj0urJ7s7sdXhrH0hcFkpSFRmU5Yd6MCwcbFHm2paL5gqVjNNUUwDBKAL9eZaQVIHKwC
 44BvNGO2gcQ26R3AuCHUQ+pZHg34tok1JCNZ6IEZccb+33Qq0qbcDMJJiDYp7ppp6ozifvc4
 YaqJECX48IydxfE9+41oV7T5vNAzA/QL/UMJyTnu5jiOXcyn5iFQw535lXkwKsqeXzCowLho
 HICZ2jITJPdTT/+9pGWwMQqST/SS35Tx4EnS3z2BWsNMCLuXCPkxF1elaMJqMfMJxFD8rAgS
 9GK6zP6fJlsA1wq/UvKSL8v4QPOnTNCVOsyqJVasGV0ZPcDfcj+ClNO4zR5KYW4gS2lzemth
 IDxqYW4ua2lzemthQHdlYi5kZT7CYAQTEQIAIAUCSrSLxAIbIwYLCQgHAwIEFQIIAwQWAgMB
 Ah4BAheAAAoJEIrUrG965ecUhIMAnR6DDCW5cx+cVdYhydbhQXqeief6AJ4p+z4+nrmZLdfU
 7V6nKqKeHeTtj87BTQRKtIvEEAgA2/PlX6oyi7dToH0CJCHq0eKmZaa7CmGaVnxyeepKvIfi
 M8n8Td76AbG64fjREMwgSpb4F/UytF3z/03tj4e49W/zKjbBRB2/wmFRlZBC9crg22Q+bgvM
 OsxnC6uHXaWN8fL+jVei/5OoHOoFqaMsX8EvploitlI/BPj+VgW26jksf3YZyk1hnclsZ/IY
 hXzgRmVJo4RiTW/YLQAkwndwc+fKPa/IYLEDW1Jc4kNLoK0P90b45zju0hpl0C00pVORTOtz
 FK9G5Ha7qOAWJfAVJORHKAkkvwftf3hkpPdLyvZUWRHXvUexmA61fLvDBAFhRxYGD8t5gz88
 SF5Tzq+0ywADBQf/YSkaYrEslPWiCA2wU6EW0yaqBQAobFsOMvsufJ6o2ntq5Ncq37VI3KCT
 67eHPE9x+zPcENoZWsRrC9S9PCf1LOsi7ybZsR13AJqDFlRzJZ4klh9QwgwFZxUBzOdIvttw
 zG1QkzHx06RKZluFYpPF3DRduSMukdIJ2wmWCU+ohB+mYefe65JGjYQfHVs8mgYVFOPxbRea
 9VJACCMuspoZWpj43UdR1lLLyIUFYz+jqcPW7Hd/GTIw4N67pYl0dwPDmFd4ohJ5g4Zpq61t
 oNysBGEuEm5GCcn0VmGtQpSYnR5cVm5b2yPz4bIuFOSuZUo/l7vitdY0iy0/wvKbBC+NK8JJ
 BBgRAgAJBQJKtIvEAhsMAAoJEIrUrG965ecULvAAoKGvxs5T3IhyQT8I8sMsyAvCE4wHAJ46
 S16yab+OxNkvOeoOEX0EnHVHaA==
In-Reply-To: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kVcS1e73iwZ19N/cE0bgblHBg7/NYAEeIHEyodWAAFGTJbhnU5j
 U4JSIDlvaCLKfHN8YZdB37c4NDY/vR1qMo4o8Cj6ehawKZ9W+8QBwdL3FT+Czq2i5MLFL0W
 yW+cew3x3yQ7cqkAZP0Dq0euwAUNzEyU6fvbMeiNtgiNwJQ3kNuLJuYytTQ4F4NPAuRyXBw
 eoQQL5+le/SCE0x6+t6aw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:etCvjUS472M=;Hkp2x+2wsc05mdnrkz4S3NSFByP
 F39eBiiGyVmvPbQem1MSMjB0Z0iq21div3g1aKypXbEqgbNezNqs4CKuy7wjrwTpMp29YnwBt
 osNBfv4bFW63gSauobKAgwVdqsR5BuunF/5qnfQROCac763Kq0KReduHBp7CRlSckPLO+Hwmh
 mIIHYyFs4YMJtb3bV4BGsgfjsBSu0/L43dKaE5tEZ9OgGgb+ngAM7/4QToPL/+lUJbWgaW0Ji
 +abyNHmp26OdmNpBA3so8tSmQlb4UKyu5Cp7manNDAhu3j6CghRqloqAUNl9gmoSAIOelOpbz
 A9xDOOJ19AafWPGEcJ3ltOPt3CFUlnTxaiUKFthbLg5ss29Fi7yyRE2lf6n63R3L3SgpsN00u
 MO5VZpGrW+svTsiDEWE0PH9FBnHL/Fy+GS8hzqhYUexpYQC+gBUr/KRdq7Q+JZErKfhPGrF7C
 8SNCOUJ5Gt9bBTXoEWiujsHbGsd+6Mdh3TPpL0jLxx/I58nGGiobxZoIMMvnF51ZcJfAP9MZw
 Q5Mk1LBFQqwOD/21/4k4xITJVjlIdOKgZIMSePpNPxmFTroYfpcmawt+3nwWIdaD1xT2vEhF3
 VdXCMl7VHm9T1YWn5/nlF9n5woBBiyDWGfuiVgESoEFq8C/IGmbWRo3w+S3BeTzQXAuf1o2pQ
 8iQRQ/zVD2s1lL9sqWjtZ/8GTjAWuYR5NvB5/yxMP+zeRkApKCn4QyOXZR/wzjfZiRXO/RFUA
 PE/VS+KR26qvgwBVhpL/ejyN4loqrjCtLVK9e1kWSPqxNlOLuLq4uLteQXo99ZDWZSDKtPOhQ
 kjpuT8Cm3Pk+0s/9wls7kPndvu9l1gmDVfzxPDs+XKn0BV9v+Uh3LiuzfR1jTaR8CHI9aPdKO
 7YjTAKzRVvoIPKv6XX8ORMrYDc4oLAVWTQgW7cr8mWdqBGiW3fyxgr2PfGctURNWSf/jGMLyf
 rxo4RJws8DWfjqrQpS5x+Jg1KAs=

On 24.01.24 07:52, Chen, Hongzhan wrote:
> Topics may include but are not limited to upstream/downstream project
> plans, status updates, and technical discussions. It's an open online
> meeting that anyone can join and ask questions.
>

Sorry, missed the fact that this call overlapped with my absence - off
by one (week).

Jan

