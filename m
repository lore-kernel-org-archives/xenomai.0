Message-ID: <4BC859AC.1090206@domain.hid>
Date: Fri, 16 Apr 2010 14:35:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BC848F0.3090704@domain.hid> <4BC856E5.1050600@domain.hid>
	<4BC85785.6050807@domain.hid> <4BC858AC.8040905@domain.hid>
In-Reply-To: <4BC858AC.8040905@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [git pull] RTDM fixes and reworks
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> The following changes since commit 113ea4d56e8b215cb56ae7673013163ea5a5987d:
>>>>   Gilles Chanteperdrix (1):
>>>>         switchtest: increase stack sizes
>>>>
>>>> are available in the git repository at:
>>>>
>>>>   git://git.xenomai.org/xenomai-jki.git for-upstream
>>>>
>>>>
>>>> This is the first of likely three rounds of patches for 2.5.x. It mostly
>>>> deals with introducing rtdm_rt_capable to replace the
>>>> __xn_exec_conforming marks of RTDM syscalls and with deprecating RT
>>>> open/socket/close for RTDM devices. The latter affects quite a few
>>>> devices in our tree, so I'm CC'ing the maintainers to check if they see
>>>> any problems in dropping RT creation/closure at this point.
>>>>
>>>> Besides some smaller fixes and an irqbench refactoring, this series also
>>>> contains a solution for the confusions about incompatible rttest<n>
>>>> devices. It simply avoids collisions be using different device names for
>>>> the different device subclasses.
>>> switchtest already used another solution for that problem: the different
>>> devices use different ioctls. So, IMO we already had a solution for that
>>> issue.
>> Look at the diffstat of switchtest. I wanted to fix the issue for the
>> rest without replicating code.
> 
> I would agree with you for patches in xenomai-head. But in that case,
> this is an ABI breakage.

It's internal testing stuff.

If you think anyone out there may have written his own back- or
front-end, I could make all test devices additionally register under the
old rttest<n> as well. I just don't think it's worth the effort.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

