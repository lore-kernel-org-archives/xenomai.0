Subject: Re: [Xenomai-help] queue protection
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <75975c320608211311qb8e34dj42ef62c0e87a99a8@domain.hid>
References: <75975c320608211237m376b5f8w1293c606a2f3699c@domain.hid>
	<75975c320608211311qb8e34dj42ef62c0e87a99a8@domain.hid>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 22:16:56 +0200
Message-Id: <1156191416.4321.49.camel@domain.hid>
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
To: Paul Ianna <paulianna2002@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-08-21 at 16:11 -0400, Paul Ianna wrote:
> Hi All,
> 
> I think I know the answer but I wanted to hear from the expert(s) just
> to error on the side of caution.
> 
> (Speaking from a native API perspective) If I have a single rt_queue
> and several rt_tasks (of varying priority and/or periodicity,
> asynchronicity) that want to send to that queue, do I need to have
> explicit mutual exclusion protection on the queue for send operations,
> etc.?

No. The queue management services already handle serialization as
needed.

> 
> Thanks in advance,
> Paul Ianna
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



