Message-ID: <4BB355EF.7070503@domain.hid>
Date: Wed, 31 Mar 2010 16:02:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4BB1C51F.4010106@domain.hid> <4BB1C5B7.7040400@domain.hid>
	<4BB1D0EB.30401@domain.hid> <4BB213AD.5020606@domain.hid>
	<4BB32F45.4010603@domain.hid>
In-Reply-To: <4BB32F45.4010603@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [git pull] RTDM: Fix potential NULL pointer
	dereference
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> The following changes since commit 6b3e8f2e5c69397814cb2f4029cdfbaff16e113e:
>>>>>   Gilles Chanteperdrix (1):
>>>>>         doc: regenerate
>>>>>
>>>>> are available in the git repository at:
>>>>>
>>>>>   git://git.xenomai.org/xenomai-jki.git for-upstream
>>>>>
>>>>> Unfortunately too late for 2.5.2, fortunately only relevant if something
>>>>> else went wrong in create_instance (ENOMEM or application error).
>>>>>
>>>>> Wolfgang Mauerer (1):
>>>>>       RTDM: Fix potential NULL pointer dereference
>>>>>
>>>>>  ksrc/skins/rtdm/core.c |    2 +-
>>>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>>>
>>>> Was not there any plan to remove this code and have a more "posix
>>>> compliant" close? I thought this had been merged?
>>> Yes. But that requires more work than it would have been appropriate for
>>> 2.5.2.
>> Ok, but could we have it for 2.5.3?
>>
> 
> Will see what I can do (no budget for this, so no promise).

The patches are floating around for some time (I was in CC of the mail
Philippe sent you about this some time ago), I guess some testing is
needed, this is why you need some time? Could we help with this testing?

> 
> Jan
> 


-- 
					    Gilles.

