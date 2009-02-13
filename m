Message-ID: <4995A827.7090408@domain.hid>
Date: Fri, 13 Feb 2009 18:04:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <f83fbfb0902122257r72aa1d5boc8ac8fd2460c3939@domain.hid>
In-Reply-To: <f83fbfb0902122257r72aa1d5boc8ac8fd2460c3939@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Subject: Re:  Known-to-work motherboards?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michael Smith <2michael.smith@domain.hid>
Cc: xenomai@xenomai.org

Michael Smith wrote:
>> Gilles Chanteperdrix wrote:
>>> Stuart O Anderson wrote:
>>>> If there isn't a list online that I've missed, is anyone running
>>>> xenomai on a relatively recent machine with 8 or more cores without
>>>> problems?  If so, can you provide hardware specs?
>>> Xenomai will have scalability problems when running on an 8 cores system
>>> (if you intend to run real-time tasks on each of the 8 cores).
>>>
> 
>> We are running Xenomai on up to 4x4 boxes, but only with 1 or 2 cores
>> used by RT tasks. I've some patch hanging around that restricts Xenomai
>> (specifically its host timer hook) to a CPU subset in order to mitigate
>> the scalability issues - guess I should finally get it in shape and post
> it.
> 
>> However, my point is: Massive parallel RT is not (yet) feasible with
>> Xenomai, but it is no black magic to have massive parallel non-RT load
>> living together with confined RT load on the same box.
> 
>> Jan
> 
> Hi Jan
> Just for information, we are running quad core and dual core machines with
> Xenomai and RTNet on our system and we are using each of the quad's cores
> to the maximum capacities (each running a RT process) and we are getting
> incredible
> latencies and performance with an optimized system.
> I am talking from about the low micro seconds to even a few hundreds of nano
> seconds.
> I am really impressed with what we can push out of the correct hardware /
> Xenomai
> combination and also with the multi-processing capabilities of Xenomai.

Nice to hear!

But now think even further: >1 processor, NUMA systems (also Intel
switches to them now), more cores (32, 64, ...), higher Linux timer load
and/or longer critical Xenomai sections due to even more complex
applications. All this will quickly increase the synchronization
overhead of the central lock Xenomai is using, reducing the available
CPU power for both RT and non-RT.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

