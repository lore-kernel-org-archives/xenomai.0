Message-ID: <47BEB33F.8020908@domain.hid>
Date: Fri, 22 Feb 2008 12:34:23 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <OFBA487F20.21A14F15-ONC12573F7.00329129-C12573F7.00329C76@domain.hid>
	<2ff1a98a0802220308k5aa66dddi95aad51b8d6178d2@domain.hid>
In-Reply-To: <2ff1a98a0802220308k5aa66dddi95aad51b8d6178d2@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Advice needed: Xenomai / USB access from kernel
 task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "G.P.M. Haagh" <g.p.m.haagh@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> On Fri, Feb 22, 2008 at 10:13 AM, G.P.M. Haagh <g.p.m.haagh@domain.hid> wrote:
>>
>> One of our trainees has written a LKM that accesses the standard Linux
>> kernel's usb_core facilities from a Xenomai real-time thread running in
>> kernel space.
>>  I am doing some follow up on his work and run into problems.
>>  I would appreciate some help/advise.
>>
>>  1)
>>  The main question to start with: is it Ok to submit urbs to usb_core
>> (usb_submit_urb) from a Xenomai kernel task (task created in a LKM) ?
> 
> Without looking at the function implementation, it is hard to answer.
> The short answer to this question is "no". In general, it ils not
> possible to call regular Linux services from a Xenomai task. Now, it
> may happen that it is possible, if the said service does not rely on
> any Linux services such as spinlocks, mutex, etc...

If we are in fact discussing a call from Xenomai RT context into the
vanilla USB stack, the answer is a clear "no". Even if we ignore the
incompatible (/wrt Xenomai) locking mechanisms the vanilla stack uses
(*), there is still the design issue that this stacks performs buffer
allocation on demand, and not in advance (like RTnet does for networking).

> Note that there is an USB stack for Xenomai, so, using this stack
> could be a better solution:
> http://developer.berlios.de/projects/usb4rt

There is another stack, usb20rt, which even supports USB 2.0 (the above
is limit to 1.1 so far). But I recently received a private mail
confirming my original review of usb20rt: It is only half-converted to
RT, still including incompatible Linux calls.

Conceptually, I consider usb4rt as the cleaner approach (not only
because it was a former student of mine who wrote it :->), but it also
suffers from its experimental state, having at least one known issue,
and lacking EHCI support.

Jan

(*) Switch on CONFIG_IPIPE_DEBUG_CONTEXT to learn about such problems
_before_ they happen to cause spurious crashes.

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

