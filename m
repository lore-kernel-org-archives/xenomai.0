From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <49D530C8.8050109@domain.hid>
References: <49D513D8.5020001@domain.hid>  <49D530C8.8050109@domain.hid>
Content-Type: text/plain
Date: Thu, 02 Apr 2009 23:45:00 +0200
Message-Id: <1238708700.6932.136.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] libnative: Avoid double-evaluation of
 rt_task_self()
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Thu, 2009-04-02 at 23:40 +0200, Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
> > [ can be pulled from git.xenomai.org/xenomai-jki.git queues/assorted ]
> > 
> > Keep the result of rt_task_self() in a local variable to avoid the
> > second invocation.
> 
> Maybe we could create a pure/const variant of rt_task_self() for use in
> task.c only which would avoid the double evaluatino ?
> 

Can't do const because of pthread_getspecific(), but pure attribute is t
hand, yes.

-- 
Philippe.



