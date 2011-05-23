Message-ID: <4DDABEAB.70804@domain.hid>
Date: Mon, 23 May 2011 22:08:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTimo07YLRZKw2faMv3r5MuBeG047zQ@mail.gmail.com>	<4DD55CEE.4030607@domain.hid>	<BANLkTim2KPKjhgSSAcyF4g1-CVFXFsCjTw@domain.hid>	<4DD6CFFA.50108@domain.hid>
	<BANLkTikVPXqV=PBBFS-fwAtDox8S0EPb3g@domain.hid>
In-Reply-To: <BANLkTikVPXqV=PBBFS-fwAtDox8S0EPb3g@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Regarding available stable versions for
	pandaboard
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: suresh reddy <sureshreddy.balijepalli@domain.hid>
Cc: xenomai@xenomai.org

On 05/21/2011 09:54 AM, suresh reddy wrote:
> On 20 May 2011 09:32, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org
>> wrote:
> 
>> On 05/20/2011 11:26 AM, suresh reddy wrote:
>>> On 05/19/2011 04:41 PM, suresh reddy wrote:
>>>> Hi all,
>>>>
>>>> iam running ubuntu 10.04 on my pandaboard  with the kernel
>>> 2.6.35-903-omap4.
>>>>
>>>> the latest linux kernel available is 2.6.38 and  the xenomai latest
>>>> version is v2.5.6. My question is is it compatible if i compile with the
>>>> available adeos patch for pandaboard?
>>>
>>> Yes. You may have to adjust include/asm-arm/hal.h, as explained in the
>>> arm porting guide though.
>>>
>>>
>>> Ok. So,the linux kernel 2.6.38 and xenomai latest version with two
>>> macros adding in
>>> include/asm-arm/hal.h will make it compile  for pandaboard  .
>>
>> No. You can not use linux kernel 2.6.38, you need to pick the ipipe tree
>> from the git I sent you a link in a previous mail.
>>
> 
>  yes i understanded that i have to take ipipe code from your previous mail
> and xenomai code of latest stable release but what i did not understanded is
> 
> linux kernel code .Do i need to download the linux kernel code from
> www.kernel.org  or its just enough to download the ipipe and xenomai to
> /usr/src/
> directory where omap4 linux kernel headers were there . And compile them .

Ok, nobody answered, so I am going to answer after all.

You question is frightening: it shows that since the time you are
talking about Xenomai and sending mails to this list, you did not take
the time to either try and install Xenomai on another platform than
panda (which I told you several times to do), or even read Xenomai
installation instruction.

The Adeos I-pipe patch is a patch for the Linux kernel, but in order to
generate that patch, we maintain in the I-pipe git repository the
patched kernel, and extract the patch from that repository. The link I
sent you is a link to that repository, not a link to the patch, you do
not need any kernel to apply it.

-- 
                                                                Gilles.

