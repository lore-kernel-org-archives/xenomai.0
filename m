Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13313FFF
	for <xenomai@lists.linux.dev>; Fri, 26 Aug 2022 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1661530806;
	bh=JCQLOASIgaflD0SS0rsjhffGp2weU7YzexGplBTrkrk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=h75EQaKuPuVZU8AM4n9NYosYtEW/7pX5TSoUqRUs4zb7o5CeVwA0qQBd9GaH52jnm
	 iMCnk0z8NAdHSseD2JU3E67MbDaAfa34hRo0IFu2siTIIezZCxe+7HtNDg999m6Sa6
	 sIorfaVmq/xfs++Lyo4m9e3dzesm/KeqfOyNPGKs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([92.210.49.225]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8TBS-1oVzmA1yHA-004cvW; Fri, 26
 Aug 2022 18:20:06 +0200
Message-ID: <a6aa4aa0-fe70-a6fe-35ab-08c9636b59c4@web.de>
Date: Fri, 26 Aug 2022 18:20:05 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: ipipe-4.19 on arm64: Stack overflow when compiled with gcc 12
Content-Language: en-US
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Cc: "rpm@xenomai.org" <rpm@xenomai.org>
References: <977443ed9083abfe574dcb1aa8582ecf091c2ff1.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@web.de>
In-Reply-To: <977443ed9083abfe574dcb1aa8582ecf091c2ff1.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rX71moJFD5pG3qwVloylKtUlYzjTiVWQmlXH66oOO4kqHLMph9B
 Mp0KLi7RwMD+C67cQc8HSmWAKWsV1mqIlgOqacjJLOCixJx19hxZJox98+NvI3cLXTAvI3/
 Ic2DlpfXKlDzNA+kUFDTtzna6zIoxVT3n5kLwn7zBxiyqO2jpCM7Rgg/0xjhNTrE+/i3Z8j
 ou6+A3/67JzqHxLsEiO6g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lYmwVOVd0NA=:kza6oZBUvR/qOB6BgJeSIy
 Z5k2Cr2u5ygodknK/9eumUZr+eZykH563r+VEAEH/TRJ6i7/iRYJbL3af2O/7AkA7J4xaZeUM
 asoK+Lzo4vZ/KyEjOyJoYT766plLwnWFRpXSMAa+28bJzjRxvHDL1ysD04G0KJUOZKCXQBdF4
 zmYQaTmZrUUNic8Z52eivv3jlLvhgkqeHrH5O53UrFhZ4vUjc67S5w3EsLGuw5tVEcrsXnvwY
 W32HP4XXIr0XqBeP0AsF8KIGd/3aUg3zYa0h/N10D1x5ECwtcStfL4uLjSzLZi2rq7VWHDNiE
 CHBLLqctPH/JfIufI59ynONsf+oobAEPL5ddonuQXsokugCo68McmM1mHpxlT2WgrfHnKyjvB
 WvuA+Yn+pCT8YFyehvrzKwEDbhEdR/aQ2su4n98fsi2jGCDymHkibyGwXNxorffaJEkyT51eb
 Bd7Vy/7abO+I8vF6MchOBvt6jhFOkIsY2M6ArubHAxtfGuGhmoUTqbscOM+wEuKCjvTdmI/Et
 7Eaw0eJOl0vKM+vEGtW6aT5E3AEpp8NxlGp2dXRd4JiHWuQ6azdZ+eYulMMtZH7McOQaz4/sD
 DH8K/hE2yteTccUqkeHJ/SyfcYNS2RTLMe0fpG6NM+ZOp35ouakqBqLyYIkHIDqrLGRFYXxK2
 mJeVaRrGGovDmWFIa/5OTDIui0afe7nre0o5EFZ2BdXFTPOlpfVnu3PtXo+nIMqEj/+JLCmo4
 nv5oRq87wT9IJlsGnDrt2p5xLchpnpmwllwA14PGjUpBx4IawVRMJpPy1RodZ56vopHLTc1G7
 fi8VldU2NvYE0FmmLw75GyRawOQ9uQdDUWqUjHG6AMYmyMd99DrbJlKYRwFxZp6WEQl9QOCIr
 +K+sDr+lfiZRYkW1uFJRiDkeW197kwKERUrC6y+8zTFsmpvRpcm+DUpG6PSDeHCo6GME5KKrL
 RqcGNkxVfIDfU0RI36Hhju+gZvn9CcRyPCBDMaduAHeneVU9m7Ml43FWOVK4A4bQOfWvjC5Bf
 lCokwhfcNMJhC+mwGBZ0mc8MJ0dRYZ/G3H9sM9EUSqYwMqKDTbNJ5TMakf2agxiIr1aA33Mpw
 OzlFT61/9Zl06c+HAKiO6g3XsrMxMwu3N0vpkvSDsT1Ue19eQdLrx34Sw==

On 22.08.22 10:52, Bezdeka, Florian wrote:
> Hi all,
>
> when trying to find a platform/image that is able to build and test all
> of our Xenomai branches and kernel combinations for driving the CI
> infrastructure I hit the following problem:
>
> When compiling ipipe-4.19 using gcc 12 the arm64 testboard (hikey)
> crashes with a kernel panic due to a stack overflow.
>
> The logs are available here:
> (Searching for "Kernel panic" might help)
>
> - https://lava.xenomai.org/scheduler/job/5069 (stable/v3.1.x)
> - https://lava.xenomai.org/scheduler/job/5072 (stable/v3.2.x)
>
> Is that something that should work / should be supported or should we
> define supported compiler versions (per Xenomai/Kernel combination) as
> well? I hoped I could avoid adding even more complexity into the CI
> build/test matrix.
>
> Waiting for your comments...
>

Already checked if something happened in 4.19 or some slightly newer LTS
kernel related to "gcc 12" that we just did not pick up with the I-pipe
branches so far?

Jan
