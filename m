References: <CAOuPNLg60S+am654fq55vTMoFV1=PfMp3as5MZtt5BHUacFRBQ@mail.gmail.com>
 <CAOuPNLiCfmUrDMWyX=N37hVJTBDEqwOtoOr1srf-55ks1qms+w@mail.gmail.com>
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
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <dc502512-b467-3e27-ec14-91fa11a5b698@xenomai.org>
Date: Wed, 27 Jun 2018 20:10:22 +0200
MIME-Version: 1.0
In-Reply-To: <CAOuPNLhFtzOGFX-pJ63Y520c+TnQ7qRGtvg05e6F4JybdwFoaQ@mail.gmail.com>
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
To: Pintu Kumar <pintu.ping@gmail.com>, Greg Gallagher <greg@embeddedgreg.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/27/2018 07:29 PM, Pintu Kumar wrote:
> On Wed, Jun 27, 2018 at 10:47 PM Greg Gallagher <greg@embeddedgreg.com> wrote:
>>
>> I don't think Beaglebone is supported currently in RTNet.
>>
> 
> But I am just checking loopback interface with 127.0.0.1
> I hope that should work on all boards and arch, even without
> installing the net driver.
> 

You must be the first and only user giving any feedback about rtnet over
ARM if my memory serves me well. So either all others have been hiding
behind for all these years, or you may be the only specimen of that species.

FWIW, all of my rtnet fixes that went in since 3.0.6 have been tested on
x86 exclusively.

-- 
Philippe.

