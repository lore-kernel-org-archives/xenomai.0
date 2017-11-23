References: <abf31608-ffa8-17e0-e3eb-4d62f067e365@xenomai.org>
 <30092754-52b7-e4af-fff5-123737a5cc33@alaxarxa.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <69a151ec-8088-e515-190b-305cbb3553a4@xenomai.org>
Date: Thu, 23 Nov 2017 12:01:15 +0100
MIME-Version: 1.0
In-Reply-To: <30092754-52b7-e4af-fff5-123737a5cc33@alaxarxa.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] RTnet, Analogy and the elephant in the room
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/22/2017 01:33 PM, Leopold Palomo-Avellaneda wrote:

[snip]

> 
> And finally, if you let me talk about our Elmer.
> 
> The I/O frameworks are IMHO are crucial. It has a very limited scenario to
> develop a RT system if it has no interaction with the external devices, or
> whatever. I have the hope ("A new hope" ;-)) that Siemens and Denx guys,
> continuing contributing to the project. Also, I have seen that new people have
> interest.
>

For the record, I'm definitely not suggesting to drop all I/O device
support from Xenomai, that would obviously make no sense. However, the
broken code must be fixed otherwise it serves no purpose but annoying
both users and maintainers.

> But I would like to ask you directly Philippe some practical steps that could
> address to this challenge:
> 
> - Would you be willing to move Xenomai to some platform like github, or similar?
> It will have some advantages like issues management, maintenance, (more
> visibility?), etc.
> 

Yes.

> - Would you be willing to delegate tasks of the project to other people,

Yes.

 that
> maybe will not make it as good as you will do, like documentation, web site, or
> parts of code, but made then with an acceptable quality?

Yes. This said, acceptable quality is a matter of taste and perception,
and the people involved in the merging process may have different views
on this. Fortunately for us, crap always solidly looks crap, which eases
the decision process when deciding what to do with it.

 And please, don't take
> bad, it's a difficult thing. I have to confess that for me, it's very difficult.
> > - Would you be willing to guide new contributors and give them
responsibilities
> of important parts of the code?
> 

Yes. However, we cannot expect anyone to decide for us what we could be
interested in contributing. What needs to be done can be put on the
table for discussion, people may add new ideas, but at the end of the
day, one is responsible for committing to a task.

> - Would you be willing to have the role as coordinator and leader of the project
> changing from one man show to some more open project? will be it possible? I

This is already the situation today, the real issue is that I'm
contributing most of the code, and have to carry out all of the other
tasks in the project, which ends up with nothing being done with the
required level of predictability and quality.

Even more importantly, most of the knowledge about how things work
internally all across the core system over all CPU architectures is
dangerously concentrated into a single person's brain. With a bus factor
of 1, well, Houston, we have a problem.

Information must flow, as a matter of fact, it does not, at the very
least not enough. This is clearly not a matter of unwillingness from my
end, but I tend to get lazy writing documentation about the internal
stuff when I'm not explicitly challenged to provide information by
people involved in the project.

> don't know if because license issues or whatever would let it...
>

The licensing scheme is very simple (fully abide by the kernel GPL
license for anything living in kernel space, use LGPL for libs in
userland) and did not change for the past 15 years, I'm not aware of any
issue so far.

> - Would you be willing to change the build system from autotools to another
> modern tool? (Ex CMake?) IMHO few people understand autotools and it's a barrier
> for the new contributors, at least in another opensource projects. However, I
> have to admit that the entry level in Xenomai is high, so, autotools should not
> be a problem.

I'm not excluding any change at this stage, which includes considering
other options in replacement of the autotools. This said, I don't think
the tool supporting build recipes can prevent anyone to contribute
software. In kernel space, Kbuild has to be followed and autotools are
not involved at all. In user-space, a recipe to build an exec or a
library is about 10 lines of a Makefile template, with many examples
around. And the mailing list has always been there for people to ask
specific questions about this.

> 
> And yes, the lost of Gilles was a great blow, on a the personal level and for
> his contributions on the project.
> 
>>From my part, I can contribute if there's interest, in Debian (Ubuntu) packages.
> Also, in testing and trying to help in the RTnet part, as user that I'm. So, I
> could try to provide some preconfigured scenarios to the people that would like
> to entry in Xenomai.
> 
> I have to admit that I'm a bit scared because we depend of Xenomai in some
> projects in my University. But, probably we could try to move to RT_PREMPT. But,
> because its history and my "affection" for the project I would prefer stay with
> it and try to help.
> 

Talking about the elephant in the room does not make it scarier, it has
always been there.

-- 
Philippe.

