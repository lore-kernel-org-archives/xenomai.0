From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20110809174031.7B1346B2@domain.hid>
References: <20110809174031.7B1346B2@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 09 Aug 2011 18:03:55 +0200
Message-ID: <1312905835.2112.106.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_queue_bind() returns -EACCES
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Tue, 2011-08-09 at 17:40 +0200, Petr Cervenka wrote:
> Hello everyone.
> 
> I'm trying linux kernel 2.6.38.8 together with xenomai 2.5.6.
> My application tries to reuse already created rt_queue shared between couple of similiar applications.
> When I try to recreate already existing rt_queue by rt_queue_create i get -EEXIST error (as I expected).
> But if I try to bind it immediately with rt_queue_bind(&queue, QUEUE_NAME, TM_NONBLOCK) I get -EACCES error.
> This error code is not in documentation and with the previously used version (kernel 2.6.32.6, xenomai 2.4.10) it was working fine.
> Do you have any advice or suggestion?

-EACCESS is returned in case an attempt is made to use a binding service
which does not match the target object. E.g. using rt_queue_bind() for
binding an existing task.

> Thanks in advance.
> 
> Petr Cervenka
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



