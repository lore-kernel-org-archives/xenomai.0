Message-ID: <4C6FA32A.40101@domain.hid>
Date: Sat, 21 Aug 2010 11:58:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1OmSun-0000pX-9o@domain.hid> <4C6FA132.9030308@domain.hid>
In-Reply-To: <4C6FA132.9030308@domain.hid>
Content-Type: text/plain; charset=UTF-8
Sender: jan.kiszka@domain.hid
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : native: Improve
 documentation of	rt_task_join and rt_task_delete
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

Am 21.08.2010 11:49, Gilles Chanteperdrix wrote:
> GIT version control wrote:
>> Module: xenomai-jki
>> Branch: for-upstream
>> Commit: df5646768a089b38343dfe676912006616bde5c2
>> URL:    http://git.xenomai.org/?p=3Dxenomai-jki.git;a=3Dcommit;h=3Ddf5=
646768a089b38343dfe676912006616bde5c2
>>
>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>> Date:   Fri Aug 20 16:22:55 2010 +0200
>>
>> native: Improve documentation of rt_task_join and rt_task_delete
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>
>> ---
>>
>>  ksrc/skins/native/task.c |   15 +++++++++++++--
>>  1 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/ksrc/skins/native/task.c b/ksrc/skins/native/task.c
>> index 6d2472e..73fee5e 100644
>> --- a/ksrc/skins/native/task.c
>> +++ b/ksrc/skins/native/task.c
>> @@ -588,6 +588,9 @@ int rt_task_resume(RT_TASK *task)
>>   *
>>   * Rescheduling: always if @a task is NULL, and possible if the
>>   * deleted task is currently running into a safe section.
>> + *
>> + * @note A task that was successfully joined via rt_task_join() must =
not be
>> + * explicitly deleted afterwards.
>>   */
>=20
> Should not we document the fact that a task which has been successfully
> deleted must be joined (in the process where it is running)? I seem to
> remember that being the subject of a discussion...
>=20

We already do when describing T_JOINABLE, but we should indeed repeat
this here as it may not be obvious. Will update the patch.

Jan

