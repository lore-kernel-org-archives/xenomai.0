Message-ID: <53B1B529.9040106@xenomai.org>
Date: Mon, 30 Jun 2014 21:06:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <7016-53b1af80-3d5-7f54e300@12077259>
In-Reply-To: <7016-53b1af80-3d5-7f54e300@12077259>
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
To: DEGROOTE Arnaud <Arnaud.DEGROOTE@isae.fr>
Cc: xenomai@xenomai.org

On 06/30/2014 08:41 PM, DEGROOTE Arnaud wrote:
>  
> On Monday, June 30, 2014 18:13 CEST, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote: 
>  
> On 06/30/2014 06:06 PM, Arnaud Degroote wrote:
>>>> On 30/Jun - 17:48, Gilles Chanteperdrix wrote:
>>>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>>>>
>>>>> On 06/30/2014 05:45 PM, Arnaud Degroote wrote:
>>>>>> On 30/Jun - 17:26, Gilles Chanteperdrix wrote:
>>>>>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>>>>>>
>>>>>>> On 06/30/2014 05:18 PM, Arnaud Degroote wrote:
>>>>>>>> On 30/Jun - 14:37, Arnaud Degroote wrote: [snip]
>>>>>>>>>> Have you checked that the exact same kernel 
>>>>>>>>>> configuration, only without CONFIG_IPIPE and 
>>>>>>>>>> CONFIG_XENOMAI runs correctly under load?
>>>>>>>>>
>>>>>>>>> The system seems to hang even without CONFIG_IPIPE. The 
>>>>>>>>> linux-yocto kernel seems to work properly (it looks like 
>>>>>>>>> a 3.14rc8), I will check precisely against linux kernel 
>>>>>>>>> v3.14.
>>>>>>>>
>>>>>>>> Some additional information
>>>>>>>>
>>>>>>>> linux mainstream kernel on tag v3.14 runs fine on the 
>>>>>>>> platform. The system hangs with ipipe branch ipipe-3.14 
>>>>>>>> (without xenomai stuff, and without CONFIG_IPIPE).
>>>>>>>
>>>>>>> In the two cases the configuration is exactly the same?
>>>>>>>
>>>>>> Yes, there are no semantic difference. The only diff are
>>>>>>
>>>>>> CONFIG_LOCALVERSION
>>>>>>
>>>>>> and the ipipe kernel has the extra line
>>>>>>
>>>>>> # CONFIG_IPIPE is not set
>>>>>>
>>>>> If you have a rootfs without hardfp (based on the codesourcery 
>>>>> toolchain for instance), could you try to boot without 
>>>>> CONFIG_VFP?
>>>>
>>>> I don't have such toolchain for the moment, but I can try to hack 
> 
>>>> my current yocto toolchain to test without hardfp.
> 
> The codesourcery toolchain is available for download, already compiled.
> 
>>>> Still, I have compiled a kernel without CONFIG_VFP but it still
>>>> hangs in the same place, so I don't think it is related to the
>>>> current issue.
> 
> If you are running a rootfs with hardfp with a kernel without
> CONFIG_VFP, the system should not finish booting.
> 
>> Yes obviously, but at the moment, I don't arrive to the call to /sbin/init
> 
> Where does the system hang exactly? We were talking about a hang when
> running switchtest. How do you produce the hang on a system without
> CONFIG_XENOMAI, since obviously you can not run switchtest?
> 
>> Yes, sorry, I was not very precise.  I get the same behaviour than described in the 
>> beginning of the thread, i.e. the kernel hangs during the boot (and nothing happens after that). 
>> As I said previously, the hang happens with linux-ipipe without CONFIG_IPIPE. The various change
>> of configuration makes it "work" by accident.
> 
>> An hanging kernel boot msg is available on my mail of 24 June, 14:21 CEST. I cannont reproduce it at 
>> the moment, as I'm not anymore at work. 

As I said in an earlier mail, please do not mix everything, and try and
debug one issue at the time.

>From your configuration I gather you do not use the serial console
(CONFIG_PINCTRL_SINGLE is missing), could you enable the serial console
to try and obtain more information about this kernel freeze?

Or alternatively, could you restore the configuration options which "get
the system working", so that we can go back to what we were testing: the
configuration where switchtest hangs, without CONFIG_IPIPE, and generate
some load with the hackbench test, to try and simulate a bit what
switchtest is doing. I am also interested by the same configuration with
CONFIG_XENOMAI, but without CONFIG_VFP, and running the switchtest rtk0
rtk0 test.


-- 
                                                                Gilles.

