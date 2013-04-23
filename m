Message-ID: <51767C66.9030103@siemens.com>
Date: Tue, 23 Apr 2013 14:19:50 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <517652E1.3090104@thrane.com>
In-Reply-To: <517652E1.3090104@thrane.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Lost interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jesper Christensen <jbc@thrane.com>
Cc: xenomai@xenomai.org

On 2013-04-23 11:22, Jesper Christensen wrote:
> Hi guys
> 
> I have a quick question regarding rtdm synchronisation. Is it possible
> to "loose" an interrupt if it is generated while i am inside a critical
> section protected by a rtdm_lock_get_irqsave/rtdm_lock_put_irqrestore?

Nope, as Gilles already answered.

> 
> I have a problem with an ethernet driver where the Tx Queue fills up and
> i suspect that its because the Tx ISR isn't being executed for the above
> mentioned reason.

Are we talking about a Linux NIC or a real-time device? What is your
software stack in general (used components and their versions)?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

