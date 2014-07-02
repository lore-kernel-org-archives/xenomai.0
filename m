Message-ID: <53B44879.5020203@xenomai.org>
Date: Wed, 02 Jul 2014 19:59:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7016-53b1af80-3d5-7f54e300@12077259>
 <53B1B529.9040106@xenomai.org> <20140701083910.GA28764@dmia-degroote.isae.fr>
 <53B27E5B.10507@xenomai.org> <20140701155123.GA5547@dmia-degroote.isae.fr>
 <53B30A78.40605@xenomai.org> <20140702114142.GA13439@dmia-degroote.isae.fr>
In-Reply-To: <20140702114142.GA13439@dmia-degroote.isae.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Support of Beagleboard xm rev C on 3.14-ipipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Arnaud Degroote <arnaud.degroote@isae.fr>
Cc: xenomai@xenomai.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/02/2014 01:41 PM, Arnaud Degroote wrote:
> On 01/Jul - 21:22, Gilles Chanteperdrix wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> On 07/01/2014 05:51 PM, Arnaud Degroote wrote:
>>> On 01/Jul - 11:24, Gilles Chanteperdrix wrote:
>>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>>> 
>>>> On 07/01/2014 10:39 AM, Arnaud Degroote wrote:
>>>>> On 30/Jun - 21:06, Gilles Chanteperdrix wrote:
>>>>>> On 06/30/2014 08:41 PM, DEGROOTE Arnaud wrote:
>>>>>>> 
>>>>>>> On Monday, June 30, 2014 18:13 CEST, Gilles
>>>>>>> Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>>>>>> wrote:
>>>>>>> 
>>>>>>> On 06/30/2014 06:06 PM, Arnaud Degroote wrote:
>>>>>>>>>> On 30/Jun - 17:48, Gilles Chanteperdrix wrote:
>>>>>>>>>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>>>>>>>>>> 
>>>>>>>>>>> On 06/30/2014 05:45 PM, Arnaud Degroote wrote:
>>>>>>>>>>>> On 30/Jun - 17:26, Gilles Chanteperdrix
>>>>>>>>>>>> wrote:
>>>>>>>>>>>>> -----BEGIN PGP SIGNED MESSAGE----- Hash:
>>>>>>>>>>>>> SHA1
>>>>>>>>>>>>> 
>>>>>>>>>>>>> On 06/30/2014 05:18 PM, Arnaud Degroote
>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>> On 30/Jun - 14:37, Arnaud Degroote
>>>>>>>>>>>>>> wrote: [snip]
>>>>>>>>>>>>>>>> Have you checked that the exact same 
>>>>>>>>>>>>>>>> kernel configuration, only without 
>>>>>>>>>>>>>>>> CONFIG_IPIPE and CONFIG_XENOMAI runs 
>>>>>>>>>>>>>>>> correctly under load?
>>>>>>>>>>>>>>> 
>>>>>>>>>>>>>>> The system seems to hang even without 
>>>>>>>>>>>>>>> CONFIG_IPIPE. The linux-yocto kernel
>>>>>>>>>>>>>>> seems to work properly (it looks like a
>>>>>>>>>>>>>>> 3.14rc8), I will check precisely
>>>>>>>>>>>>>>> against linux kernel v3.14.
>>>>>>>>>>>>>> 
>>>>>>>>>>>>>> Some additional information
>>>>>>>>>>>>>> 
>>>>>>>>>>>>>> linux mainstream kernel on tag v3.14
>>>>>>>>>>>>>> runs fine on the platform. The system
>>>>>>>>>>>>>> hangs with ipipe branch ipipe-3.14
>>>>>>>>>>>>>> (without xenomai stuff, and without
>>>>>>>>>>>>>> CONFIG_IPIPE).
>>>>>>>>>>>>> 
>>>>>>>>>>>>> In the two cases the configuration is
>>>>>>>>>>>>> exactly the same?
>>>>>>>>>>>>> 
>>>>>>>>>>>> Yes, there are no semantic difference. The
>>>>>>>>>>>> only diff are
>>>>>>>>>>>> 
>>>>>>>>>>>> CONFIG_LOCALVERSION
>>>>>>>>>>>> 
>>>>>>>>>>>> and the ipipe kernel has the extra line
>>>>>>>>>>>> 
>>>>>>>>>>>> # CONFIG_IPIPE is not set
>>>>>>>>>>>> 
>>>>>>>>>>> If you have a rootfs without hardfp (based on
>>>>>>>>>>> the codesourcery toolchain for instance), could
>>>>>>>>>>> you try to boot without CONFIG_VFP?
>>>>>>>>>> 
>>>>>>>>>> I don't have such toolchain for the moment, but I
>>>>>>>>>> can try to hack
>>>>>>> 
>>>>>>>>>> my current yocto toolchain to test without
>>>>>>>>>> hardfp.
>>>>>>> 
>>>>>>> The codesourcery toolchain is available for download, 
>>>>>>> already compiled.
>>>>>>> 
>>>>>>>>>> Still, I have compiled a kernel without
>>>>>>>>>> CONFIG_VFP but it still hangs in the same place,
>>>>>>>>>> so I don't think it is related to the current
>>>>>>>>>> issue.
>>>>>>> 
>>>>>>> If you are running a rootfs with hardfp with a kernel 
>>>>>>> without CONFIG_VFP, the system should not finish
>>>>>>> booting.
>>>>>>> 
>>>>>>>> Yes obviously, but at the moment, I don't arrive to
>>>>>>>> the call to /sbin/init
>>>>>>> 
>>>>>>> Where does the system hang exactly? We were talking
>>>>>>> about a hang when running switchtest. How do you
>>>>>>> produce the hang on a system without CONFIG_XENOMAI,
>>>>>>> since obviously you can not run switchtest?
>>>>>>> 
>>>>>>>> Yes, sorry, I was not very precise.  I get the same 
>>>>>>>> behaviour than described in the beginning of the
>>>>>>>> thread, i.e. the kernel hangs during the boot (and
>>>>>>>> nothing happens after that). As I said previously,
>>>>>>>> the hang happens with linux-ipipe without
>>>>>>>> CONFIG_IPIPE. The various change of configuration
>>>>>>>> makes it "work" by accident.
>>>>>>> 
>>>>>>>> An hanging kernel boot msg is available on my mail of
>>>>>>>> 24 June, 14:21 CEST. I cannont reproduce it at the
>>>>>>>> moment, as I'm not anymore at work.
>>>>>> 
>>>>>> As I said in an earlier mail, please do not mix
>>>>>> everything, and try and debug one issue at the time.
>>>>>> 
>>>>>> From your configuration I gather you do not use the
>>>>>> serial console (CONFIG_PINCTRL_SINGLE is missing), could
>>>>>> you enable the serial console to try and obtain more
>>>>>> information about this kernel freeze?
>>>>> 
>>>>> I'm already using the serial console. PINCTRL_SINGLE is not
>>>>>  necessary for beagleboard xM AFAIU.
>>>> 
>>>> Finding a reproducible freeze location is relatively easy, 
>>>> enable CONFIG_DEBUG_LL, and put calls to printascii in the 
>>>> initialization functions, starting with init/main.c, and
>>>> refining inside these functions when you know a bit more.
>>> 
>>> Sorry, I get a bit busy today. So the hang seems to be:
>>> 
>>> - omap_hsmmc_probe - omap_hsmmc_reg_get - omap_hsmmc_set_power
>>> - omap_hsmmc1_after_set_reg - msleep(100) <- it never returns
>>> 
>>> I don't get time yet to go deeper in the call stack, but maybe
>>> it will already give you some input.
>>> 
>> So this would point to a (Linux) timer issue. Could you put a
>> call to printascii in the timer interrupt to check that it is
>> still ticking? Do you still have CONFIG_NO_HZ disabled?
>> 
> Hi Gilles,
> 
> the attached patch seems to make the platform "works" (i.e. it does
> not hang at boot, and switchtest works too). Through, to be frank,
> I don't have any idea what is the ramification of the change, and
> even if it supposed to be correct in the ipipe case.
> 
> I tested it also on my gumstix overo and I don't see regression in 
> xeno-regression-test.

Well, this sucks, posted writes increase the timer programming latency.

Does the latency test run correctly with this patch?

- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFTtEh5GpcgE6m/fboRAmo+AJ9vbiNx/IyfvCZP+Cxvy77J9habowCfWPp3
paWYuiMDOKabQikMrVuu3Gs=
=zXqr
-----END PGP SIGNATURE-----

