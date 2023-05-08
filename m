Received: from smtpoutv5.alinto.net (v5prod-smtp3.alinto.net [83.145.109.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE78017D0
	for <xenomai@lists.linux.dev>; Mon,  8 May 2023 14:46:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtpoutv5.alinto.net (Postfix) with ESMTP id 4QFPHb4YxFz53n3C
	for <xenomai@lists.linux.dev>; Mon,  8 May 2023 16:46:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localdomain
Received: from smtpoutv5.alinto.net ([127.0.0.1])
	by localhost (v5-smtp3.alinto.net [127.0.0.1]) (amavisd-new, port 10050)
	with LMTP id 4Wq4ZsP9z6TN for <xenomai@lists.linux.dev>;
	Mon,  8 May 2023 16:46:19 +0200 (CEST)
Received: from [192.168.13.12] (unknown [80.254.183.189])
	(Authenticated sender: frey@stettbacher.ch)
	by smtpoutv5.alinto.net (Postfix) with ESMTPSA id 4QFPHb0cwhz50WY0
	for <xenomai@lists.linux.dev>; Mon,  8 May 2023 16:46:18 +0200 (CEST)
Message-ID: <214d5fea-6991-44f9-d858-8034687dba8a@stettbacher.ch>
Date: Mon, 8 May 2023 16:46:18 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To: xenomai@lists.linux.dev
Content-Language: en-US
From: Felix Frey <frey@stettbacher.ch>
Subject: Some newbie questions
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi everybody

I'm new to Xenomai, however I'm familiar with RTAI and the dual kernel concept and
realtime designs in general.
Now I'm facing the challenge of porting an application and a driver from RTAI to Xenomai.

First of all, what would be the recommended version of Xenomai to use: 3 or 4 (EVL) ?
For now, I'm not bound to any application interface.

There seem to be several different application interfaces (skins?). Ok, when I go with
EVL than it's given by the libevl. Otherwise what would be the recommended interface?

I need to implement a driver which handles a realtime interrupt and resumes a userspace
rt-thread when the interrupt arrives. What would be the straight forward way to implement this?

Any help is appreciated.

Regards
Felix


