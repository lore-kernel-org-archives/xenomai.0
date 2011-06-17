Message-ID: <4DFB88EC.9090100@domain.hid>
Date: Fri, 17 Jun 2011 19:03:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1QXaC2-0007dE-Ar@domain.hid> <4DFB869F.9080006@domain.hid>
In-Reply-To: <4DFB869F.9080006@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : nucleus: Fix
	interrupt handler tails
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 2011-06-17 18:53, Gilles Chanteperdrix wrote:
> On 06/17/2011 04:38 PM, GIT version control wrote:
>> Module: xenomai-jki
>> Branch: for-upstream
>> Commit: 7203b1a66ca0825d5bcda1c3abab9ca048177914
>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=7203b1a66ca0825d5bcda1c3abab9ca048177914
>>
>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>> Date:   Fri Jun 17 09:46:19 2011 +0200
>>
>> nucleus: Fix interrupt handler tails
>>
>> Our current interrupt handlers assume that they leave over the same task
>> and CPU they entered. But commit f6af9b831c broke this assumption:
>> xnpod_schedule invoked from the handler tail can now actually trigger a
>> domain migration, and that can also include a CPU migration. This causes
>> subtle corruptions as invalid xnstat_exectime_t objects may be restored
>> and - even worse - we may improperly flush XNHTICK of the old CPU,
>> leaving Linux timer-wise dead there (as happened to us).
>>
>> Fix this by moving XNHTICK replay and exectime accounting before the
>> scheduling point. Note that this introduces a tiny imprecision in the
>> accounting.
> 
> I am not sure I understand why moving the XNHTICK replay is needed: if
> we switch to secondary mode, the HTICK is handled by xnpod_schedule
> anyway, or am I missing something?

The replay can work on an invalid sched (after CPU migration in
secondary mode). We could reload the sched, but just moving the replay
is simpler.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

