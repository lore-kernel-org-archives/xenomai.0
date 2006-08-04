Message-ID: <44D3097A.6040407@domain.hid>
Date: Fri, 04 Aug 2006 10:46:50 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Future of Xenomai's RTDM driver repository
References: <44D07C4E.4040200@domain.hid> <44D1ACB8.3090906@domain.hid>
	<1154620430.5010.79.camel@domain.hid>
In-Reply-To: <1154620430.5010.79.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Hi Wolfgang,
> 
> First of all, thx for the CAN stack. Great job.
> 
> On Thu, 2006-08-03 at 09:58 +0200, Wolfgang Grandegger wrote:
>> Jan Kiszka wrote:
> 
> <snip>
> 
>>> Now I would suggest to look at RTCAN (or what it will be called in the
>>> end) and to discuss on this first concrete example how we can proceed
>>> towards the sketched goal.
>>>
>>> Looking forward to your feedback!
>> As you have said, maintaining a RTDM driver within the Xenomai 
>> repository clearly has some advantages but it also puts more burden onto 
>> the Xenomai maintainers and some developers might even prefer to keep 
>> thing separated. Therefore I suggest a simple RTDM add-on framework to 
>> support external RTDM drivers as well. They could be announced and 
>> listed on the Xenomai home page and then it would alsl be visible that 
>> there is a FireWire stack for Xenomai.
>>
>> What I had first was a add-rtdm-driver.sh, a modified version of 
>> Philippe's prepare-kernel.sh script, to add the RTDM driver to the 
>> kernel tree. Similarly, as script could be used to add "loosely" the 
>> driver to Xenomai.
>>
>> What do you think?
> 
> I can't speak for Jan wrt providing a RTDM add-on framework, but since
> Xenomai is currently the reference platform for RTDM (at least, the
> real-time infrastructure over which most of this work is experimented,
> debugged and stabilized), I would rather seek integration of RTDM-based
> drivers into the Xenomai tree, instead of a complete separation.

I understood that Jan also prefers driver integration into Xenomai. Just 
for some big external package like RTnet, an add-on would be nice to 
benefit from the Xenomai infrastructure (static linking, etc.).

> The reason being that it makes sense (to a Xenomai maintainer, that is)
> to reduce the odds of discrepancies between the core real-time
> framework, the driver infrastructure and the client drivers, at least
> while the first two are undergoing a rapid evolution. The same "in-tree
> vs out-of-tree drivers" maintenance dilema which is known from the
> kernel folks will also apply to us, if RTDM, and/or RTDM over Xenomai
> are as successful as we wish, i.e. creating opportunities to provide
> lots of RT drivers sharing a common infrastructure.
 >
> Said differently, the day a significant number of people will start
> relying on a rich collection of RTDM-based drivers over Xenomai, we
> _will_ have maintenance issues to deal with, anyway, starting with
> answering a lot of questions on xenomai-whatever*. In such a case, I'd
> rather reduce the odds of integration issues between Xenomai-RTDM and/or
> RTDM/drivers. This said, I'm not saying that Xenomai should be the only
> RTDM-based driver repository in the long run; but I'm arguing that
> Xenomai could be used as a centripetal force to help developing and
> stabilizing the RT driver ecosystem around RTDM.

OK, I can follow your arguments. It's fine for me.

Thanks.

Wolfgang.



