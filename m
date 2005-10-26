Message-ID: <435EC897.3020601@domain.hid>
Date: Tue, 25 Oct 2005 17:06:47 -0700
From: Vincent Levesque <vleves@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] How to implement a GUI for RT apps?
References: <435D7D8C.1010004@domain.hid> <435E079F.4030108@domain.hid>
	<435E0921.20001@domain.hid> <435E5044.8090600@domain.hid>
	<435E5647.70406@domain.hid>
In-Reply-To: <435E5647.70406@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi Jan and Ignacio,

>>>Not true. That thread must be mapped to Xenomai in order to use
>>>rt-mutexes. Otherwise, one has to use rt-pipes.
>>>      
>>>
That's the impression I had. Is there anything I should do in the GUI 
task to make it closer to a non-RT thread? Is there any way, for 
example, to make it remain in secondary mode? I already set the task to 
a low priority.

>>the RT domain, do it. You'll save a lot of headaches.
>>
>>Of course, if your GUI is so tightly coupled to your RT processing that
>>you cannot do without rt_mutexes and/or other sync primitives, then you
>>must map it to Xenomai.
>>    
>>
As I'm explaining in my previous post, I could decouple the GUI from the 
RT side but the tight coupling has its advantages for my type of 
application.

>Ok, an option that does not require context migrations is lock-less
>synchronisation. For example, one may maintain revision counters of data
>structures which get updated on changes by the RT part. The non-RT part
>can then spin on reading a consistent version until the revision on
>entry equals the one on exit. And double-buffering can be used to write
>data structures into the RT domain. But this can be more complex and is
>not feasible in each and every scenario.
>  
>
That's very interesting. I'm not 100% clear on what you mean though. If 
I understand correctly, I could have a single RT task and a normal 
thread (or the main thread) for the GUI. I could then use the fact that 
the RT task cannot be interupted by the GUI thread (?) to make sure data 
structures do not get corrupted. Do I get this right?

Thanks again,

Vincent Levesque
vleves@domain.hid

