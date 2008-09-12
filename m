Message-ID: <48CA90E8.2080909@domain.hid>
Date: Fri, 12 Sep 2008 17:55:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48CA7E5D.3080608@domain.hid> <48CA8941.5030005@domain.hid>
In-Reply-To: <48CA8941.5030005@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] __pse51_get_current_prio
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Hi Gilles,
>>
>> we've integrated your unit_mutex and our native test, but now we
>> stumbled over that __pse51_get_current_prio special syscall to check the
>> dynamic thread priority (during pi tests). I guess that service only
>> exists in your private patch queue? What are your plans about this in
>> case we want to push the mutex test into mainline? Or should we check
>> the thread prio indirectly (by waking up a lower-prio thread)?
> 
> I had plan to remove this from unit_mutex. OTOH, it may come in handy if
> we start breaking the xnsynchs...

Maybe one could invent some "pthread_inquire_np" so that the usefulness
of this extension increases beyond unit tests.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

