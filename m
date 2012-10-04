Message-ID: <506D8E6B.10802@xenomai.org>
Date: Thu, 04 Oct 2012 15:26:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <506D7DFF.6040403@wanadoo.fr> <506D82E2.6080908@xenomai.org>
	<506D87E1.8090100@wanadoo.fr>
In-Reply-To: <506D87E1.8090100@wanadoo.fr>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Modified rtcan_virt driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: xenomai@xenomai.org

On 10/04/2012 02:58 PM, Thierry Bultel wrote:
> Le 04/10/2012 14:36, Gilles Chanteperdrix a écrit :
>> On 10/04/2012 02:15 PM, Thierry Bultel wrote:
>>> Hi,
>>>
>>> The existing rtcan_virt driver simulates a single CAN bus, on which are
>>> N devices.
>>> Sending to one dispatches the frame to all the others but the not to the
>>> sender.
>>>
>>> This has several disadvantages:
>>>
>>> - First, to run an application that uses 2 or more physical buses, it
>>> does not fit, because both devices would be linked together.
>>> - Second, having N instantiated virtual devices is in some cases not
>>> necessary, because an application can open the
>>> same device several times, and simulate many CAN nodes, on that single
>>> device.
>>>
>>> Thus I have written another rtcan_virt driver, based on the original one.
>>>
>>> Its behavior is as follows:
>>>
>>> - It instantiates N rtcan devices, that are independent (no frame from
>>> one to another)
>>> - Each virtual rtcan (rtcan0, rtcan1 ...) device has a matching peer
>>> (rtcan0s, rtcan1s ...)
>>> ('s' like 'slave' but I am opened to any other naming) another to
>>> communicate with.
>>> That 'slave' device isautomatically created.
>>> I say 'slave' in quotes because the word hides the symmetrical aspect,
>>> so it is likely unappropriate..
>>>
>>> It is today fully tested, my question was if it could be of interest for
>>> the Xenomai mainline.
>>> If Yes:
>>> - some questions come, to my mind the most important one is if is a new
>>> driver, or a patch for the existing one,
>>> to modify its behavior depending on a parameter. If it is a new one,
>>> what would be the appropriate name ?
>>> - I would be happy to make it as a patch (not ready for that yet, and
>>> until the first questions are answered)
>>>
>>> If No, I just apologize for the noise.
>> I think it is interesting, what about linking the odd ones to the even
>> ones for the symetry?
>>
> I have been thinking about it, but that would break a 'I do not modify 
> my application' rule.
> In my special case, the app uses buses "0" and "1", that the CanFestival 
> stack translates to "rtcan0" and "rtcan1"
> 
> It is Ok to have the "emulated remote nodes" configured to use whatever 
> "rtcan" name,
> but from the application point of view it should be transparent.

Ok, then, what about adding an "nr_devs" parameter to rtcan_virt, and
linking device #n with device #n + nr_devs for n between 0 and nr_devs - 1 ?

-- 
					    Gilles.

