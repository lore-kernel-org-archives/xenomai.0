References: <CAOuPNLg60S+am654fq55vTMoFV1=PfMp3as5MZtt5BHUacFRBQ@mail.gmail.com>
 <2ee8fa04-7ad4-58d5-603b-1d41ad2533ec@siemens.com>
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
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <aaa3a49e-ae7f-1696-199b-4ade86bd503f@siemens.com>
Date: Wed, 27 Jun 2018 12:20:37 +0200
MIME-Version: 1.0
In-Reply-To: <CAOuPNLjXN531P13WddSAQ-ZmnNOF_EQ4R+3eZ09VtG5zNvUH0g@mail.gmail.com>
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
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 2018-06-26 13:08, Pintu Kumar wrote:
> Dear Jan,
> 
> Till now I haven't had any success for running my rtnet demo test
> either or x86 or arm.
> I even upgraded to xenomai-next (both kernel and user space) but still no luck.
> 
> Now even the "loopback" test is not working on xenomai-next.

What means "now"? Did it work before? What was the setup then?

> 
> Can you confirm, if any of the below rtnet test works for you with
> Kernel 4.9 and xenomai-next.
> - xenomai-3-next/testsuite/smokey/net_udp
> - url = https://git.code.sf.net/p/rtnet/code  => examples/generic/
> - Or a simple UDP client/server program, compiled with xenomai posix skin
> 
> I already tried with "nosmap" but there are no response coming (I am
> getting no prints on console, but client is terminated).
> If there is any work around to make rtnet works, please let me know.
> 

I'm afraid there is currently a lack of bandwidth here to dive into the
details. Either you drill deeper, systematically, and report your
findings for discussions and suggestions on the list, or you need to be
patient until someone finds the time to reproduce and resolve the issue(s).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

