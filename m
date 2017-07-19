References: <CAKJ14NcXwHkEFSgrnQWG1KacvOhTp9BT9oQNZn_bdzJTCgqhvw@mail.gmail.com>
 <40f44d9b-885c-e0a7-d1ca-951943c4fdc5@xenomai.org>
 <CAKJ14NcuD7=GiCE13ctaJrNAyPF8xDc6xt9uY+KvMP8GZ_vEWg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <c4dc078b-77e7-3a79-7dfc-790a1dd31c2c@xenomai.org>
Date: Wed, 19 Jul 2017 15:13:26 +0200
MIME-Version: 1.0
In-Reply-To: <CAKJ14NcuD7=GiCE13ctaJrNAyPF8xDc6xt9uY+KvMP8GZ_vEWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xv3.0.5 /Lv4.9.35 on wandboard: page domain fault in
 rtudp.ko
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andreas Glatz <andi.glatz@gmail.com>
Cc: xenomai@xenomai.org

On 07/19/2017 11:26 AM, Andreas Glatz wrote:
>>>
>>> I managed to compile and bring-up Xenomai v3.0.5, Ipipe v2, Linux
>>> v4.9.35 on a Wandboard Quad C1 [1]. I ran all unit-tests sucessfully
>>> [2] and was able to get RTnet ping to an external PC working. RT ping
>>> stops working after about 1000 pings... but that's a different story,
>>> I guess.
>>>
>>> So when I try to get a simple UDP server [3] running on top of RTnet I
>>> get "Unhandled fault: page domain fault (0x01b)" oopses, where the
>>> stacktrace indicates it has to do with rtudp.ko, e.g.
>>> rt_udp_recvmsg+03c/0x38c. Further googling [4] told me that these
>>> faults are related to missing copy_from_user() calls in the udp
>>> driver, which seems to have been enforced in the most recent kernel
>>> versions (after 4.1.x?). So if I go into the rtudp.ko source code and
>>> start introducing copy_to_user() statements, the the page domain
>>> faults go away one after the other...
> 
> I got the 4.1.x kernel running with the latest Ipipe/Xenomai patch and
> this solves the issue I was seeing with the 4.9.x kernel: The UDP
> server works now on top of the unpatched RTnet and I can communicate
> with it through rteth0 (rt_fec.ko) from a remote computer. So,
> something must have changed between 4.1.x (also potentially 4.4.x) and
> 4.9.x in terms of syscall interface. I'll also experiment to get the
> 4.4.x kernel running...
> 
> W/r failing ping tests after 1000 rtpings: I think that's related to
> too few rtskbufs. Recently, I increased the rtskbuf pool to 256 (cat
> /proc/rtnet/rtskb). With this the rtpings keep on working beyond the
> 1000 rtping mark. It is interesting tough that I didn't get any kernel
> warning or error messages, which would tell me that I actually ran out
> of rtskbufs - ping just silently stopped working...
> 
>>>
>>> At my company I basically want to propose to upgrade our current
>>> kernel (3.0.35) with a more recent one. So I'm looking for a hint
>>> what's the best+latest+supported kernel version for i.MX6 in a
>>> production grade setup, which can be patched with Xenomai3 (incl.
>>> RTnet)?
>>>
>>
>> I've been working on i.MX6 (4/2/1) + Xenomai 3.x for the last couple of
>> years over kernels 3.18, 4.1 and 4.4, for production grade software: so
>> far so good, provided one picks the latest I-pipe patches available.
>>
>> Although Xenomai 3 over kernel 4.9/arm is a bit younger, I have been
>> using this combo recently on i.MX6 for (Xenomai) development purposes
>> successfully, so far.
>>
>> I don't think that preferring any of the kernel releases mentioned above
>> among others should have a visible impact on RTnet user-wise. I only
>> tried with kernel 4.9 though.
>>
> 
> Thanks Philippe. As said further above, I'll try Xenomai/RTnet on top
> of 4.4.x as well and see if that works for me...
> 

That would help thanks. I'm currently chasing what looks like a mm
breakage with ipipe-4.9 upgraded to 4.9.38 over a quad-core Cortex A53
(rpi3) which I did not detect after weeks running the same kernel over
several A9-based SoCs. The issues we are both seeing may be rooted at
the same place.

-- 
Philippe.

