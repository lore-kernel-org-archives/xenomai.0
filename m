Message-ID: <473B492F.7020707@domain.hid>
Date: Wed, 14 Nov 2007 20:14:55 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4739E07B.1000608@domain.hid> <200711141056.06083.lepalom@domain.hid>
	<473AC972.8070209@domain.hid> <200711141221.47396.lepalom@domain.hid>
In-Reply-To: <200711141221.47396.lepalom@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [Xenomai-help] Xenomai v2.4-rc6
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
To: Leopold Palomo-Avellaneda <lepalom@domain.hid>
Cc: xenomai@xenomai.org, xenomai-core <xenomai@xenomai.org>

Leopold Palomo-Avellaneda wrote:
> A Dimecres 14 Novembre 2007, Philippe Gerum va escriure:
>> Leopold Palomo-Avellaneda wrote:
>>> A Dimarts 13 Novembre 2007, Philippe Gerum va escriure:
>>>> Here is the sixth candidate release for the v2.4.x branch.
>>> [....]
>>>
>>>> 	[i386, x86_64 => x86]
>>>>
>>>> 	* Merge i386 and x86_64 arch-dep support as x86.
>>>>  	* Update Adeos/i386 support for 2.6.20, 2.6.22 and 2.6.23.
>>> [...]
>>>
>>> this has break the creation of the debian packages. I can understand that
>>> conceptually they are the same arch (one with 32bits and another with 64
>>> and more extensions) in general _all_ the distros treat them as two
>>> different arch.
>> How long do you think this is going to be that way, with 2.6.24 actually
>> merging those supports at kernel level?
>>
>>  So this changes break things. I don't think that it's a good idea do it
>>
>>> in a release candidate, IMHO.
>> We discussed this issue and the reason for doing this change asap in
>> length on the mailing list two weeks ago or so. Please have a look at
>> the archive for more. You will also find some significant patches
>> already exploiting the new common tree in order to streamline the code,
>> and ease maintenance on our side. Few resources, large work, we have to
>> be efficient, and maintaining two closely related archs sharing bits in
>> separate code bases is pointless, and a loss of time for the project.
>>
> 
> Ok,
> 
> I'm not subscribing to xenomai-core, so I don't know if this have been 
> discussed on the list.
> 
> Yes, I didn't have done a search on the web/list about if this have been 
> discused, I just have pointed that you are working (with a few resources, 
> etc) to release a new version rc-6 and have done a change that break 
> our "lazy way" of install/ compile xenomai. I don't know if others things.
> 
> I'm sure that you have worked/thought that this is the best way to do the 
> things. Now I have read the thread about it and well, it's just a normal 
> discussions about to make a important change and the people comment. You as 
> project leader have an idea that you think that it's good for the project, 
> and you implement it. And other people saying, ok, if you want to do it, I 
> will try to help...
> 
> I can understand that my post have ..... I don't know the verb in english, in 
> catalan will be "tocar-te els collons" and in english something like "touch 
> your balls". That's not my intention, really.
>

That's ok. Asbestos underwear should be part of any maintainer's outfit
for that very reason.

> I also will try to help it and I will look the debian packages to solve 
> this ... ;-) and probably I'm one this strange people that if I use a open 
> source soft and I begin I use a release candidate to test it and try help.

Testing -rcS is actually what helps us the most, so I'm not going to
mumble about this, but rather thank you instead.

The actual issue I raised was more about putting things in the right
perspective. We always have to adapt to new kernel releases, and since
we also have to move forward in order to do a better job, distros may
also have to fix things on their side from time to time. This said, we
still try to avoid pointless changes because there is no benefit in
causing havoc downstream just for the "fun" of it (unless the maintainer
really has to get an appointment asap with his favorite shrink, that is).

In the x86* merge case, doing it after 2.4.0 final would have made the
maintenance of 2.4.x way more complex while working on 2.5.x in
parallel, since we would have had two rapidly diverging branches: one
old-fashioned with separate x86* trees, and another one with a merged
support being continuously streamlined. Moving patches both ways would
have been a real pain in the neck, without any upside for us. One has to
keep in mind that a Xenomai maintenance cycle is roughly one year long,
during which we commit to routinely issue bug fix releases, which is not
that bad when you compare to the average free software project.

 At
> least some kind of .. please could you run bla, or can you try bla ... but 
> I'm not statistically important because I'm not showed at google ;-)
> 

Well, Google says that "shrek" amounts for more than 27 millions
matches, but despite this fact, I'm not going to expect any
advice/comment for him regarding Xenomai. So, the best way to move
forward is that real people keep posting comments here, like you've just
done.

-- 
Philippe.

