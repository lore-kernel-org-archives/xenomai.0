Message-ID: <46B97817.8000909@domain.hid>
Date: Wed, 08 Aug 2007 11:00:23 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
References: <46B1A842.1090708@domain.hid>	<1186049556.6611.319.camel@domain.hid>
	<46B1B7DE.3080404@domain.hid>	<1186053839.6611.326.camel@domain.hid>
	<46B2E1B3.2020102@domain.hid>	<2ff1a98a0708060208k1d217ae6ge20389074d9bf1bd@domain.hid>	<1186401270.5963.2.camel@domain.hid>	<b647ffbd0708070758t22f01577wd3a5397a53249459@domain.hid>
	<b647ffbd0708080040g7d798f16oe9e03ff233099e33@domain.hid>
In-Reply-To: <b647ffbd0708080040g7d798f16oe9e03ff233099e33@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Unexpected switch to secondary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Dmitry Adamushko kirjoitti:
> [ forgot to add the list : ]
> 
> ---------- Forwarded message ----------
> 
> On 06/08/07, Philippe Gerum <rpm@xenomai.org> wrote:
> 
>>>[ ... ]
>>>But I have another question: since the nocow patch is platform
>>>independent, why not integrating it in the I-pipe patch for power pc ?
>>>
>>
>>It is merged into the latest patches against the powerpc/ tree.
> 
> 
> [ Mainly, just out of curiosity ]
> 
> I've actually tried 'google'ing for an overview of the MMU on ppc but
> it doesn't seem to be easily
> available on the net.
> 
> Do I understand it right that in the PPC arch. a CPU doesn't have full
> access to task's page tables.. that said, if a TLB miss takes place
> (or some analogue lookup mechanism), the CPU needs assistance from the
> OS and e.g. rises an exception.
> 
> [*] A corresponding OS handler gets a 'fault address' and looks for it
> in the task's 'page tables' .. and if found, updates TLB accordingly.
> 
> This would be similar to what happens in MIPS :
> TLB miss --> TLB-miss exception --> OS-dependent TLB-miss handler.
> 
> Now, Xenomai is not able (at the moment) to do [*] on its own.. thus,
> there is a switch to the secondary mode so that Linux is able to take
> care of it.
> 
> Unless there is a way to reserve a set of TLB entries for a real-time
> task (or other mechanism to have 'virtual -> physical' conversion
> entirely in the CPU -- I mean, not involving the OS) + the working set
> of the rt task fits into this 'reserved' set --- 'TLB-miss' exception
> gonna happen.. e.g. every time after the RT relinquish a CPU and
> something else trashes the TLB tables.
> 
> e.g. on MIPS, the area used for kernel modules also requires
> virtual->physical translation.. so even a kernel-mode task (and
> actually, interrupt handlers inside the kernel modules) cause TLB-miss
> exceptions. Sure, it's not a case if it's linked against the kernel
> itself.
> 
> errr.. ok, to many words :-) does it sound like smth taking place
> here? A link to the MMU overview for ppc would be highly appreciated
> as well.

See the powerpc architecture book at:
http://www.ibm.com/developerworks/eserver/articles/archguide.html
It gives the generics. Also see the Book-E (~embedded cpus) 
architecture; they have different MMUs:
http://www-01.ibm.com/chips/techlib/techlib.nsf/techdocs/852569B20050FF778525699600682CC7
And then the model specific manuals (405, 440, 5xx, etc.), which should 
be available at the IBM/Freescale/AMCC sites.

-- Heikki Lindholm

