Subject: Re: [PATCH] cobalt/intr: fix interrupt stat iterator
References: <20190424102940.12754-1-rpm@xenomai.org>
 <e2d59fb7-93fd-579e-44a9-410c03562f5f@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <90b07ec0-5c87-bf1f-8ffe-540c96092024@xenomai.org>
Date: Thu, 25 Apr 2019 17:11:36 +0200
MIME-Version: 1.0
In-Reply-To: <e2d59fb7-93fd-579e-44a9-410c03562f5f@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 4/25/19 4:53 PM, Jan Kiszka wrote:
> On 24.04.19 12:29, Philippe Gerum via Xenomai wrote:
>> The implementation does not iterate fully over all CPU slots for every
>> handler, leaving some of them uncollected. In addition, if maxcpus= is
>> used to restrict the number of available CPUs to a subset of the
>> present ones, with the highest numbered CPU marked offline, the
>> iterator rescans the first valid IRQ slot indefinitely, eventually
>> leading to memory corruption due to out-of-bound writes.
> 
> The patch looks good and works fine for the common case, so I've applied
> it to next.
> 
> But I cannot reproduce your maxcpus setup as - for to-be-debugged
> reasons - we are already crashing on 4.14 and 4.4 on x86 during boot.
> Did you test on ARM?

Yes, i.MX6. Quad-core restricted with maxcpus=2.

-- 
Philippe.

