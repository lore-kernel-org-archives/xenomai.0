Message-ID: <4ACDBE6A.2060605@domain.hid>
Date: Thu, 08 Oct 2009 12:26:50 +0200
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <abbab2d60910070942l2bfbc0bboca0232fb674e1ec0@domain.hid>	
	<4ACD86F4.4070407@domain.hid> <4ACD8DCC.50906@domain.hid>
	<abbab2d60910080104n67bd5ef6t9e1a85b0bbcb7ac8@domain.hid>
In-Reply-To: <abbab2d60910080104n67bd5ef6t9e1a85b0bbcb7ac8@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] XUM 2009 follow-up : Powerlink,
	CANopen and 	sockets.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Edouard TISSERANT <edouard.tisserant@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Edouard TISSERANT wrote:
> Hello.
> 
> I agree, it is a shame for those patent holder to behave that way.
> Sure they don't even understand the way they are killing their own
> future business. Even more incredible is the weakness of the invention
> claimed by those patents.
I was not even able to find anything in the patents that related to the master
side, but in this case better safe than sorry.

> I also admit that Powerlink is far from being the smartest and more
> efficient real time Ethernet implementation, but it have the advantage
> to only require standard Ethernet controllers for both Masters and
> Slaves.
I totally agree (thats probaly why there is a X20 system on my desk right now).

> Please, now, let's keep those problems out of that discussion, and
> focus on the only Ethernet based fieldbus we can implement freely
> without taking risk to be censored.
Will do, I just had to speak up so no-one else started putting code into a
project that couldn't legally be used anywhere. Looking forward on testing your
stuff.

/Anders

> 
> Edouard
> 
> 
> 2009/10/8 Anders Blomdell <anders.blomdell@domain.hid>:
>> Peter Puchwein wrote:
>>> Edouard TISSERANT wrote:
>>>> Dear hackers,
>>>>
>>>> I've been passing last month seeking for the best way to implement
>>>> Powerlink with Xenomai. I still didn't find the absolute truth, and
>>>> would like to confront my point of view.
>>>>
>>>> In short, Powerlink is a kind of CANopen over polled ethernet.
>>>> Powerlink re-use a subset of CANopen concepts for high level
>>>> communications, whereas on the low level, a single master cyclically
>>>> poll each node for data. As you can imagine, communication cycle is
>>>> seriously influenced by each controlled node latency answering poll
>>>> requests from master.
>>>>
>>>> My intention is to write an efficient Powerlink implementation for
>>>> Xenomai, but suitable for later reuse in future Real Time Linux
>>>> implementation such as RT-PREEMPT. Discussing with RT-PREEMT gurus, I
>>>> understood that re-using native Linux queues could never be a
>>>> solution, as those queues induce way too long and unpredictable
>>>> latencies for such real-time ethernet (those latencies also apply for
>>>> SocketCan). Some software hook at ethernet driver level will be
>>>> necessary to reroute RT-related packets directly to the concerned RT
>>>> stack. With this approach, the whole stack would have to stay kernel
>>>> side to reduce latency in answering poll requests. Implementing the
>>>> whole CANopen stack kernel side is generally a bad idea, as it
>>>> complicate access to object dictionary from application, usually in
>>>> user space.
>>>>
>>>> RTnet proves that Real-Time ethernet can be implemented through the
>>>> socket paradigm. I believe that Time Division Medium Access (TDMA) of
>>>> RTnet could be interchanged with polled ethernet medium access
>>>> discipline from Powerlink. Thus, CANopen implementation part could
>>>> stay user side, and could pre-fill answers to poll requests, avoiding
>>>> long latencies. But what is the future of RTnet ? Will it be ported to
>>>> RT-PREEMPT or will it enter official Xenomai tree ? Will available
>>>> RTnet's drivers set continue to grow ? Would it be theoretically
>>>> possible for RTnet to support Linux ethernet drivers through a hook
>>>> mechanism as mentioned in previous paragraph ?
>>>>
>>>> My feeling is that, yes, we should try to fit implementation of
>>>> Powerlink data link layer inside RTnet as another MAC discipline, and
>>>> use a modified version of CanFestival for CANopen aspects, keeping it
>>>> a user space library. Please comment.
>>>>
>>>> Best regards,
>>>>
>>>> Edouard
>>>>
>>>
>>> Hi Edouard,
>>>
>>> we are successfully using the EtherCAT-Master (www.etherlab.org) with
>>> xenomai. We've choosen EtherCAT because of the high availability of
>>> components.
>>> With the features CoE (Can over Ethercat) and EoE (Ethernet over
>>> Ethercat) you have a lot of possibilities.
>>> Most common network drivers are already implemented for use with
>>> realtime implementations like Xenomai.
>> Beware that Beckhoff does not allow open-source implementations of the EtherCAT
>> stack, they require you to sign a "shared source license" that prohibits anybody
>> to use the code for any other purpose than a "standard compliant EtherCAT
>> master". We scrapped all our EtherCAT development (which was demonstrated at
>> JavaOne 2007) because of that very prohibitive license.
>>
>> /Anders
>>
>> --
>> Anders Blomdell                  Email: anders.blomdell@domain.hid
>> Department of Automatic Control
>> Lund University                  Phone:    +46 46 222 4625
>> P.O. Box 118                     Fax:      +46 46 138118
>> SE-221 00 Lund, Sweden
>>
> 
> 
> 


-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

