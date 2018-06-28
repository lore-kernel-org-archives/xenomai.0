References: <CAOuPNLg60S+am654fq55vTMoFV1=PfMp3as5MZtt5BHUacFRBQ@mail.gmail.com>
 <513744ad-f8fe-d54e-0618-fad492ed5bff@siemens.com>
 <5f46f00c-f09b-7439-93cf-4ff2a0343974@siemens.com>
 <6da8a3e2-7a76-afb2-c46c-7c173a8e444c@siemens.com>
 <CAOuPNLhYPGrP5s0y6e9HFUVrg2aDochOxF_fMkbjTmYnEvPOQQ@mail.gmail.com>
 <CAOuPNLjXN531P13WddSAQ-ZmnNOF_EQ4R+3eZ09VtG5zNvUH0g@mail.gmail.com>
 <aaa3a49e-ae7f-1696-199b-4ade86bd503f@siemens.com>
 <CAOuPNLi-p3A9LvkbpAVDapjN-dKgD8hJ3RJwJV+P=FvK2Pa7SA@mail.gmail.com>
 <8e8bd751-89b5-7006-a791-ae464838f5ed@siemens.com>
 <CAOuPNLh6ShYRG3E1Q+uad4phS3+QEtogzzu6RQpLz=N4qVQX1Q@mail.gmail.com>
 <b15f32c2-9bbc-c2f6-e65d-7331c0bc790a@siemens.com>
 <CAOuPNLiD8-WgbQYcZwzJPgp8XJXJFmzAxygEP9+ZsyCBQv--pA@mail.gmail.com>
 <CALLqZ8RxwJgP3ekWfJt-hGtxPY040p5rXW9DTGYDZfo=o8=3SA@mail.gmail.com>
 <CAOuPNLhFtzOGFX-pJ63Y520c+TnQ7qRGtvg05e6F4JybdwFoaQ@mail.gmail.com>
 <dc502512-b467-3e27-ec14-91fa11a5b698@xenomai.org>
 <CAOuPNLis5B--K5oxp11CWokos=P3UpFSGA3pNg3dNRTmQjdBAg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <857cec3a-df1b-c975-1a42-4fabda55c619@xenomai.org>
Date: Thu, 28 Jun 2018 15:07:29 +0200
MIME-Version: 1.0
In-Reply-To: <CAOuPNLis5B--K5oxp11CWokos=P3UpFSGA3pNg3dNRTmQjdBAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel oops during rtnet loopback usage on x86_64
 (e1000e)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/28/2018 12:40 PM, Pintu Kumar wrote:
>> FWIW, all of my rtnet fixes that went in since 3.0.6 have been tested on
>> x86 exclusively.
> 
> For us, even the xeno-test/net_udp fails on both x86/arm.
> I also verified the udp test (loopback) that exists on rtnet repo:
> https://git.code.sf.net/p/rtnet/code
> Under: examples/generic/
> 
> Then, I also developed a common rtnet udp server/client using posix skin.
> When I build and verify it on normal kernel it works fine.
> But when I build it with Xenomai posix skin, I get the kernel oops on
> both x86/arm.
> > Now it fails with xenomai-3/next (latest) and with Kernel 4.9, on x86.
> Earlier (1.5 months ago), I remember, rtnet loopback worked on x86_64
> with 3.0.6, with "nosmap".
>  If I run the same on Virtual Box Ubuntu 32-bit with same Kernel 4.9, it works.
> 
> So, I wonder, normally how do you verify rtnet sample application.

Sorry, I don't maintain rtnet.

> Please share the test applications and the steps you follow.
> 

Run the smokey test suite over real x86 hw and a real ethernet
interface, not the loopback. These were the tests conditions for the
changes addressing the smap issue.

I have no bandwidth to invest in rtnet at the moment, so you may want to
confront and debug the issue directly. I'm sure that any proposal for a
fix once the bug is spotted would be welcome, reviewed and commented on
this list.

-- 
Philippe.

