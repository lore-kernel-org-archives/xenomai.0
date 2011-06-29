Message-ID: <4E0AD384.4030004@domain.hid>
Date: Wed, 29 Jun 2011 09:25:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1QbfP2-0008Go-2L@xenomai.org> <4E0A47B6.2000008@domain.hid>
	<4E0ACEF7.9080902@domain.hid>
In-Reply-To: <4E0ACEF7.9080902@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Allow
 drop_u_mode syscall from any context
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 06/29/2011 09:06 AM, Jan Kiszka wrote:
> On 2011-06-28 23:29, Gilles Chanteperdrix wrote:
>> On 06/28/2011 11:01 PM, GIT version control wrote:
>>> Module: xenomai-jki
>>> Branch: for-upstream
>>> Commit: 5597470d84584846875e8a35309e6302c768addf
>>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=5597470d84584846875e8a35309e6302c768addf
>>>
>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>> Date:   Tue Jun 28 22:10:07 2011 +0200
>>>
>>> nucleus: Allow drop_u_mode syscall from any context
>>>
>>> xnshadow_sys_drop_u_mode already checks if the caller is a shadow. It
>>> does that without issuing a warning message if the check fails - in
>>> contrast to do_hisyscall_event. As user space may call this cleanup
>>> service even for non-shadow threads (e.g. after shadow creation failed),
>>> we better silence this warning.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>
>> Jan,
>>
>> I have a branch here, which allocates u_mode in the shared heap, so,
>> this syscall is about to become unnecessary.
>>
>> See:
>> http://git.xenomai.org/?p=xenomai-gch.git;a=shortlog;h=refs/heads/u_mode
> 
> Even better. When do you plan to merge all this? I'd like to finally fix
> the various MPS fastlock breakages, specifically as they overlap with
> other issues there.

I would like to give a chance to Philippe to have a look at it before it
is merged (especially the commit using an adeos ptd).

Normally, the MPS fastlock issues are solved in this branch.

-- 
                                                                Gilles.

