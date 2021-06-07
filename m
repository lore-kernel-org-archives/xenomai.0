References: <0531d2db-aa87-1950-6d7f-41c80d4fe679@web.de>
 <875yyrf3yo.fsf@xenomai.org>
 <c6633047-7570-294f-e0b0-ab74f0c2a33e@siemens.com>
 <87a6o2b0to.fsf@xenomai.org>
 <50f40c7f-ae8d-7ded-9dc7-91310f0d7909@siemens.com>
 <874ke9bzde.fsf@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] irq_pipeline: Prevent returning to user space with
 pending inband IRQs
In-reply-to: <874ke9bzde.fsf@xenomai.org>
Date: Mon, 07 Jun 2021 15:28:20 +0200
Message-ID: <871r9dby8b.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>


Philippe Gerum <rpm@xenomai.org> writes:
>
> 2. This one should be replaced by a fix in local_irq_disable_full(),
> pending some tests ongoing here:
>
> irq_pipeline: Prevent returning to user space with pending inband IRQs
>

Tests went ok. So [1] should be replaced by a patch inverting the order
in local_irq_disable_full() as we discussed.

[1] irq_pipeline: Prevent returning to user space with pending inband IRQs


-- 
Philippe.

