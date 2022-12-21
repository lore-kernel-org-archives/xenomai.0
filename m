Received: from mta-out-01.tin.it (mta-out-01.tin.it [217.169.118.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BE71FD2
	for <xenomai@lists.linux.dev>; Wed, 21 Dec 2022 09:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tin.it; s=20211207; t=1671613688; 
        bh=KQA3SrEwFUKMvkLpnMZc+a1zSvh8C8cWXrNIZa1gz1c=;
        h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:Content-Transfer-Encoding;
        b=goNk97WSYA15XUlwxzniL6yf6ZHmhpz8UXY6KT4T2nkBOe6RhbumV+YVfe2UgzXfjTLx6VfmzGqVkpgMGNt03Tlo9sBdILAWSMwxFSOAU7hYZN7V9ZMl/VbmIQ9DIzWugc+wvZuILUUIXU6/mbwb0HFIUVLOEkfJEH30Qm1+kUBvxiRKbNPDCXR9jmVg2Caf/7hr1y2YdiPmosYuYzTLiQzExAuCj6Nzig6L4k78tZAHr7iYHk2vVorSOpgSpa9qeVyo9rxZ4EfO5n+90WXFYV/VLk7axNqJyPFQNjWJsFt3so02wJGFsjX3EmSmQsTzn78XO4xBkg4zxVoJF69KLw==
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrgeejgdduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvffgnffgvefqoffkvfetnffktedpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefkffggfgfhuffvtgfgsehtjeertddtfeejnecuhfhrohhmpedfofgruhhrohcuufdrfdcuoehmrghurdhsrghlvhhisehtihhnrdhitheqnecuggftrfgrthhtvghrnhepjeejudekffdukefggfehuedtfeegleelgefgleffteekveetieffleejueevffdunecukfhppeekvddrudekkedrvdehvddrvddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegluddtrddtrdeiledrudekngdpihhnvghtpeekvddrudekkedrvdehvddrvddvjedpmhgrihhlfhhrohhmpehmrghurdhsrghlvhhisehtihhnrdhithdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrvghvkffrpehhohhsthdqkedvqddukeekqddvhedvqddvvdejrdgsuhhsihhnvghsshdrthgvlhgvtghomhhithgrlhhirgdrihhtpdgruhhthhgpuhhsvghrpehmrghurdhsrghlvhhisehtihhnrdhithdpghgvohfkrfepkffvpdfovfetjfhoshhtpehrrgiiohhrqdhouhhtqdhtihhnqddtud
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [10.0.69.18] (82.188.252.227) by mta-out-01.tin.it (5.8.812) (authenticated as mau.salvi@tin.it)
        id 6358E8150538B7BB for xenomai@lists.linux.dev; Wed, 21 Dec 2022 10:05:51 +0100
Message-ID: <9e3a4efe-f967-09c0-e8bb-df8d7e8140a9@tin.it>
Date: Wed, 21 Dec 2022 10:05:50 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: it-IT
From: "Mauro S." <mau.salvi@tin.it>
Subject: "failed to allocate main tcb" error
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I'm using Xenomai 3.1.2 on a x86-64 Atom processor, with Copperplate and 
pshared enabled. Linux kernel is 5.4.181.

I have a main application, and another service application that connects 
to the main one using shared session.

After some time the main application is running, the service application 
stops to connect to the main one with the error

     0"004.166| BUG in main_overlay(): [main] failed to allocate main tcb

Digging a bit in the code, I found that the failing function is the 
xnmalloc() call in lib/copperplate/threadobj.c:__threadobj_alloc().
If I understood correctly, this function tries to allocate some space 
from the shared heap. But the shared heap is almost free

   # cat /proc/xenomai/heap
     TOTAL      FREE  NAME
   4194304   3616512  system heap
   1048576   1041776  shared heap
   1048576   1048480  private heap[14505]
     36864     19968  xddp-pool@0
     24576      7680  xddp-pool@10

Any suggestions about what could be the problem?

Thanks in advance, regards
-- 
Mauro S.
