From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <B66DE711C138E84F96E6A2EDD078830B5F2A4D39CE@MAIL02.ug.kth.se>
References: <B66DE711C138E84F96E6A2EDD078830B5F2A4D39CE@MAIL02.ug.kth.se>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 18 Mar 2010 16:15:44 +0100
Message-ID: <1268925344.27899.372.camel@domain.hid>
Mime-Version: 1.0
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

On Thu, 2010-03-18 at 16:05 +0100, Huan Fang wrote:
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
> In my case, if one thread tries to lock same mutex twice, the assertion is thrown out as well. Could you please explain a bit how does Xenomai detect deadlock?
> Thanks.

#define XENO_ASSERT(subsystem,cond,action)  do { \
    if (unlikely(CONFIG_XENO_OPT_DEBUG_##subsystem > 0 && !(cond))) { \
        xnarch_trace_panic_freeze(); \
        xnlogerr("assertion failed at %s:%d (%s)\n", __FILE__, __LINE__,
(#cond)); \
        xnarch_trace_panic_dump(); \
        action; \
    } \
} while(0)

		XENO_ASSERT(RTDM, mutex_owner != curr_thread,
			    err = -EDEADLK; goto unlock_out;);

This means that RTDM mutexes do not allow recursion.

> 
> Regards,
> Huan
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



