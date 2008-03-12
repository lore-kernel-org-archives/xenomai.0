Message-ID: <47D7E2B3.7020602@domain.hid>
Date: Wed, 12 Mar 2008 15:03:31 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <F1566C6D794188449A9EFA4E903560F3054BE9A0@domain.hid>
In-Reply-To: <F1566C6D794188449A9EFA4E903560F3054BE9A0@domain.hid>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] rt_queue name clash
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
To: Ruud Bos <Ruud.Bos@domain.hid>
Cc: xenomai@xenomai.org

Ruud Bos wrote:
> Hi all,
> 
>  
> 
> When I try to create a queue from user space and name it just like the
> executable, rt_queue_create always returns –EEXIST.
> 
> /proc/xenomai/registry shows that no queues with that name have been
> registered.
> 
>  
> 
> Is this a bug or intended behaviour?
>

Intended behaviour. There is a single namespace for objects, so if you probably
have a task of that name. Have a look at /proc/xenomai/registry/native/*.

>  
> 
> I’m using xenomai 2.4.2 on kernel 2.6.24.2 patched with ipipe
> 2.6.24-x86-2.0-03
> 
>  
> 
> Ruud
> 
> ------------------------------------------------------------------------
> 
> -- DISCLAIMER -- Fico B.V.
> 
> This e-mail is confidential and intended solely for the use of the
> individuals to whom
> it is addressed and may be protected by legal privilege. If you are not
> the intended
> recipient, be advised that you have received this e-mail in error and
> that any disclosure,
> use, dissemination, forwarding, printing or copying of this e-mail is
> strictly prohibited.
> Fico B.V. rules out any and every liability resulting from any
> electronic transmission.
> If you have received this e-mail in error, please notify;
> 
> Fico B.V. by telephone on +31 26 3196100.
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

