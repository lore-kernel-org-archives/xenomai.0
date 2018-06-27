References: <CAOuPNLg60S+am654fq55vTMoFV1=PfMp3as5MZtt5BHUacFRBQ@mail.gmail.com>
 <CAOuPNLiE-Fy3LJrozgsLE9ga0ibC+GOSHO6ciJppU_bnZtbx0g@mail.gmail.com>
 <73a5c9f6-5014-5113-1ddd-2fcf974273bb@siemens.com>
 <CAOuPNLjuB53ovnEBijNSqrgsKYcSGjLM-L=J4mfbRogwo_5kVA@mail.gmail.com>
 <CAOuPNLh2C8b1KC5D6+Lws_1UA0o0Sp_BaPb3mUTyebUPq_EduA@mail.gmail.com>
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
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <913ebdb1-f356-4171-a765-1ce7a0222bd5@xenomai.org>
Date: Wed, 27 Jun 2018 20:04:37 +0200
MIME-Version: 1.0
In-Reply-To: <b15f32c2-9bbc-c2f6-e65d-7331c0bc790a@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Pintu Kumar <pintu.ping@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/27/2018 06:17 PM, Jan Kiszka wrote:
> On 2018-06-27 16:12, Pintu Kumar wrote:
>>> With nosmap, that particular issue should no longer occur (at least as
>>> long as we can ask the kernel for this relaxation), so I suspect the
>>> other effect you see now is something else.
>>
>> Just for the information, that issue occurred even on Beagle bone, and
>> there is no smap on arm.
>> However, it works on virtual box. how ?
> 
> Does it work when you go back to Xenomai 3.0.6? Then it would be a
> regression of the copy-to/from-userspace improvements done after that
> release, you could start bisecting which commit introduced it.
> 
> But I'm not sure right now if there isn't something similar to smap
> (then just without a knob to turn it off) in the ARM architecture as well...
> 

AFAIR, use of protection domains is built in depending on a selection by
the CPU support code.

-- 
Philippe.

