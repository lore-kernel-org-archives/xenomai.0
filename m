MIME-Version: 1.0
Sender: had2006@gmail.com
In-Reply-To: <54F5CD4D.8080004@xenomai.org>
References: <CAKk99t1N5b0_iQerSxPyKmMTLC8PePTJCO9zzFLdkmt_mDiiVg@mail.gmail.com>
 <54F58A4C.7030006@xenomai.org>
 <CAKk99t3_g0ZODEe32KGAzfHckWC=-Gqr6CrFa5yRh-hLF5Ttow@mail.gmail.com>
 <54F5BE3F.4010008@xenomai.org> <54F5C020.8090102@xenomai.org>
 <CAKk99t14k19FhkgMm1FymkjaKWngMG3FQL8mkm6tBOdth4X7sQ@mail.gmail.com>
 <54F5CD4D.8080004@xenomai.org>
Date: Tue, 3 Mar 2015 15:40:28 +0000
Message-ID: <CAKk99t22fhrbc0GwURNJjdUfVfwmBvVyAWYYArVMgJfh4_JF+Q@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Xenomai/cobalt: low_init(): binding failed: Function
 not implemented error issued when trting to run latency app on xeno 3.x-rc3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

I did not set --prefix.
I assumed the default value will be applied: /usr/xenomai

After install the xenomai tree appears to be intalled on /usr/xenomai:

/usr/xenoami/bin        with latency, ...
/usr/xenoami/include  with al the API headers
/usr/xenoami/sbin      with rsysregd, ...

On 3 March 2015 at 15:03, Philippe Gerum <rpm@xenomai.org> wrote:

> On 03/03/2015 03:58 PM, Helder Daniel wrote:
> >
> >     No actually, you don't need that if sysregd still appears in
> >     $prefix/sbin as built.
> >
> >     Please send the output of "strace -f" on the latency executable.
> >
> > Ok. I tried putting sbin in the search path and gave the same error.
> >
> > I am running these test now on an installation of Mercury (already on an
> > AMD Sempron physical system).
> >
> > /usr/xenomai/bin/latency runs fine on this installation (the issue with
> > latency not running is with Cobalt installation)
> >
> > I think I have 2 different problems:
> >
> > 1) can not use Xenomai registry in Mercury and Cobalt.
> >
> > 2) actually I can not run anything at all in Cobalt installation
> > (possibly a bad patch)
> >
> > To test registry in Mercury I tried to run a simple app, that gives the
> > registry daemon error:
> >
> > ./hello
> >    3"002.332| WARNING: [main] cannot connect to registry daemon
> >    3"002.425| BUG: [main] initialization failed, EAGAIN
> >
>
> > [pid  4038] execve("NONE/sbin/sysregd", ["sysregd", "--daemon",
> > "--root", "/var/run/xenomai/anon"], [/* 18 vars */]) = -1 ENOENT (No
>
> That is the issue with the registry: the installation prefix is invalid.
> I suspect a wrong value passed to --prefix.
>
> --
> Philippe.
>



-- 
Helder Daniel
UALG - FCT
DEEI

http://w3.ualg.pt/~hdaniel
