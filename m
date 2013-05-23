Message-ID: <519E677F.9050001@xenomai.org>
Date: Thu, 23 May 2013 21:01:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E9605457112439448B6B3ED284E06533317AC337@mbx256-1.adm.swri.edu>
In-Reply-To: <E9605457112439448B6B3ED284E06533317AC337@mbx256-1.adm.swri.edu>
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
Cc: Xenomai <xenomai@xenomai.org>

On 05/23/2013 05:57 PM, Poole Jr, Donald R. wrote:

> On 5/23/13 10:51 AM, "Jeff Webb" <jeff.webb@nta-inc.net> wrote:
> 
> 
>> On 05/23/2013 09:32 AM, Poole Jr, Donald R. wrote:
>>> Hello Fellow Xenomai Developers/Users,
>>>
>>> I've have be following the development of Xenomai over the last few
>>> months on this mailing list and have noticed a lot of good features
>>> being added and bugs being fixed since the last 2.6.2.1 release. So, my
>>> question is when is the next stable version of Xenomai going to be
>>> released?  I'm particularly interested in the Bealgebone 3.8 kernel
>>> patch since this is the hardware I'm working with.  I have read the post
>>> regarding the Raspberry Pi/Beaglebone I-pipe patches, but I it was
>>> unclear to me how they were to be applied and to what code base they
>>> were to be applied to.
>>>
>>> If someone could clarify to me how to use the patches in there current
>>> state (if they are stable enough), that would be great. Otherwise, I
>>> could wait until the next official release, that I presume would have
>>> the RaspberryPi/Beaglebone 3.8.x kernel patches.
>>
>> Someone just asked basically the same question (about the next release) a
>> few days ago:
>>
>>   http://www.xenomai.org/pipermail/xenomai/2013-May/028515.html
>>
>> Gilles gave a nice response:
>>
>>   http://www.xenomai.org/pipermail/xenomai/2013-May/028516.html
>>
>> I'm surprised you didn't notice these posts if you've been on the list
>> for a few months...
>>
>> -Jeff
>>
> 
> 
> I guess I overlooked that post and response. Any clarifying words/steps on
> what needs to be done to get the 3.8.x kernel patched with Xenomai for
> running on the Beaglebone/Raspberry Pi in the meantime?


For beaglebone, it is integrated in the I-pipe tree for the ARM
architecture (git://git.xenomai.org/ipipe-gch.git, branch for-core-3.8),
which is currently based on 3.8.0 but will probably be rebased on a more
recent version for the I-pipe 3.8 release, for the raspberry pi, you can
try the patch which has been posted by Paul, but probably needs rebasing
once the I-pipe for 3.8 is released.


-- 
                                                                Gilles.

