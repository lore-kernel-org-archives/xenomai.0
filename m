References: <fd32e328-0cde-b6db-bb32-3c572efa2ee4@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: dovetail-5.10: build-breakage on ARM
Date: Tue, 29 Mar 2022 11:13:08 +0200
In-reply-to: <fd32e328-0cde-b6db-bb32-3c572efa2ee4@siemens.com>
Message-ID: <87mth9qfyr.fsf@xenomai.org>
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


Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi Philippe,
>
> likely by accident: 5.10-dovetail-rebase lost disable_irq_if_pipelined /
> enable_irq_if_pipelined macros. 5.16 was affected as well, 5.15 and 5.17
> are not.
>
> Jan

Fixed upstream, thanks.

-- 
Philippe.

