Message-ID: <43592FFE.6060003@domain.hid>
Date: Fri, 21 Oct 2005 20:14:22 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] EDF or RM scheduler for Xenomai
References: <1436.10.2.100.4.1129898928.squirrel@domain.hid>
In-Reply-To: <1436.10.2.100.4.1129898928.squirrel@domain.hid>
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
To: Germain Olivier <germain.olivier@domain.hid>
Cc: xenomai@xenomai.org

Germain Olivier wrote:
> At the beginning of October I've posted on the RTAI mailing list a
> question about the development of additional scheduler for RTAI/Fusion.
> 
> About the pluggable scheduler infrastructure, can you give more details on
> what you expect ?
> 

An implementation in the nucleus that make scheduling policies provided as 
software plugins, so that we don't end up with braindamage exception cases in 
nucleus/pod.c in order to support them. As of now, nucleus/pod.c implements the 
fixed priority FIFO policy in a hard-wired manner: to have other policies 
integrated into the core, we need to think of a lightweight generic 
infrastructure for hosting those plugins that would replace the hard-coded, 
FIFO-based, scheduling decisions.

> Also I'm searching in which files the priority inheritance mechanism code
> is implemented.
> 

nucleus/sync.c.

> Thanks
> 
> Germain
> 
> 
>>100% agreed. The key issue is having the pluggable scheduler
>>infrastructure
>>which fusion currently lacks. After that, other scheduling policies than
>>fixed-priority FIFO could be mapped cleanly and easily on top of it.
> 
> 
> 
>>Jan Kiszka wrote:
>>
>>>Germain wrote:
>>>
>>>
>>>>According to refactoring.txt from Fusion doc directory, Rate Monotonic
>>>>and
>>>>EDF are not supported in Fusion.
>>>>I'm in my last year of CS engineering school with a major in Emmbedded
>>>>Systems. One of the subject of my final year project is to write a
>>>>scheduler (Rate Monotonic, Earliest Deadline First or Least Laxity
>>>>First).
>>>>So I want to know what kind of knowledges is required to put the hand in
>>>>RTAI and develop a such thing. We are two and we have to finish for
>>>>early
>>>>february. We have skills in C, real time theory and developpment (with
>>>>Java), and system programming.
>>>>
>>>
>>>
>>>This would best be answered by the nucleus maintainer, who seems to be
>>>offline ATM.
>>
>>  Philippe already acknowledged the usefulness of a more
>>
>>>flexible scheduling subsystem which, e.g., allows to select a different
>>>policy during compile time or even later. What is certainly required for
>>>this is a clean framework that keeps the compatibility with the upper
>>>(skins) and lower layers (hal) - as far as possible.
>>>
>>>Again, this is something to discuss best with Philippe directly. I guess
>>>he will jump into this thread when time permits. In my eyes, your work
>>>would be very welcome.
>>>
>>
>>100% agreed. The key issue is having the pluggable scheduler
>>infrastructure
>>which fusion currently lacks. After that, other scheduling policies than
>>fixed-priority FIFO could be mapped cleanly and easily on top of it.
>>
>>Hint: scheduling issues are all sorted out inside nucleus/pod.c;
>>nucleus/synch.c
>>should be also studied in order to find out the relashionships that exist
>>between base synchronization object management and scheduling deci
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 

Philippe.

