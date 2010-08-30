Message-ID: <4C7B76A4.1030801@domain.hid>
Date: Mon, 30 Aug 2010 11:15:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4C7783C9.5090501@domain.hid> <4C7788A5.2020307@domain.hid>	
	<4C77B054.8080609@domain.hid> <4C77B208.5090802@domain.hid>	
	<4C77F142.4030103@domain.hid> <4C77F5EF.3010701@domain.hid>	
	<4C77F65E.5000208@domain.hid> <4C77FB05.4090301@domain.hid>	
	<4C77FD89.5040100@domain.hid> <4C77FF51.4000801@domain.hid>
	<1283013623.1709.226.camel@domain.hid>
	<4C7B70F9.1090903@domain.hid>
In-Reply-To: <4C7B70F9.1090903@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] False positive XENO_BUGON(NUCLEUS,
 need_resched == 0)?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> This makes sense. I'm currently testing the patch below which implements
>> a close variant of Gilles's proposal. Could you try it as well, to see
>> if things improve?
>> http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=3200660065146915976c193387bf0851be10d0cc
> 
> Will test ASAP.

Works fine here so far.

Jan

> 
>> The logic makes sure that we can keep calling xnsched_set_resched() then
>> xnpod_schedule() outside of the same critical section, which is
>> something we need. Otherwise this requirement would extend to
>> xnpod_suspend/resume_thread(), which is not acceptable.
> 
> I still wonder if things can't be even simpler. What is the purpose of
> xnsched_t::resched? I first thought it's just there to coalesce multiple
> remote reschedule requests, thus IPIs triggered by one CPU over
> successive wakeups etc. If that is true, why going through resched for
> local changes, why not setting XNRESCHED directly? And why not setting
> the remote XNRESCHED instead of remote's xnsched_t::resched?
> 
> Jan
> 

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

