Received: from mta-out-01.tin.it (mta-out-01.tin.it [217.169.118.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB1F1876
	for <xenomai@lists.linux.dev>; Thu, 23 Jun 2022 09:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tin.it; s=20211207; t=1655975775; 
        bh=EaEMp0HKVkwhDhj5098xVfGNpK7o+AtlwWQw0KZgZ7E=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=uPFU7fer4aF5v0HQTuG/bjm+ce5IaYu5Qult4CPQNyusDdRVrgDeJVK2ed1M/msqHG0aeudT3bUdgxTl83zEB2iOT8DH5fAPE4zWlt3/6GeB5c3rSdInoRqtM68Cs1n5t26SMTioXel5GlelAoauHvM4GgiZLEQ1JXi2Uq1qQADVKtteKRoVtdZ2ZpUXChzenrehlHUV6mdpcEBycSx8CSiD8LaZzOei5bcM2uIoGVzeo+J+KsovDDYdw9fol8JvMTRFtyEDJEfclCOguPoBZxUBwi9sjcy9Me5S/WpMGtHxwUUcRS103Lpu3iQ276v6xb8mPqoHFnG+2jNr/I6WSg==
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrudefjedgudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvffgnffgvefqoffkvfetnffktedpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhevhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpedfofgruhhrohcuufdrfdcuoehmrghurdhsrghlvhhisehtihhnrdhitheqnecuggftrfgrthhtvghrnhepgeduheeugfehhfelffekfeefvdeiveelieffiefgleevjefhvddvheejheevveetnecukfhppeejledrfedurddviedrfedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddujeekrdeftdgnpdhinhgvthepjeelrdefuddrvdeirdeftddpmhgrihhlfhhrohhmpehmrghurdhsrghlvhhisehtihhnrdhithdpnhgspghrtghpthhtohepvddprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrvghvkffrpehhohhsthdqjeelqdefuddqvdeiqdeftddrrhgvthgrihhlrdhtvghlvggtohhmihhtrghlihgrrdhithdprghuthhhpghushgvrhepmhgruhdrshgrlhhvihesthhinhdrihhtpdhgvghoihhppefkvfdpmhhtrghhohhstheprhgriihorhdqohhuthdqthhinhdqtddu
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.178.30] (79.31.26.30) by mta-out-01.tin.it (5.8.810) (authenticated as mau.salvi@tin.it)
        id 629738CA02CBD020; Thu, 23 Jun 2022 11:16:13 +0200
Message-ID: <eae8a831-fc6d-b297-f03d-d477e9ef61ca@tin.it>
Date: Thu, 23 Jun 2022 11:16:12 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] utils/net/rtnet.in: fixes after shellcheck inspection
Content-Language: it-IT
To: xenomai@lists.linux.dev
References: <4e8c2890-bab4-ea31-4db3-0866b389db3e@tin.it>
 <63e4b7c7-bc03-6ca1-f4e1-ac8b77d8826b@siemens.com>
 <7f7ea65a-a58e-33e3-1680-2e59289b2be8@tin.it>
 <fc9fc714-e1e8-8132-7cc3-76e7ee1f4d87@siemens.com>
 <d9a4b75d-81bb-28ea-4bee-293f19637c05@tin.it>
 <cdef20fa-8134-6706-e43a-b94a2e98334b@tin.it>
 <7556be30-4977-143c-f341-cdf1074bf4a3@tin.it>
 <868172c1-7a1f-9a3a-2a3b-55a12aa73958@siemens.com>
 <8bb2afe5-2c91-ec51-e544-65278d56f841@tin.it>
 <aacf04e4-91e3-6232-5b1d-c6570ef6e3f4@siemens.com>
 <86d5b170-dedf-000f-5f23-31bbf9145fd2@tin.it>
 <2897f396-1074-bae0-4cf0-46a97084da2c@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
From: "Mauro S." <mau.salvi@tin.it>
In-Reply-To: <2897f396-1074-bae0-4cf0-46a97084da2c@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/06/22 10:59, Jan Kiszka ha scritto:
> On 23.06.22 10:48, Mauro S. wrote:
> 
> Please use git send-email in the future - I've fixed up the
> misformatting manually this time and merged to next.
> 
> Thanks,
> Jan
> 

Ok, sorry for the noise.

I'm using Thunderbird in plain text, with text wrapping disabled.
I see the patch correctly formatted, both when I send it and when I receive it,
but probably Thunderbird does something "magic"...

Thanks for merging.

-- 
Mauro S.
