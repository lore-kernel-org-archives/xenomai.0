Message-ID: <51670ED3.2070009@xenomai.org>
Date: Thu, 11 Apr 2013 21:28:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <FD5EBA50-E222-4012-A755-A20FF5D5971D@mah.priv.at>
	<5165E85B.2040609@xenomai.org>
	<E9BAB42D-B8E9-4E23-8A15-934A72AC7823@mah.priv.at>
	<51660709.3010809@xenomai.org>
	<6C6B8C75-5498-4645-AA10-5651431A1E90@mah.priv.at>
	<516660A2.3020307@xenomai.org>
	<913FB5D5-4051-40BC-A81D-5832DDD4D69D@mah.priv.at>
In-Reply-To: <913FB5D5-4051-40BC-A81D-5832DDD4D69D@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] shared memory compatibility - advice sought
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On 04/11/2013 10:35 AM, Michael Haberler wrote:

> 
> Am 11.04.2013 um 09:05 schrieb Gilles Chanteperdrix:
> 
>> On 04/11/2013 09:00 AM, Michael Haberler wrote:
>>
>>> Gilles,
>>>
>>> I think I see the light although I'm not totally clear on all details yet:
>>
>>
>> There is a very simple solution, see my other mail:
>> http://www.xenomai.org/pipermail/xenomai/2013-April/028169.html
> 
> Well, 'simple' is just my kind of keyword, that one I'd manage 
> 
> I understand there are no dumb questions but rather inquisitive idiots, so let me rattle off my remaining topics in advance:
> 
> - I read this to mean: forget about rt_heap* and rtai_(k)malloc altogether: if that is the case - any downsides in the crystal ball?
> - if it is that simple, why isnt everybody using this scheme over rt_heap_* and rtai_(k)malloc and friends which has the sequencing restriction?


Well, that is the way Xenomai shared memories are implemented, and RTAI
too I guess. The linux native shared memories are implemented
differently, but rely on mmap as well. The point is that instead of
using three different implementations of the same thing which can not
communicate together, and put an abstraction layer on top to try and get
them to communicate together, it may be simpler to provide a fourth
implementation, which you know will always be available in all the cases
you describe. What makes Xenomai implementation a little bit more
complicated is all the part of supporting many kernel API revisions, the
current version of xenomai is still compiling with 2.4 kernels.
Obviously if you do this now you will not have this issue, and the
kernel API for mmap implementation is unlikely to change as much now as
it has changed in the past.

Of course, this is where the down-side is, you will have to maintain
your little kernel module with kernel version changes.

> 
> 
> The overall approach looks a bit like this project: http://sourceforge.net/projects/mbuff/ and the author mentions an interesting point in the FAQ file:
> 
>> WARNING
>>
>> All versions od mbuff have a known bug occuring when a program having mapped
>> areas forks. Do not do it for now. Attach to shared memory areas after 
>> the fork in parent and child if neccesary.
> 
> I do for now take that as a restriction which can be dealt with if it is known to exist even if I dont fully understand where it comes from; some old code remark in the RTAI userland code workaround in LinuxCNC hints that RTAI rtai_malloc()'d memory suffers, or suffered from a similar issue


I would say have a look at the "Linux device drivers" chapter about
mmap, maybe the answer is there.


-- 
                                                                Gilles.

