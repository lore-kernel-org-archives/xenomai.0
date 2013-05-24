Message-ID: <519EFC7B.8000305@xenomai.org>
Date: Fri, 24 May 2013 07:36:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E9605457112439448B6B3ED284E06533317AC624@mbx256-1.adm.swri.edu>
In-Reply-To: <E9605457112439448B6B3ED284E06533317AC624@mbx256-1.adm.swri.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Next Xenomai Release?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Poole Jr, Donald R." <donald.poole@swri.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/24/2013 01:15 AM, Poole Jr, Donald R. wrote:

> On 5/23/13 5:52 PM, "Paul" <paul_c@tuxcnc.org> wrote:
> 
> 
>> On Thursday 23 May 2013, Gilles Chanteperdrix wrote:
>>> On 05/23/2013 05:57 PM, Poole Jr, Donald R. wrote:
>>>> I guess I overlooked that post and response. Any clarifying
>>>> words/steps on what needs to be done to get the 3.8.x kernel
>>>> patched with Xenomai for running on the Beaglebone/Raspberry Pi in
>>>> the meantime?
>>>
>>> For beaglebone, it is integrated in the I-pipe tree for the ARM
>>> architecture (git://git.xenomai.org/ipipe-gch.git, branch
>>> for-core-3.8), which is currently based on 3.8.0 but will probably be
>>> rebased on a more recent version for the I-pipe 3.8 release, for the
>>> raspberry pi, you can try the patch which has been posted by Paul,
>>> but probably needs rebasing once the I-pipe for 3.8 is released.
>>
>>
>> I have a set of patches ready for 3.8.8 based on the "official"
>> Raspberry Pi sources [1] - Need to reduce the current set of nine down
>> to a pre and post pair which I'll try to do over the weekend. In the
>> meantime, if anyone wants to take the set for a spin, drop me a note
>> and I'll send them over.
>>
>> In the meantime, I'm tracking BCM2835 integration in to the mainline
>> kernel with view to working on 3.10.y - Realistically, I don't think
>> support in 3.10.y will be complete by the time it is released, so we
>> may have to wait for 3.12.y.
>>
>>
>> Regards, Paul.
> 
> Hmm, this doesn't sound very good for Beaglebone users. As Gilles has
> mentioned in and earlier post, Beaglebone users could use his I-pipe tree
> for ARM, which is currently based on 3.8.0. 


But I also said this is not the patch that would be released. Actually
the Beaglebone situation is far better than the Pi situation, because
they can already use the mainline kernel.

> But, if the v3.8 kernel has
> reached EOL like Wolfgang brought to our attention, does that mean Xenomai
> development on v3.8 stops as well?  I don't know when TI or
> Beagleboard.org will release as BSP with a more up-to-date, non-EOL
> kernel, so we might be stuck with the v3.8 for awhile.


Except exceptions (like the 3.8 kernel which Canonical has said they
would maintain, like I posted in an answer to Wolfgang you seem to have
missed), every kernel until october will be EOLed when the next kernel
is out, from what I understood.

-- 
                                                                Gilles.

