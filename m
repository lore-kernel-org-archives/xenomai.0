Message-ID: <558F8E0A.8010306@zultron.com>
Date: Sun, 28 Jun 2015 01:02:50 -0500
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <C31C0BF8-AC9A-442B-8A2F-4576ACF1F817@gmail.com>
 <558EA07F.2060204@xenomai.org> <20150627131446.GF9756@hermes.click-hack.org>
 <CA2E5E80-204F-48D2-8FAF-1917CD257D90@gmail.com>
 <20150627133724.GG9756@hermes.click-hack.org>
In-Reply-To: <20150627133724.GG9756@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Q on xenomai2/3 userland coexistence
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <haberlerm@gmail.com>
Cc: xenomai <xenomai@xenomai.org>



On 06/27/2015 08:37 AM, Gilles Chanteperdrix wrote:
> On Sat, Jun 27, 2015 at 03:25:01PM +0200, Michael Haberler wrote:
>>
>>> Am 27.06.2015 um 15:14 schrieb Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>>>
>>> On Sat, Jun 27, 2015 at 03:09:19PM +0200, Philippe Gerum wrote:
>>>> On 06/27/2015 02:22 PM, Michael Haberler wrote:
>>>>> ATM we're sorting through the machinekit xenomai3 transition on debian
>>>>>
>>>>> I assume that users will continue to run xenomai2 kernels for a long time, so we work towards separate (but hopefully coexisting-in-peace) packages for Xenomai2 and Xenomai3 (startup is driven by kernel autodetection, so booting a different kernel chooses the right runtime)
>>>>>
>>>>> The libxenomai-dev and libxenomai1 in debian are all xenomai2 atm, but I assume Xenomai3 equivalents will appear eventually
>>>>>
>>>>> I hope these will be able to co-reside on the same host?
>>>>>
>>>>> Ideally suggesting the Xenomai3 packages would be separate, be named differently, and not supersede any installed Xenomai2 packages?
>>>>>
>>>>>
>>>>> (or am I blundering and I can run applications linked against the Xenomai3 libraries on a Xenomai2 kernel? my tests so far indicate - not)
>>>>>
>>>>
>>>> Not possible. Xenomai 2 uses kernel services provided by the I-pipe
>>>> compiled for legacy operation mode. Xenomai 3 wants this mode disabled.
>>>
>>> The two kernels have different ABIs anyway. I think what Michael
>>> wants to do is to also have the two patched kernels installed and
>>> reboot (or kexec?) to switch from one to the other.
>>
>> yes, it's a potential support issue, mostly for the folk installing from packages (I'm less concerned about those which install from source, and we can use configure.ac tests if something is obviously afoul)
>>
>> what I see unfolding is:
>>
>> - folks with a xeno2 package-based install want to try a xeno3 kernel, run apt-get upgrade etc, pull in kernel, and updated libraries
>> - something is not to their liking, and they step back to boot a xeno2 kernel - maybe just by changing the bootloader entry or by removing the xeno3 kernel
>> - if the first step has wiped the xeno2 userland support by upgrading, we have a support issue
>> - if xeno2 and xeno3 userland co-reside peacefully and separate, no issue
>>
>> doing everything through the xeno wrapper looks doable, but I guess backporting this wrapper to xeno2 will be unpopular
>>
>> what about completely separating the names, like /usr/xenomai3 ? sledgehammer approach (that is, in the best tradition of yankee engineering ;), but certainly effective.
>
> Obviously, the two installations should have different prefixes, but
> that does not solve the problem of helpers which should be found in
> the PATH, such as xeno and xeno-config.
>
> Anyway, I think this is a Debian-specific problem, so, I will let
> the Debian maintainer discuss of what would be the distribution best
> practices.

Yes, this is a packaging-specific problem, and it's the package repo 
maintainer's job to solve this for the repo's users.

My Machinekit distro, which includes Xenomai kernels and run-time 
packages, will only ever ship one version of Xenomai:  v.2 now, and v.3 
once the Machinekit migration is stable.

I do also ship a separate 'bleeding' repo with Xenomai-3 packages, 
potentially opening up space for confusion.  However, there are strong 
warnings [1], and those not scared off are expected to know how to revert.

So, I don't see the above support issue affecting regular users.  Of the 
handful of folks who'll help develop and test the Xeno-3 migration, if 
some small fraction needs hand-holding, I'm OK helping them.

As for two simultaneous copies, I agree with Gilles:  install Xenomai-3 
in non-standard location and use Machinekit's `./configure 
--with-xeno-config=[...]`.  One can still install both Xenomai 2 and 3 
kernel packages simultaneously, and it takes just a minute to compile 
Xenomai.

	John

[1]: 
http://www.dovetail-automata.com/articles/2015/05/30/jessie-bleeding-kernel-packages/

