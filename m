MIME-Version: 1.0
In-Reply-To: <30092754-52b7-e4af-fff5-123737a5cc33@alaxarxa.net>
References: <abf31608-ffa8-17e0-e3eb-4d62f067e365@xenomai.org>
 <30092754-52b7-e4af-fff5-123737a5cc33@alaxarxa.net>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 22 Nov 2017 10:17:11 -0500
Message-ID: <CALLqZ8Qge+4w+vrJN2MwdQD-X1bJyA1mRehbsMA+=-up3-PM5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] [RFC] RTnet, Analogy and the elephant in the room
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

    I really like the idea of having some TODO files, this would given new
comers to the project a place to start.
Improving the documentation and adding a quick start guide might help get
more people interested in using
Xenomai.  With more users hopefully that would lead to more contributors
and not just more feature requests.

    To increase the presence of Xenomai would it make sense to have some
people focus on drivers and
maintenance for some popular community boards?  I personally focus on the
Xilinx Zynq platform,
but it might be useful to have people build and test images for  raspberry
pi boards, beaglebones and other
popular maker boards for every stable release of Xenomai.  I've posted my
steps on how to build Xenomai
for Zynq and will start to build and maintain pre-built binaries for Zynq
and run tests for the boards I have access to.
I find a lot of people that give me feedback on the Xenomai on Zynq seem to
just want to get started quickly
and go.  This really only addresses increasing Xenomai presence and would
increase the total work which
might not be what's desired right now.


On Wed, Nov 22, 2017 at 7:33 AM, Leopold Palomo-Avellaneda <leo@alaxarxa.net
> wrote:

> Hi,
>
> yes, it's true. We have an Elmer and his cousin Wilbur is rear the door.
>
> Let me remark some points of your great email:
>
> - about the I/O frameworks
>
> On 21/11/17 18:11, Philippe Gerum wrote:
> > The
> > situation has reached a point where I see no alternative to dropping
> > them if the situation does not improve, ...
>
> - about your rule in the project:
>
> > I have not been scaling to the Xenomai
> > maintenance, development and documentation tasks, with the requirement
> > of running my business in parallel.
>
> - about how to solve it:
>
> > The solution to this serious problem is fitting the project to the
> > available resources by narrowing its goal, or conversely, by growing the
> > pool of contributors.
>
> - about the presence of Xenomai in the world:
>
> > to my current knowledge,
> > Xenomai is present in a broad range of applications and systems:
> > magnetic resonance scanners, 2D/3D printers, navigation & positioning,
> > communication equipment, autonomous vehicles, control & automation
> > systems in various plants.
>
> - about where we came from:
>
> > On the sad side of the story, this project has virtually become a
> > one-man show the day Gilles - my long-time friend and hacking soul mate
> > - left us. That show is too big for me to run it alone ...
>
>
> And finally, if you let me talk about our Elmer.
>
> The I/O frameworks are IMHO are crucial. It has a very limited scenario to
> develop a RT system if it has no interaction with the external devices, or
> whatever. I have the hope ("A new hope" ;-)) that Siemens and Denx guys,
> continuing contributing to the project. Also, I have seen that new people
> have
> interest.
>
> But I would like to ask you directly Philippe some practical steps that
> could
> address to this challenge:
>
> - Would you be willing to move Xenomai to some platform like github, or
> similar?
> It will have some advantages like issues management, maintenance, (more
> visibility?), etc.
>
> - Would you be willing to delegate tasks of the project to other people,
> that
> maybe will not make it as good as you will do, like documentation, web
> site, or
> parts of code, but made then with an acceptable quality? And please, don't
> take
> bad, it's a difficult thing. I have to confess that for me, it's very
> difficult.
>
> - Would you be willing to guide new contributors and give them
> responsibilities
> of important parts of the code?
>
> - Would you be willing to have the role as coordinator and leader of the
> project
> changing from one man show to some more open project? will be it possible?
> I
> don't know if because license issues or whatever would let it...
>
> - Would you be willing to change the build system from autotools to another
> modern tool? (Ex CMake?) IMHO few people understand autotools and it's a
> barrier
> for the new contributors, at least in another opensource projects.
> However, I
> have to admit that the entry level in Xenomai is high, so, autotools
> should not
> be a problem.
>
> And yes, the lost of Gilles was a great blow, on a the personal level and
> for
> his contributions on the project.
>
> From my part, I can contribute if there's interest, in Debian (Ubuntu)
> packages.
> Also, in testing and trying to help in the RTnet part, as user that I'm.
> So, I
> could try to provide some preconfigured scenarios to the people that would
> like
> to entry in Xenomai.
>
> I have to admit that I'm a bit scared because we depend of Xenomai in some
> projects in my University. But, probably we could try to move to
> RT_PREMPT. But,
> because its history and my "affection" for the project I would prefer stay
> with
> it and try to help.
>
> Cheers,
>
> Leopold
>
> --
> --
> Linux User 152692     GPG: 05F4A7A949A2D9AA
> Catalonia
> -------------------------------------
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>
>
>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: signature.asc
> Type: application/pgp-signature
> Size: 833 bytes
> Desc: OpenPGP digital signature
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20171122/
> af6d7b02/attachment.sig>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
>
