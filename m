From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: ipipe-x86: TRACE_IRQS_IRETQ on fast return
Message-ID: <1b988b50-db86-4073-9bac-cf6da94488bc@siemens.com>
Date: Fri, 28 Jun 2019 15:23:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Philippe,

when returning from an interrupt (not sure about exceptions yet) with root 
domain stalled, we take the fast paths, to kernel or to userspace:

https://gitlab.denx.de/Xenomai/ipipe-x86/commit/62957b1a3c5d36f32c6fdb33df00424fc5106c60#cfbf24a4bb0ddb98db8da0adf4b5c32cc18c6b34_570_573

Since the initial port to 4.14, both contain TRACE_IRQS_IRETQ on x86. This seem 
to have had no consequences on 4.14 so far (which still confuses me), but it is 
now exploding on 4.19 during boot (lockdep records locks to be held with 
interrupts off that should never by held like that, rq->lock e.g.). This made me 
wonder why interrupt state tracing was included in 4.14 like that. Can you 
recall which case you were addressing with this change?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

