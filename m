Date: Sat, 13 Oct 2018 00:56:08 +0000 (UTC)
From: Alec Ari <neotheuser@ymail.com>
Message-ID: <1882419000.9157539.1539392168772@mail.yahoo.com>
In-Reply-To: <144decef-a102-1cee-a9b1-8be5ed0d1258@siemens.com>
References: <144decef-a102-1cee-a9b1-8be5ed0d1258@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [ipipe 4.14][PATCH] x86: ipipe: Fix trap hooking for
 userspace routes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Until this bug is properly sorted out, would it be a good idea to revert e6b81a0ce7fb86cf1f1db9f80b982c9b5f95c4c1 and 20db5ea2eee38b123c9641003fe55c895a1fd514 for the time being? The assembly code worked fine the way it was before. At least I never had any issues with it.

Alec

