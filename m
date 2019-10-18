Subject: Re: RTnet default behavior
References: <b89e46e4-45b8-1fc1-cb0d-2c4d44b07eb7@compador.de>
 <5b5bb644-2f40-dc2b-0414-a25c35ecffbd@siemens.com>
From: Johannes Holtz <johannes.holtz@compador.de>
Message-ID: <019c5a8c-edb1-2c8c-247e-e0fb3fb2d4fd@compador.de>
Date: Fri, 18 Oct 2019 16:47:29 +0200
MIME-Version: 1.0
In-Reply-To: <5b5bb644-2f40-dc2b-0414-a25c35ecffbd@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Am 18.10.19 um 16:33 schrieb Jan Kiszka:
> On 18.10.19 16:10, Johannes Holtz via Xenomai wrote:
>> Hi ,
>>
>> I inherited a project where the RTnet stack is loaded manually at boot
>> time. To be specific. Instead of using the rtnet command line programs
>> the rtnet.ko kernel object as well as the necessary drivers are loaded
>> with insmod. The devices are then brought up with rtifconfig and rtroute.
>>
>> The network consist of 7 PCs (all with the same boot time mechanism)
>> with pre-defined IPs. The setup works and initializes in an
>> asynchronized way (like a typical non-RT network).
>>
>> I'm investigating some performance problems and I don't know whats is
>> really going on since no config is used. How is determined which
>> participant is acting as Master and how the slots are distributed? What
>> are the default values?
> You only mentioned rtifconfig and rtroute above, no rtcfg or tdmacfg.
> Are you sure RTmac is involved?

This is the list of kernel object that are loaded:

rtnet.ko

rtipv4.ko

rtpacket.ko

rtudp.ko

rt_e100e.ko

rt_8139too.ko

rt_r8169.ko

subsequently rtifconfig and rtroute

Nothing else is done. I don't know id that satisfies for rtmac. How can 
I check?

>> Also: The RTmac readme says a slot "transmits a single packet of up to a
>> specific maximum size". I like to know what that size is and what the
>> behavior is when I have many much smaller datagrams queued. Will they be
>> distributed over as many cycles? And also what happens if I send a
>> datagram which is much bigger. Is there an MTU?
> I'll be happy to explain, but we should first of all try to find out
> what is configured here.
>
> Jan
>



