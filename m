Message-ID: <48FB6247.5010203@domain.hid>
Date: Sun, 19 Oct 2008 18:37:27 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48F9F12F.7090708@domain.hid>
	<48FB15A8.30703@domain.hid>	<48FB17BD.7010904@domain.hid>
	<48FB1891.3060609@domain.hid> <48FB19F7.1030107@domain.hid>
	<48FB5BD5.1060205@domain.hid> <48FB5F1C.401@domain.hid>
In-Reply-To: <48FB5F1C.401@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 1/1] Use SIGWINCH to trigger
 priority	change in user-space.
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai core <Xenomai-core@domain.hid>

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> I wonder if we shouldn't switch the signal hooking strategy: So far we
>>>>>> install the handler at shadow thread creation time, saving a potentially
>>>>>> installed handler of the application for redirection of
>>>>>> Xenomai-unrelated events. But that only works if the application
>>>>>> installed the handler before it creates the first shadow thread, right?
>>>>>> If the app decides to install/change the SIGWINCH handler later on
>>>>>> (without taking care of our handler), we will loose.
>>>>>>
>>>>>> Suggestion: As this is fragile and cannot be solved transparently, lets
>>>>>> document this signal requirement of Xenomai, e.g. in all task/thread
>>>>>> creation functions of the skins. Tell the user that Xenomai will install
>>>>>> a custom SIGWINCH handler and that, if the app wants to override it, it
>>>>>> has to make sure to _first_ call into a Xenomai-provided handler and
>>>>>> check if that one wants to handle the event. I'm thinking of something
>>>>>> like int xeno_sigwinch_handler(int sig, siginfo_t *si, void *ctxt),
>>>>>> where the return code is non-zero in case the signal was processed.
>>>>>>
>>>>>> With this policy in place, we can switch the signal handler installation
>>>>>> above to __attribute__ ((construtor)) and save us all the changes
>>>>>> regarding sigshadow_install below.
>>>>> You mean to push the burden of identifying the signal source and calling
>>>>> the proper handler on the user. With the current approach we take care
>>>>> of that burden, I think it is better. But I agree that this should be
>>>>> documented somewhere.
>>>> Nope, the burden will still be Xenomai's, encoded in
>>>> xeno_sigwinch_handler. The app will only have to check for its return code.
>>> Actually, I have no real preference. Philippe, since you designed the
>>> original code, could you tell us what you had in mind?
>>>
>> My reasoning at that time was that the application folks would not want or even
>> be able to change the signal handling code to insert anything Xenomai might
>> need, hence the override-then-route-unhandled approach. A typical configuration
>> I thought of was GUI-based apps, that would include RT code as well. In that
>> case, I don't think that most of us would want to be dragged into rebuilding
>> kde/gtk libs, for the sole purpose of routing unhandled SIGSHADOW signals.
>>
>> At the same time, I agree with Jan that we should not prevent people who prefer
>> hacking their own software components to install that routing in their handler,
>> instead of fiddling with the order in which they do the application init chores.
>>
>> Well, what about merging the solutions: trap the signal from the library
>> constructor by default for people relying on #1, AND document the shadow signal
>> handler for people who can do #2?
> 
> For me, merging the two, would mean keep sigshadow_install called upon
> thread creation, but export xeno_sigwinch_handler to be callable from
> user signals.
> 
> This way, if people install their signal handler before the first thread
> creation, they have nothing to worry about. If they install their signal
> handler at a later time, they have to take care of calling
> xeno_sigwinch_handler and look at its return value.
> 

Yes, hooking the SIGSHADOW within the lib ctor() would eventually be a bad idea.

-- 
Philippe.

