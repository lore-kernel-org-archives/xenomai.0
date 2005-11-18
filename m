Message-ID: <437DE7FD.7050206@domain.hid>
Date: Fri, 18 Nov 2005 15:41:01 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] v2.1 status
References: <437CB8BA.8040902@domain.hid>
	<437DD08E.1020202@domain.hid>
In-Reply-To: <437DD08E.1020202@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> 
> 
> Question: On recent roadmaps I'm so far missing the topic "RT-signal
> support in userspace". Are there any concrete schedules (Qx 200y)?
>

Not currently, even if AFAIC, this is an interesting feature to have, so
that we don't always have to process async events over dedicated server
threads in user-space. But, I'm cowardly entirely leaving the core
design issues to Gilles regarding this; I need to keep focused on the
other pending stuff for now.

> I think to remember that you said Adeos would be involved in such an
> extension. Maybe it would be a good time to think about this also when
> we extend the Adeos API by shareable IRQs.
> 

Likely, yes.

-- 

Philippe.

