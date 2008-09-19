Message-ID: <48D3B1F3.1020408@domain.hid>
Date: Fri, 19 Sep 2008 16:06:43 +0200
From: Harco Kuppens <h.kuppens@domain.hid>
MIME-Version: 1.0
References: <48CE8CE7.6030209@domain.hid> <48D177B1.7000009@domain.hid>
	<48D2184F.3000009@domain.hid> <48D34C63.90304@domain.hid>
In-Reply-To: <48D34C63.90304@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------020407050605090702070604"
Subject: Re: [Xenomai-help] keyboard interrupt
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------020407050605090702070604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


everything is getting clearer know thanks :)
but still a got some things not really clear to may,
hope you still have time to answer them.


Jan Kiszka wrote:
> Yes. For correct handling of shared IRQs, _all_ associate IRQ handlers
> must have been executed before the EOI can be sent. The reason is this:
>
> For level-triggered IRQs, all hardware devices that may have raised the
> IRQ line must be checked and told to lower it again before sending EOI.
> Otherwise the IRQ will immediately be triggered again and you end up in
> an endless loop, bricking your box.
>   
ok, a raised line does not the information how many devices could have 
raised them, so you have to handle them all to prevent missing one.
only after handling them all (they all are lowered) you can send  
'end-of-IRQ' signal

thus when after handling one device all other devices have to be 
rechecked because  in the meantime they could have raised the line
> For edge-triggered IRQs, there problem is different. Here the shared IRQ
> handling algorithm is to consult all handler in a loop until they all
> reported "not for me" in a row. If you fail to do this, you risk loosing
> IRQs. 
> Consider IRQ source A and B. Now an IRQ is raised by B. First, the
> handler for A will be called. It return "not for me". Now it happens
> that A also raised the IRQ right at this time. If you now simply log the
> IRQ for later handling by B and send the EOI, you take away the chance
> for handle A to react on the IRQ. At best you create latency, at worst A
> will never send an IRQ again...
>   
so you should after handling B again have to call all handlers to see if 
they report all "not for me" ?
so you would call handler A twice, right?


Thus when finally when handled all device you send the 'end-of-IRQ' signal.

After reading the explanation above I suppose that when handling an IRQ 
X, there are no new entries for that IRQ X stored in  the PIC controller.
So the next interrupt after the 'end-of-IRQ' signal will be another 
interrupt than the one we just dealed.

at section  8.8.4 off the Intel APIC documentation  /IA-32 Intel 
Architecture Software Developer's Manual, Volume 3A: System Programming 
Guide, Part 1 
<http://developer.intel.com/design/processor/manuals/253668.pdf>/ I read 
a very clear piece of explaining text :

    The local APIC queues the fixed interrupts that it accepts in one of
    two interrupt pending registers: the interrupt request register
    (IRR) or in-service register (ISR). These two 256-bit read-only
    registers are shown in Figure 8-20. The 256 bits in these registers
    represent the 256 possible vectors; vectors 0 through 15 are
    reserved by the APIC (see also: Section 8.5.2, "Valid Interrupt
    Vectors").

    The IRR contains the active interrupt requests that have been
    accepted, but not yet dispatched to the processor for servicing.
    When the local APIC accepts an interrupt, it sets the bit in the IRR
    that corresponds the vector of the accepted interrupt. When the
    processor core is ready to handle the next interrupt, the local APIC
    clears the highest priority IRR bit that is set and sets the
    corresponding ISR bit. The vector for the highest priority bit set
    in the ISR is then dispatched to the processor core for servicing.

    While the processor is servicing the highest priority interrupt, the
    local APIC can send additional fixed interrupts by setting bits in
    the IRR. When the interrupt service routine issues a write to the
    EOI register (see Section 8.8.5, "Signaling Interrupt Servicing
    Completion"), the local APIC responds by clearing the highest
    priority ISR bit that is set. It then repeats the process of
    clearing the highest priority bit in the IRR and setting the
    corresponding bit in the ISR. The processor core then begins
    executing the service routing for the highest priority bit set in
    the ISR.

    If more than one interrupt is generated with the same vector number,
    the local APIC can set the bit for the vector both in the IRR and
    the ISR. This means that for the Pentium 4 and Intel Xeon
    processors, the IRR and ISR can queue two interrupts for each
    interrupt vector: one in the IRR and one in the ISR. Any additional
    interrupts issued for the same interrupt vector are collapsed into
    the single bit in the IRR.

    For the P6 family and Pentium processors, the IRR and ISR registers
    can queue no more than two interrupts per priority level, and will
    reject other interrupts that are received within the same priority
    level.

    If the local APIC receives an interrupt with a priority higher than
    that of the interrupt currently in serviced, and interrupts are
    enabled in the processor core, the local APIC dispatches the higher
    priority interrupt to the processor immediately (without waiting for
    a write to the EOI register). The currently executing interrupt
    handler is then interrupted so the higher-priority interrupt can be
    handled. When the handling of the higher-priority interrupt has been
    completed, the servicing of the interrupted interrupt is resumed.



So another interrupt can be queued in the APIC  in the IRR register though.
But we just handled all devices for that IRQ, so I would say it could be 
skipped. Or not?


I'm also I little bit confused about the term "acknowledge", I couldn't 
find that word in the intel documentation.
In your previous mail you said that linux did the "acking".
In a book I found it means unblocking the PIC, but I would suppose not 
for the IRQ handled, but for all other IRQ's.
Because I understand now that no other IRQs of the same type cann't be 
handled until the 'end-of-IRQ' signal.

Thus what does 'acknowledege' exactly mean?



For everyone interested I also found a nice description about  Level- 
and Edge triggered interrupts  at wikipedia confirming your story at :
  http://en.wikipedia.org/wiki/Interrupt#Level-triggered


Thanks for all help.

cheers
Harco




--------------020407050605090702070604
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
everything is getting clearer know thanks :)<br>
but still a got some things not really clear to may,<br>
hope you still have time to answer them.<br>
<br>
<br>
Jan Kiszka wrote:
<blockquote cite="mid:48D34C63.90304@domain.hid" type="cite">
  <pre wrap="">
Yes. For correct handling of shared IRQs, _all_ associate IRQ handlers
must have been executed before the EOI can be sent. The reason is this:

For level-triggered IRQs, all hardware devices that may have raised the
IRQ line must be checked and told to lower it again before sending EOI.
Otherwise the IRQ will immediately be triggered again and you end up in
an endless loop, bricking your box.
  </pre>
</blockquote>
ok, a raised line does not the information how many devices could have
raised them, so you have to handle them all to prevent missing one.<br>
only after handling them all (they all are lowered) you can send&nbsp;
'end-of-IRQ' signal<br>
<br>
thus when after handling one device all other devices have to be
rechecked because&nbsp; in the meantime they could have raised the line<br>
<blockquote cite="mid:48D34C63.90304@domain.hid" type="cite">
  <pre wrap="">
For edge-triggered IRQs, there problem is different. Here the shared IRQ
handling algorithm is to consult all handler in a loop until they all
reported "not for me" in a row. If you fail to do this, you risk loosing
IRQs. </pre>
</blockquote>
<blockquote cite="mid:48D34C63.90304@domain.hid" type="cite">
  <pre wrap="">Consider IRQ source A and B. Now an IRQ is raised by B. First, the
handler for A will be called. It return "not for me". Now it happens
that A also raised the IRQ right at this time. If you now simply log the
IRQ for later handling by B and send the EOI, you take away the chance
for handle A to react on the IRQ. At best you create latency, at worst A
will never send an IRQ again...
  </pre>
</blockquote>
so you should after handling B again have to call all handlers to see
if they report all "not for me" ?<br>
so you would call handler A twice, right?<br>
<br>
<br>
Thus when finally when handled all device you send the 'end-of-IRQ'
signal.<br>
<br>
After reading the explanation above I suppose that when handling an IRQ
X, there are no new entries for that IRQ X stored in&nbsp; the PIC
controller.<br>
So the next interrupt after the 'end-of-IRQ' signal will be another
interrupt than the one we just dealed.<br>
<br>
at section&nbsp; 8.8.4 off the Intel APIC documentation&nbsp; <i><a
 href="http://developer.intel.com/design/processor/manuals/253668.pdf"
 class="external text"
 title="http://developer.intel.com/design/processor/manuals/253668.pdf"
 rel="nofollow">IA-32 Intel Architecture Software Developer&#8217;s Manual,
Volume 3A: System Programming Guide, Part 1</a></i> I read a very clear
piece of explaining text :<br>
<br>
<blockquote>The local APIC queues the fixed interrupts that it accepts
in one of two interrupt pending registers: the interrupt request
register (IRR) or in-service register (ISR). These two 256-bit
read-only registers are shown in Figure&nbsp;8-20. The 256 bits in these
registers represent the 256 possible vectors; vectors 0 through 15 are
reserved by the APIC (see also: Section 8.5.2, &#8220;Valid Interrupt
Vectors&#8221;).<br>
  <br>
The IRR contains the active interrupt requests that have been accepted,
but not yet dispatched to the processor for servicing. When the local
APIC accepts an interrupt, it sets the bit in the IRR that corresponds
the vector of the accepted interrupt. When the processor core is ready
to handle the next interrupt, the local APIC clears the highest
priority IRR bit that is set and sets the corresponding ISR bit. The
vector for the highest priority bit set in the ISR is then dispatched
to the processor core for servicing.<br>
  <br>
While the processor is servicing the highest priority interrupt, the
local APIC can send additional fixed interrupts by setting bits in the
IRR. When the interrupt service routine issues a write to the EOI
register (see Section 8.8.5, &#8220;Signaling Interrupt Servicing
Completion&#8221;), the local APIC responds by clearing the highest priority
ISR bit that is set. It then repeats the process of clearing the
highest priority bit in the IRR and setting the corresponding bit in
the ISR. The processor core then begins executing the service routing
for the highest priority bit set in the ISR.<br>
  <br>
If more than one interrupt is generated with the same vector number,
the local APIC can set the bit for the vector both in the IRR and the
ISR. This means that for the Pentium 4 and Intel Xeon processors, the
IRR and ISR can queue two interrupts for each interrupt vector: one in
the IRR and one in the ISR. Any additional interrupts issued for the
same interrupt vector are collapsed into the single bit in the IRR.<br>
  <br>
For the P6 family and Pentium processors, the IRR and ISR registers can
queue no more than two interrupts per priority level, and will reject
other interrupts that are received within the same priority level.<br>
  <br>
If the local APIC receives an interrupt with a priority higher than
that of the interrupt currently in serviced, and interrupts are enabled
in the processor core, the local APIC dispatches the higher priority
interrupt to the processor immediately (without waiting for a write to
the EOI register). The currently executing interrupt handler is then
interrupted so the higher-priority interrupt can be handled. When the
handling of the higher-priority interrupt has been completed, the
servicing of the interrupted interrupt is resumed.<br>
</blockquote>
<br>
<br>
So another interrupt can be queued in the APIC&nbsp; in the IRR register
though.<br>
But we just handled all devices for that IRQ, so I would say it could
be skipped. Or not?<br>
<br>
<br>
I'm also I little bit confused about the term "acknowledge", I couldn't
find that word in the intel documentation.<br>
In your previous mail you said that linux did the "acking".<br>
In a book I found it means unblocking the PIC, but I would suppose not
for the IRQ handled, but for all other IRQ's.<br>
Because I understand now that no other IRQs of the same type cann't be
handled until the 'end-of-IRQ' signal.<br>
<br>
Thus what does 'acknowledege' exactly mean? <br>
<br>
<br>
<br>
For everyone interested I also found a nice description about&nbsp; Level-
and Edge triggered interrupts&nbsp; at wikipedia confirming your story at :<br>
&nbsp; <a class="moz-txt-link-freetext" href="http://en.wikipedia.org/wiki/Interrupt#Level-triggered">http://en.wikipedia.org/wiki/Interrupt#Level-triggered</a><br>
<br>
<br>
Thanks for all help.<br>
<br>
cheers<br>
Harco<br>
<br>
<br>
<br>
</body>
</html>

--------------020407050605090702070604--

