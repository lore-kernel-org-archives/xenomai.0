Message-ID: <4F53B473.3040207@domain.hid>
Date: Sun, 04 Mar 2012 19:29:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20120229071500.159E93AF04F@mail3-245.sinamail.sina.com.cn>
	<4F4DEAF5.4050308@domain.hid> <201203040053.58176.arnout@domain.hid>
In-Reply-To: <201203040053.58176.arnout@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How can I use xenomai with the linux kernel of
 2.6.32 on the plarform of omap3530?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Arnout Vandecappelle <arnout@domain.hid>
Cc: xenomai@xenomai.org

On 03/04/2012 12:53 AM, Arnout Vandecappelle wrote:
> On Wednesday 29 February 2012 10:08:05 Gilles Chanteperdrix wrote:
>> On 02/29/2012 08:14 AM, xgdlrh@domain.hid wrote:
>>> Dear sir,      sorry to trouble u,but i have a problem i  can't
>>> solve.      Now i use an omap3530 Evaluation Boards and the linux
>>> kernel  which manufacturers provides is 2.6.32 . i have to use this
>>> kernel.when i try the step: $ scripts/prepare-kernel.sh
>>> --linux=<linux-srctree> [--adeos=<adeos-patch>]
>>> [--arch=<target-arch>],i can't find the adeos-patch which matches the
>>> kernel ,so I need ur help and how can i use xenomai with the linux
>>> kernel of 2.6.32 on the platform of omap3530? thanks for ur help.Best
>>> wishes to you!
>>> Sincerely yours, Liang Runhan
>>
>> You have two soilutions:
>> - either you adapt the patches for linux 2.6.31 or 2.6.33 to linux 2.6.32
>> - or you adapt a more recent linux kernel version for which an Adeos
>> patch exists to your board.
>>
>> If you know more linux than xenomai, the second solution is easier.
>> Besides 2.6.32 is seriously outdated now.
> 
>  OMAP3530 support is almost fully merged in the 3.0 mainline kernel, IIRC.
> I think only a few of the video accelerator drivers are missing.  So the
> mainline v3.0 (with the corresponding Adeos patches from gna.org) and see 
> how far you get.

OMAP3 support is available has ben mainline kernel for years in the
mainline kernel, I would say since at least 2.6.31. The problem is more
board support for the specific board this user wants, and drivers. But
as I said, adding this support if you have it for another kernel is
easier than adapting I-pipe support.

-- 
                                                                Gilles.

