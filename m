Message-Id: <0D490D90-107A-4341-8A92-9BCF1970DD08@gmail.com>
From: Andreas Glatz <andi.glatz@gmail.com>
In-Reply-To: <534B8FA4.9070102@xenomai.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date: Mon, 14 Apr 2014 16:55:40 +0100
References: <CAKJ14NdsfwK4Vj=UpYb6p9bvFE=1ZoQb6ss--9f-WqXOXGDn2g@mail.gmail.com>
 <534B8AA0.50203@xenomai.org> <FFE2622A-6519-4B2C-84B5-B0453F6A8850@gmail.com>
 <534B8FA4.9070102@xenomai.org>
Subject: Re: [Xenomai] Command line freeze during xeno-regression-test on
	omap4460
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 14 Apr 2014, at 08:35, Gilles Chanteperdrix wrote:

> On 04/14/2014 09:24 AM, Andreas Glatz wrote:
>>
>> On 14 Apr 2014, at 08:13, Gilles Chanteperdrix wrote:
>>
>>> On 01/06/2014 04:30 PM, Andreas Glatz wrote:
>>>> Hi,
>>>>
>>>> I managed to produce a kernel (v3.8.13) with xenomai 2.6.3 ipipe
>>>> patch and
>>>> rootfs (debian wheezy) with xenomai 2.6.3 libraries for my
>>>> Pandaboard ES
>>>> (omap4460). The simple regression test, which only calls dd during
>>>> the
>>>> switchtest, works fine. However the regression test with the linux
>>>> test
>>>> project (ltp-full-20130904) scripts causes some sort of system lock
>>>> up.
>>>> After that I only can ctrl-c xeno-regression-test (i.e.
>>>> switchtest), which,
>>>> however, doesn't help to regain console access (neigher over
>>>> ethernet nor
>>>> serial).
>>>
>>> Hi,
>>>
>>> I finally ran some tests with SD card: I booted my pandaboard using
>>> NFS
>>> as usual, but ran the xeno-test script passing the mount point of
>>> the SD
>>> card to dohell's -m option. And I could not reproduce any issue. The
>>> kernel I used is 3.14, the configuration is omap2plus_defconfig.
>>>
>>
>> OK, brilliant. I'll give that a try. I'm assuming that you tested  
>> with
>> the git tag 'raw/ipipe-3.14.0' ?
>
> It is a branch actually, but yes.
>

At the bottom of this Email is the result of the first LTP pass  
(started from dohell, started from xeno-regression-test). I never got  
so far with just the SD card in the panda (I ran exactly the same ltp  
test as before). LED2 is still constantly on, but the system remains  
responsive over wifi, ethernet and serial. Max latency is ~7us and  
worst latency is ~18us. Will post the final output ASAP.

I think from the results and the other reports on the mailing list I  
think I might be well off using this kernel as a base for our open- 
source/-hardware DAQ project.

Thanks a lot Gilles!

A.


mv_tests01                     PASS       0
size01                         PASS       0
sssd01                         PASS       0
sssd02                         PASS       0
sssd03                         PASS       0
smt_smp_enabled                PASS       0
smt_smp_affinity               PASS       0
ht_interrupt                   PASS       0
kmsg01                         PASS       0
fw_load                        FAIL       2

-----------------------------------------------
Total Tests: 1345
Total Failures: 51
Kernel Version: 3.14.0-ipipe-38801-g9b33fee-dirty
Machine Architecture: armv7l
Hostname: arm

root@arm:~#



