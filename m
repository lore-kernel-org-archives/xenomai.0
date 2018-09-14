Date: Fri, 14 Sep 2018 02:45:28 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <285343492.3950889.1536911128629.JavaMail.zimbra@wolfram.com>
In-Reply-To: <4078e730-9293-12b4-e3c2-843f0de5f637@alaxarxa.net>
References: <a327adca-1576-0794-71cd-409b366dfdc8@alaxarxa.net>
 <28fd59c00f574c5a987ff73d72ffbc4c@andritz.com>
 <4078e730-9293-12b4-e3c2-843f0de5f637@alaxarxa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Order options to build a Xenomai program
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>


----- Den 13 sep 2018, p=C3=A5 kl 23:36, Leopold Palomo-Avellaneda leo@alax=
arxa.net skrev:

> Hi,

> El 13/09/18 a les 14:42, Lange Norbert ha escrit:

>> link order is important and goes left-to-right, this seems to include
> > "wrappers",
>> which only wrap symbols that where already encountered (to the left of t=
he
> > wrapper argument)

> [...]

>> The call to malloc is wrapped to __wrap_malloc and __real_malloc is wrap=
ped to
> > malloc,
> > since there is no object file yet, this does nothing.
>> libmodechk exports __wrap_malloc and __real_malloc, yet no one cares and
> > --as-needed
> > will remove it as dependency
> > The app objects depend on malloc.

> > I am not sure where your dependency to __real_malloc comes from, but I =
suppose
>> It's from the bootstrap code, which would be needed to be linked before =
the
> > wrapper.
> > Probably weak dependencies further complicate things.

> I think that you got the point!!

> So, from my point of view it confirm my suspicious that the wrapper
> mechanism is fragile. I really didn't understand why Xenomai core team
> changed the native API for the POSIX. Although I saw the Jan Kiska
> conference video explaining it, tell me primitive or dump, but I prefer
> to have a RT API that links against RT libraries and you can mix the
> POSIX functions that you want in a clear way.

> OTOH I have to admit that convert a POSIX program to RT in an easy way
> is amazing.


This!=20

Being able to use the same code, without patches or a lot of defines includ=
ing other files is a very clean way of debugging your software. I often set=
 up Simulations where I use my laptop running or our controller, possibly c=
onnected to remote hardware to debug stuff. For these cases  the POSIX skin=
 is very useful.

> > As noted by Henning, please look at https://github.com/nolange/cmake_xe=
nomai,
> > could use some feedback =3D).
> > Particularly look at the patchset which also removes some headaches wit=
h linking
> > precompiled object file for bootstrapping (but needs some upstream chan=
ges).

> Norbert, I have followed your emails and your project. You did a good
> job, but I don't agree with your approach. My points are:

> - You are trying to convert Xenomai a CMake project and this probably
> will not happen because Upstream is very happy with the autotools. I
> don't like to touch anything from upstream. Maybe some patch, but
> incorporated in Upstream.

What do you mean with "convert Xenomai a CMake project"? I feel that I am m=
issing something...

Is it simply that  the "xeno-config" way of doing things isn't cmak-onic en=
ough for a "real" CMake project or is there something deeper?

> - I would prefer follow the Upstream guidelines that recommends use
> xeno-config to obtain the needed parameters to build your application.
> So, any build tool should use xeno-config (maintained by upstream) that
> provide the correct flags or whatever to build your application.

> - I agree with Norbert that bootstraped code is not a good idea. But
> this change should be done by upstream. But if I'm not wrong, Phillipe
> said that it hasn't an easy solution.

> But for the curious, I have done this example:

> https://github.com/iocroblab/xenomai-cmake

> but it's not polished and had some mistakes. The idea is to use any
> Xenomai installation without touched and then use CMake to build your
> application.

> Cheers,

> Leopold

> --
> --
> Linux User 152692 GPG: 05F4A7A949A2D9AA
> Catalonia
> -------------------------------------
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?

> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

Thanks,
Per =C3=96berg=20

