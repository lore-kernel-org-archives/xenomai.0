Message-ID: <4570AE1C.8050008@domain.hid>
Date: Fri, 01 Dec 2006 23:35:08 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [ANNOUNCE] Xenomai Example Repository
References: <457002EB.8080106@domain.hid> <45705C11.2010502@domain.hid>
	<457064F3.5050300@domain.hid>
In-Reply-To: <457064F3.5050300@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Jan Kiszka wrote:
>>> Hi,
>>>
>>> the new Xenomai example repository has been created. I don't want to
>>> repeat here what is explained already on the related wiki page, please
>>> have a look at
>>>
>>>     http://www.xenomai.org/index.php/Examples
>>>
>>> Instead, let me sketch what could be done next:
>>>
>>>  o Port existing examples, snippets, demos from ksrc/skins/* over, make
>>>    them compilable and runnable if required.
>>>
>>>  o Identify what kind of examples are lacking. You, the user, is needed
>>>    here. What do *you* think is missing, what would be helpful to show?
>>>
>>>  o Check what is needed to compile kernel-based examples over PPC 2.4.
>>>    Philippe indicated that some switches are likely missing (x86 is fine
>>>    already, other archs are 2.6-only).
>> Some time ago I sent a patch for RTnet using the "kernel CFLAGS
>> capturing" trick to get proper switches for 2.4:
>>
>> http://sourceforge.net/mailarchive/forum.php?thread_id=9493711&forum_id=24610
>>
>>
>> We could do the same trick here.
> 
> Yeah, I had a look at this before. The point is that I would prefer to
> keep things _simple_ and self-contained. This capturing requires some
> helper Makefile and complex call nestings that likely only people with
> advanced make and shell skills can understand and adopt to their projects.
> 
> But maybe things are that complicated already, and this is just
> different complexity. How do you compile simple out-of-tree modules
> against 2.4 PPC kernels? Are there any standard flags? Or is it
> different for each board or each compiler version or whatever?

I just cut and paste the flags from a kernel module make. For PPC, there 
are plenty of flags, not board but some are processor depended, but I'm 
unable to tell which one are really required. For this reason I like the 
module capturing trick.

Wolfgang.


