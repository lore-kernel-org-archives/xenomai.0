Message-ID: <5215061E.6060305@xenomai.org>
Date: Wed, 21 Aug 2013 20:25:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52138425.2030000@steinkuehler.net> <5213B7D3.5030606@xenomai.org>
	<5213C836.403@steinkuehler.net> <5213C9AD.2010903@xenomai.org>
	<5213D09E.80103@steinkuehler.net> <5214BDC1.30104@steinkuehler.net>
In-Reply-To: <5214BDC1.30104@steinkuehler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Building BeagleBone kernel from git
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: xenomai@xenomai.org

On 08/21/2013 03:16 PM, Charles Steinkuehler wrote:
> On 8/20/2013 3:25 PM, Charles Steinkuehler wrote:
>> On 8/20/2013 2:55 PM, Gilles Chanteperdrix wrote:
>>> On 08/20/2013 09:49 PM, Charles Steinkuehler wrote:
>>>> Sorry if this is a total newbie question, but I see instructions
>>>> for using the prepare-kernel.sh script on a kernel directory, and 
>>>> instructions for using the ipipe kernel source directly, but not
>>>> how to get from one to the other.
>>>>
>>> You want the I-pipe patch. To generate it, in the I-pipe tree, try:
>>>
>>> ./scripts/ipipe/genpatches.sh
>>>
>>> You should then find a file ipipe-core-3.8.13-arm-1.patch which you
>>> can try and apply to another tree, possibly additionally patching with
>>> pre and post patches (respectively before and after the I-pipe patch).
>>
>> Yep, that sounds like exactly what I want!  Thanks for the help!!
>>
>> I'll report back if I run into more issues or if everything works out
>> OK.  I am trying to integrate the xenomai patches into a customized
>> version of Robert C. Nelson's BeagleBone kernel build scripts:
>>
>> https://github.com/cdsteinkuehler/linux-dev
> 
> Thanks again for the help!
> 
> I managed to get a working xenomai kernel from the automated builds.  I
> have only done light testing so far, but there didn't look to be any
> major issues with the process.
> 
> Additions to the "stock" RCN kernel build:
> 
> I pull the ipipe-3.8 branch from git and use it to generate an ipipe
> patch file
> 
> The ipipe patch is applied to a BeagleBone patched kernel tree [1]
> 
> I pull xenomai 2.6 (master) from git and run it's setup_kernel.sh on the
> ipipe patched source tree
> 
> ...build continues as usual.
> 
> More testing needs to be done, but it looks good so far!
> 
> [1] There was one hunk I could not get to apply automatically.  The code
> in gpmc.c has changed extensively enough that git apply doesn't work
> with this file.  To work around this, I skip this file when applying the
> ipipe patch, and use a manual fix-up of the trivial 2-line change:
> 
> https://github.com/cdsteinkuehler/linux-dev/blob/am33x-v3.8-bone26-xenomai/patches/xenomai/0001-ipipe-core-3.8.13-arm-1.gpmc.patch
> 
> There's probably a better way to work around this problem, but this
> should do until the next official xenomai release comes out...any day
> now, right?!?  :)  Anyway, it doesn't look like it will be that hard to
> roll forward with updated ipipe or xenomai patches.

The general way to handle the non-mainline kernels is with a pre and
post patch. The pre patch removes the changes which conflicts, and the
post patch adds the merge.

As for the release date of 2.6.3 it should happen soon, but now that the
I-pipe support for 3.10 is almost there, I am going to wait for it to
have been tested (but not fully validated) so that 2.6.3 will be ready
for 3.10.

> 
> Thanks again!!
> 


-- 
                                                                Gilles.

