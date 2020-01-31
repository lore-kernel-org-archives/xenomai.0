Subject: Re: [PATCH 0/8] Assorted fixes
References: <20200131152713.1811748-1-rpm@xenomai.org>
 <0c811fd4-dc46-0bce-99b3-64c150725d3d@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <3d4b8b99-761e-c1ec-4b40-a7f6b86d9b6a@xenomai.org>
Date: Fri, 31 Jan 2020 17:35:36 +0100
MIME-Version: 1.0
In-Reply-To: <0c811fd4-dc46-0bce-99b3-64c150725d3d@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 1/31/20 4:55 PM, Jan Kiszka wrote:
> On 31.01.20 16:27, Philippe Gerum via Xenomai wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>>
>> The first four commits fix the doc generation which has been broken
>> for some time, the rest addresses runtime issues detected in the
>> field. See commit logs for details.
> 
> Thanks for the fixes. Patch 3 needs folding - or we simply drop it.
>

Let's drop it, since distcheck works without it now.

> For the other issues: I suppose we need more torture tests...
>

>>    cobalt/registry: fix export/unexport race on object deletion

This can be triggered from userland, by stressing open/close on the nrt
side vs socket/bind/close sequences on the rt side.

>>    cobalt/registry: prevent use-after-free triggered by object removal

This was detected by KASAN, it is unlikely to trigger an easily
reproducible crash.

>>    drivers/ipc: bufp: fix rd/rd and wr/wr races

Non-trivial to reproduce, very timing dependent.

>>    boilerplate: setup: fix infinite loop in CPU list parser
>>

Trivial to reproduce, but no added-value for a regression test IMO.

-- 
Philippe.

