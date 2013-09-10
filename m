Message-ID: <522F696E.4090703@xenomai.org>
Date: Tue, 10 Sep 2013 20:48:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52138425.2030000@steinkuehler.net> <5213B7D3.5030606@xenomai.org>
	<5213C836.403@steinkuehler.net> <5213C9AD.2010903@xenomai.org>
	<5213D09E.80103@steinkuehler.net> <5214BDC1.30104@steinkuehler.net>
	<5215061E.6060305@xenomai.org> <521D053B.7010005@steinkuehler.net>
In-Reply-To: <521D053B.7010005@steinkuehler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] BeagleBone 3.8.13 pre/post patches
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

On 08/27/2013 09:59 PM, Charles Steinkuehler wrote:
> On 8/21/2013 1:25 PM, Gilles Chanteperdrix wrote:
>> On 08/21/2013 03:16 PM, Charles Steinkuehler wrote:
>>> [1] There was one hunk I could not get to apply automatically.  The code
>>> in gpmc.c has changed extensively enough that git apply doesn't work
>>> with this file.  To work around this, I skip this file when applying the
>>> ipipe patch, and use a manual fix-up of the trivial 2-line change:
>>>
>>> https://github.com/cdsteinkuehler/linux-dev/blob/am33x-v3.8-bone26-xenomai/patches/xenomai/0001-ipipe-core-3.8.13-arm-1.gpmc.patch
>>>
>>> There's probably a better way to work around this problem, but this
>>> should do until the next official xenomai release comes out...any day
>>> now, right?!?  :)  Anyway, it doesn't look like it will be that hard to
>>> roll forward with updated ipipe or xenomai patches.
>>
>> The general way to handle the non-mainline kernels is with a pre and
>> post patch. The pre patch removes the changes which conflicts, and the
>> post patch adds the merge.
> 
> I made a pre/post patch set for the BeagleBone 3.8.13 kernel and added
> the files to my xenomai 2.6 repository (patch attached).
> 
> Note that I just added the files...I didn't do anything to try and
> integrate these with the prepare_kernel.sh script (since I'm applying
> the ipipe patch from git manually) or add documentation.  With this, the
> patch generated from the current git ipipe-3.8 branch applies cleanly.
> 
> Anyway, the patch turned out to be quite simple and will hopefully roll
> forward fairly well.

Hi Charles,

The final version of the I-pipe patch for 3.8.13 is available, could you
check the patches you posted need rebasing?

Thanks in advance.
Regards.


-- 
                                                                Gilles.

