References: <144decef-a102-1cee-a9b1-8be5ed0d1258@siemens.com>
 <1882419000.9157539.1539392168772@mail.yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ddf9dee0-653d-b784-b01f-8d09a3fda629@siemens.com>
Date: Mon, 15 Oct 2018 13:18:13 +0200
MIME-Version: 1.0
In-Reply-To: <1882419000.9157539.1539392168772@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: Alec Ari <neotheuser@ymail.com>, Xenomai <xenomai@xenomai.org>

On 13.10.18 02:56, Alec Ari wrote:
> Until this bug is properly sorted out, would it be a good idea to revert e6b81a0ce7fb86cf1f1db9f80b982c9b5f95c4c1 and 20db5ea2eee38b123c9641003fe55c895a1fd514 for the time being? The assembly code worked fine the way it was before. At least I never had any issues with it.

Those two commits install fundamental features of the I-pipe patch set, you 
can't reasonably run Xenomai without them. E.g., hell will break loose if a 
Xenomai thread triggers a memory-mapped file access fault during startup while 
it happened to be in RT mode. And debugging will not work either.

The proposed fix may not yet be optimal, but it is apparently sufficient.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

