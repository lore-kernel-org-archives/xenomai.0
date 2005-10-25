Message-ID: <435EB00B.4040407@domain.hid>
Date: Tue, 25 Oct 2005 15:22:03 -0700
From: Vincent Levesque <vleves@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] How to implement a GUI for RT apps?
References: <435D7D8C.1010004@domain.hid>
	<435DF423.5000800@domain.hid>
In-Reply-To: <435DF423.5000800@domain.hid>
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

Hi Jan,

>...and hopefully do not call any non-rt functions while holding the
>lock. Note that you can install a SIGXCPU handler to catch such
>potential accidental violations. Likely not needed if you only copy some
>data between the shared objects and your local buffers (all locked into
>memory - mlockall?).
>  
>
What do you mean by non-rt function? System calls? Functions that take a 
lot of time to run? Unless I made some mistakes, I'm only doing simple 
computations and copying data while mutexes are locked. I'm also using 
mlockall().

What would be the effect otherwise? I assume it would slow things down 
(by taking too long or switching to secondary mode) and possibly starve 
the rest of the system (freeze). I'm currently getting segfaults...

>>To summarize,
>>
>>1. What's the best way to implement a GUI for a RT app?
>>    
>>
>
>Depends too much on your requirements, GUI toolkit, etc. to give a
>general statement here.
>  
>
Good point. I guess the real question is: what are my options?

A few words about my needs. I'm a grad student in a research lab 
specializing in experimental haptic devices (computer interfaces for the 
sense of touch). I've been writing RT software to control different 
pieces of hardware. The software is for the most part for prototypes and 
will never leave the lab. The specs are constantly changing and I need 
to be able to continuously refactor and extend my code. My GUIs are 
mainly used to modify parameters and determine what goes on in RT 
control loops. I also give feedback with widgets and opengl drawings.

I could use the traditional decoupled approach (two processes) but that 
imposes some limits on what can be done fast. It essentially means that 
I need to design some kind of communication protocol between my RT and 
"non-RT" processes using queues or shared  memory. It's not that 
difficult but it complicates things and discourages changes to the 
software once finished. This approach can also quickly lead to very ugly 
hacks and workarounds when you can't afford to spend much time 
refactoring. It's not uncommon to see huge "do-it-all" structures with 
obsolete fields being passed around to save development time.

The approach that I'm using is more risky but it has many advantages 
(if/when it works). After all, there's a reason why multithreaded apps 
and frameworks like CORBA are popular...

Some information about my development env.:

OS: Ubuntu Linux 5.04 / 5.10
Kernel: 2.6.13 with ipipe adeos patch
RT: RTAI/fusion 0.9
Language: C++
GUI: gtkmm and gtkglextmm

>>2. Is my approach "legal" in fusion/xenomai?
>>    
>>
>
>Sounds sane to me. Which fusion version are you using? Already tried to
>update some component (kernel, patch, fusion/xenomai) and watch
>potential changes?
>  
>
Just to be sure we're clear: I have two tasks reusing the same RT_MUTEX 
structure, not two structure with the same content. That is allowed?

I didn't try to change much at this point. In fact I had to go back to 
my old linux distribution for the time being. I was using RTAI/fusion 
0.9. I switched to Xenomai 2.0 last night.

>>3. I remember reading that RTAI and X don't play well together. Is that
>>the case with Xenomai? Will things be better if I use the two-processes
>>approach?
>>    
>>
>
>Not a general problem, but a specific one related to certain graphic
>cards and drivers (don't ask me which, we are only using head-less or
>console-based boxes here).
>
That's good to know. I think I figured out why my program was sometimes 
freezing *before* the upgrade. It was unrelated to any problems with X.

Another question: Is there any restrictions on the use of the "new" 
operator in a RT task (or after calling mlockall)? That's the other 
possible culprit I had in mind....

Thanks a lot for your help!

Vincent Levesque
vleves@domain.hid

