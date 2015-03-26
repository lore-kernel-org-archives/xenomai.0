Message-ID: <5513D5DB.9090809@free.fr>
Date: Thu, 26 Mar 2015 10:48:11 +0100
From: =?UTF-8?B?U3TDqXBoYW5lIEFOQ0VMT1Q=?= <sancelot@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] heap: bad usage or design problem using named heaps ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hi,

I faced the following problem with xeno 2.5.x , but may exist on other 
releases .

1/ I create a rt_heap
2/ in this rh_heap I alloc many named "data area"
I always give the global rt_heap ptr. no problem, areas are allocated.

3/problem arises when unallocating/unbinding
using rt_heap_free/rt_heap_unbind.
only the last segment created is freed. Because the global heap ptr size 
contains only size of the last allocation.


============================
to solve the problem, I had to use a distinct rt_heap for each named 
area, in this case.

At first, I may have misunderstood the way was working rt_heaps ?
I was thinking I could manage only a heap with many named modules inside 
it...

Regards
S.Ancelot







