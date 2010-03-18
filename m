Message-ID: <4BA243D6.5010404@domain.hid>
Date: Thu, 18 Mar 2010 16:16:38 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <B66DE711C138E84F96E6A2EDD078830B5F2A4D39CE@MAIL02.ug.kth.se>
In-Reply-To: <B66DE711C138E84F96E6A2EDD078830B5F2A4D39CE@MAIL02.ug.kth.se>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] deadlock for rtdm_mutex
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Huan Fang <huanf@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Huan Fang wrote:
> Hi,
> 
> Sometimes I got below assertion failed:
> 
> xenomai/skins/rtdm/drvlib.c:1544 (mutex_owner != curr_thread)
> 
> Looking into the code,
> /* Redefinition to clarify XENO_ASSERT output */
> 		#define mutex_owner xnsynch_owner(&mutex->synch_base)
> 		XENO_ASSERT(RTDM, mutex_owner != curr_thread,
> 			    err = -EDEADLK; goto unlock_out;);
> 
> Does it mean if the current owner of mutex is different from the requesting thread, then a -EDEADLK error is returned?(which is not documented in RTDM api doc)

If the mutex is contended, the owner _must_ be different from the
current thread.

> In my case, if one thread tries to lock same mutex twice, the assertion is thrown out as well. Could you please explain a bit how does Xenomai detect deadlock?

Quite simple: RTDM mutexes do not support recursion, so you must not
acquire them twice in the same thread. That's a reasonable
simplification of the design you find in the mainline kernel as well e.g.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

