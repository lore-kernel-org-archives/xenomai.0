Message-ID: <4C72403E.4000507@domain.hid>
Date: Mon, 23 Aug 2010 11:32:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1OmSun-0000pX-9o@domain.hid> <4C6FA132.9030308@domain.hid>
	<4C6FA32A.40101@domain.hid>
In-Reply-To: <4C6FA32A.40101@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : native: Improve
 documentation of rt_task_join and rt_task_delete
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Am 21.08.2010 11:49, Gilles Chanteperdrix wrote:
>> GIT version control wrote:
>>> Module: xenomai-jki
>>> Branch: for-upstream
>>> Commit: df5646768a089b38343dfe676912006616bde5c2
>>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=df5646768a089b38343dfe676912006616bde5c2
>>>
>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>> Date:   Fri Aug 20 16:22:55 2010 +0200
>>>
>>> native: Improve documentation of rt_task_join and rt_task_delete
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>>
>>> ---
>>>
>>>  ksrc/skins/native/task.c |   15 +++++++++++++--
>>>  1 files changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/ksrc/skins/native/task.c b/ksrc/skins/native/task.c
>>> index 6d2472e..73fee5e 100644
>>> --- a/ksrc/skins/native/task.c
>>> +++ b/ksrc/skins/native/task.c
>>> @@ -588,6 +588,9 @@ int rt_task_resume(RT_TASK *task)
>>>   *
>>>   * Rescheduling: always if @a task is NULL, and possible if the
>>>   * deleted task is currently running into a safe section.
>>> + *
>>> + * @note A task that was successfully joined via rt_task_join() must not be
>>> + * explicitly deleted afterwards.
>>>   */
>> Should not we document the fact that a task which has been successfully
>> deleted must be joined (in the process where it is running)? I seem to
>> remember that being the subject of a discussion...
>>
> 
> We already do when describing T_JOINABLE, but we should indeed repeat
> this here as it may not be obvious. Will update the patch.

Update pushed, for-upstream head is now 95359c1.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

