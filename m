Message-ID: <49D530C8.8050109@domain.hid>
Date: Thu, 02 Apr 2009 23:40:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49D513D8.5020001@domain.hid>
In-Reply-To: <49D513D8.5020001@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> [ can be pulled from git.xenomai.org/xenomai-jki.git queues/assorted ]
> 
> Keep the result of rt_task_self() in a local variable to avoid the
> second invocation.

Maybe we could create a pure/const variant of rt_task_self() for use in
task.c only which would avoid the double evaluatino ?

-- 
					    Gilles.

