Subject: Re: [Xenomai-help] Problem with rt_queue
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <453FEA27.3020705@domain.hid>
References: <20061025143438.30247.qmail@domain.hid>
	<453FEA27.3020705@domain.hid>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 23:23:17 +0200
Message-Id: <1161984198.4983.49.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2006-10-26 at 00:50 +0200, Jan Kiszka wrote:

> Nevertheless, queue_sender by itself uncovered a problem of
> rt_queue_send in broadcast mode when no one is listening. The message
> reference count got messed up and the queue ran out of memory. The
> attached patch fixes it:
> 

Applied, thanks.

> Jan
-- 
Philippe.



