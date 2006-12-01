Message-ID: <4570B112.8010204@domain.hid>
Date: Fri, 01 Dec 2006 23:47:46 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: [Xenomai-core] [ANNOUNCE] Xenomai Example
	Repository
References: <457002EB.8080106@domain.hid> <45705C11.2010502@domain.hid>	
	<457064F3.5050300@domain.hid> <1164995694.4952.134.camel@domain.hid>
In-Reply-To: <1164995694.4952.134.camel@domain.hid>
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
To: rpm@xenomai.org
Cc: xenomai-help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Fri, 2006-12-01 at 18:22 +0100, Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>>> Jan Kiszka wrote:
>>>> Hi,
>>>>
>>>> the new Xenomai example repository has been created. I don't want to
>>>> repeat here what is explained already on the related wiki page, please
>>>> have a look at
>>>>
>>>>     http://www.xenomai.org/index.php/Examples
>>>>
>>>> Instead, let me sketch what could be done next:
>>>>
>>>>  o Port existing examples, snippets, demos from ksrc/skins/* over, make
>>>>    them compilable and runnable if required.
>>>>
>>>>  o Identify what kind of examples are lacking. You, the user, is needed
>>>>    here. What do *you* think is missing, what would be helpful to show?
>>>>
>>>>  o Check what is needed to compile kernel-based examples over PPC 2.4.
>>>>    Philippe indicated that some switches are likely missing (x86 is fine
>>>>    already, other archs are 2.6-only).
>>> Some time ago I sent a patch for RTnet using the "kernel CFLAGS
>>> capturing" trick to get proper switches for 2.4:
>>>
>>> http://sourceforge.net/mailarchive/forum.php?thread_id=9493711&forum_id=24610
>>>
>>>
>>> We could do the same trick here.
>> Yeah, I had a look at this before. The point is that I would prefer to
>> keep things _simple_ and self-contained. This capturing requires some
>> helper Makefile and complex call nestings that likely only people with
>> advanced make and shell skills can understand and adopt to their projects.
> 
> I tend to agree on the "keep it simple" mantra, but still, there are at
> least two other aspects which are quite important too:
> 
> - Nobody should expect to be able to develop a complete project only
> relying on paste-and-copy of example code. Since we are specifically
> talking about Makefile rules, we could not provide any set that would
> match everyone's project anyway, with respect to software and hardware
> requirements. Therefore, at some point, people really need to know what
> they are doing, which means that they should also know how to properly
> build out-of-tree modules with _their_ own 2.4 setup (well, if any
> "proper" solution exists, that is). And basically, I do hope that nobody
> starts implementing kernel modules without having - at least - a vague
> idea, about how to compile them for its platform in the first place...
> 
> - Given that there is life beyond x86, we need to make sure that all
> Xenomai ports are considered equal, at least with respect to generic
> issues. Whilst it's ok to provide a x86-only 2.4 Makefile for compiling
> a x86-centric example, it's not for anything which could demonstrate a
> feature on any platform.
> 
> This said, I agree that adding a fake module directory to capture the
> flags set by the main kernel Makefile is one step beyond ugliness; the
> other approach being to only provide a 2.6 Makefile frag. As 2007
> approaches, I think that anyone still involved with projects relying on
> 2.4 kernels do know how to build 2.4 modules for the targeted platform.

I think the example modules should compile on any platform and the 
"kernel CFLAGS capturing" trick is the most straight-forward way to do 
it for 2.4. It simplifies our life, avoids fiddling with various arch 
dependent flags in the Makefile, which will be even more ugly, and it 
serves as an example on how to get proper flags. Therefore I tend to add 
an appropriate script to the "scripts" subdirectory.

>> But maybe things are that complicated already, and this is just
>> different complexity. How do you compile simple out-of-tree modules
>> against 2.4 PPC kernels? Are there any standard flags? Or is it
>> different for each board or each compiler version or whatever?
>>
>> Jan
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help


