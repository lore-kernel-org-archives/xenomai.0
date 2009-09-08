Message-ID: <934774.26170.qm@domain.hid>
References: <793108.19562.qm@domain.hid>
	<4AA691B8.4090204@domain.hid>
	<394564.56258.qm@domain.hid>
	<4AA6D85C.8040707@domain.hid>
	<982599.63991.qm@domain.hid>
	<4AA6DE47.8010804@domain.hid>
Date: Tue, 8 Sep 2009 15:53:25 -0700 (PDT)
From: Guvenc Gulce <gulceg@domain.hid>
In-Reply-To: <4AA6DE47.8010804@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Xenomai-help] RT Task RPC over a POSIX/Native Queue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

rt_net is nice but then all network participants have to use rt_net otherwise 
the realtime communication is not guaranteed on the wire.. in some cases 
the real-timeliness on the wire may not be needed but the determinism 
of the rt-task may still be an issue..

I think it is a great flexibility to give an rt task the chance to communicate 
with non rt_net clients and servers in the network without worrying about 
losing its determinism. 

Regards,

Guvenc



----- Original Message ----
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
To: Guvenc Gulce <gulceg@domain.hid>
Cc: xenomai@xenomai.org
Sent: Wednesday, September 9, 2009 12:44:23 AM
Subject: Re: [Xenomai-help] RT Task RPC over a POSIX/Native Queue

Guvenc Gulce wrote:
> Guvenc Gulce wrote:
> 
>>>> Leaving Xenomai domain is not bad per se. The reason why it is bad is
>>>> that when re-entering Linux domain, you may have to wait an unbounded
>>>> time for Linux to let your task run.
>>> Exactly and that would disturb the real-timeliness of the rt task.
>>>
>>>> With your approach, the first RT task would not leave the Xenomai
>>>> domain, but it would wait for the second RT task to complete. And the
>>>> second RT task would risk to wait for the same unbounded time.
>>> Why should the first RT Task wait for the second RT Task when 
>>> the second RT Task has lower priority than the first one ? If Xenomai 
>>> scheduler works as expected then the first rt task should be 
>>> able to continue to run after writing into Posix Queue (marshalled Linux 
>>> call) and collect the results of the called linux function when 
>>> the second rt task gets them and marshalls them back to a second 
>>> feedback Queue which can be read by the first RT Task when 
>>> it is appropriate for it. (Feedback Queue needs to be polled by the 
>>> first RT Task as there is no async communication possibility in 
>>> Userspace Realtime Environment) 
> 
>>> The main advantage here is that the original RT Task never loses his 
>>> determinism as it might be doing some other jobs other than waiting 
>>> for the answers from the called linux functions.  
>>>
>>>> So, in short, you gain nothing.
>>> I think the gain is that the original rt task stays deterministic and is still able 
>>> to call the linux functions and can continue to do his job which needs 
>>> determinism and may poll the feedback Queue some time later and 
>>> get the results of the called linux function. 
>>> Such a thing is impossible to do with the current Xenomai API, 
> 
>> Yes, you could do that, though, I do not see any real-world application
>> where this would make sense. I mean, if you call a function you
>> generally want to get the result immediately. What application do you
>> have in mind?
> 
> Opps.. I didnt realize that I was replying to you and not to the list.. 
> 
> A typical application would be for example to offer a rt task the 
> possibility of network communication without disturbing its determinism. 
> If you send a data over the network, you dont necessarily expect 
> the reply immediately or write to the file system again without 
> disturbing the determinism. 

We have rtnet, a deterministic networking stack. For writing to the
filesystem, we have rtdk.

-- 
                        Gilles.



      


