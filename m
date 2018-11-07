Subject: Re: Kernel oops during rtnet loopback usage on x86_64 (e1000e)
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
 <9d89227b-fea0-be7c-7e50-c68dccf80053@xenomai.org>
 <c83d2fbd-086d-d6de-86cf-eaee4d041f02@siemens.com>
 <b2a5f99f-2157-5a87-3c9d-17d36460f312@xenomai.org>
 <89d73502-9f36-93c4-75f1-bdc9fe31ff0d@siemens.com>
 <b20480f3-4b8a-f1b3-baf0-841ccecaca9b@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4538b18d-9ccb-050f-3f34-8503d03dc1d2@siemens.com>
Date: Wed, 7 Nov 2018 12:19:28 +0100
MIME-Version: 1.0
In-Reply-To: <b20480f3-4b8a-f1b3-baf0-841ccecaca9b@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Pintu Kumar <pintu.ping@gmail.com>, Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 07.11.18 11:31, Philippe Gerum wrote:
> On 11/7/18 11:19 AM, Jan Kiszka wrote:
>> On 07.11.18 11:04, Philippe Gerum wrote:
>>> Would be nice. How would that cope with rt_ip_build_xmit_slow() in case
>>> the packet size exceeds the MTU? AFAICT, the header and payload data are
>>> sent over the wire on the fly as they are collected by the getfrag()
>>> callback.
>>
>> What exactly is the problem there? Sorry, this code structure is no longer in my
>> cache.
>>
> 
> The underlying question was: don't we need the checksum value early in
> the process of scanning all frags so that we can send it over the wire
> into the first packet as part of the header?
> 
> If so, the callback mechanism which collects one fragment then
> hard-xmits that data at each iteration does not seem to fit this
> requirement. Unless we are ok loading the payload twice: once for
> building the checksum, twice for sending the data the way it is done now.
> 

IIRC, there is no need to have a checksum over the whole data in the first
fragment, only a per-fragment (i.e. per-packet) checksum.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

