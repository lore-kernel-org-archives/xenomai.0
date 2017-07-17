References: <CAKJ14NcXwHkEFSgrnQWG1KacvOhTp9BT9oQNZn_bdzJTCgqhvw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <40f44d9b-885c-e0a7-d1ca-951943c4fdc5@xenomai.org>
Date: Mon, 17 Jul 2017 17:12:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAKJ14NcXwHkEFSgrnQWG1KacvOhTp9BT9oQNZn_bdzJTCgqhvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Andreas Glatz <andi.glatz@gmail.com>, xenomai@xenomai.org

On 07/15/2017 10:37 PM, Andreas Glatz wrote:
> Hi
> 
> I managed to compile and bring-up Xenomai v3.0.5, Ipipe v2, Linux
> v4.9.35 on a Wandboard Quad C1 [1]. I ran all unit-tests sucessfully
> [2] and was able to get RTnet ping to an external PC working. RT ping
> stops working after about 1000 pings... but that's a different story,
> I guess.
> 
> So when I try to get a simple UDP server [3] running on top of RTnet I
> get "Unhandled fault: page domain fault (0x01b)" oopses, where the
> stacktrace indicates it has to do with rtudp.ko, e.g.
> rt_udp_recvmsg+03c/0x38c. Further googling [4] told me that these
> faults are related to missing copy_from_user() calls in the udp
> driver, which seems to have been enforced in the most recent kernel
> versions (after 4.1.x?). So if I go into the rtudp.ko source code and
> start introducing copy_to_user() statements, the the page domain
> faults go away one after the other...
> 
> At my company I basically want to propose to upgrade our current
> kernel (3.0.35) with a more recent one. So I'm looking for a hint
> what's the best+latest+supported kernel version for i.MX6 in a
> production grade setup, which can be patched with Xenomai3 (incl.
> RTnet)?
> 

I've been working on i.MX6 (4/2/1) + Xenomai 3.x for the last couple of
years over kernels 3.18, 4.1 and 4.4, for production grade software: so
far so good, provided one picks the latest I-pipe patches available.

Although Xenomai 3 over kernel 4.9/arm is a bit younger, I have been
using this combo recently on i.MX6 for (Xenomai) development purposes
successfully, so far.

I don't think that preferring any of the kernel releases mentioned above
among others should have a visible impact on RTnet user-wise. I only
tried with kernel 4.9 though.

-- 
Philippe.

