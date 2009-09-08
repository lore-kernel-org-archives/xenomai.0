Message-ID: <4AA691B8.4090204@domain.hid>
Date: Tue, 08 Sep 2009 19:17:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <793108.19562.qm@domain.hid>
In-Reply-To: <793108.19562.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RT Task RPC over a POSIX/Native Queue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Guvenc Gulce <gulceg@domain.hid>
Cc: xenomai@xenomai.org

Guvenc Gulce wrote:
> Hi As far as I know an Xenomai RT Task can not call Linux API
> functions without leaving the Xenomai domain.
> 
> I was thinking about a generic library/framework which would allow an
> Xenomai RT Task call a Linux API function which would be then
> marshalled over a Posix/Native Queue to another Xenomai RT Task which
> then would do the dirty job of calling Linux functions. The responses
> and function return values from linux functions can be marshalled
> back to the original Xenomai RT-Task caller again over another
> Posix/Native Queue. In such a scenario the original caller RT Task
> would stay always in Xenomai domain.
> 
> I would like to hear whether such an approach sounds
> feasible/reasonable given the fact that currently Xenomai RT Tasks
> can not call Linux functions without leaving the Xenomai domain. Such
> a library/framework would be a solution to overcome that constraint.
> I would be glad to hear some opinions about this.

Leaving Xenomai domain is not bad per se. The reason why it is bad is
that when re-entering Linux domain, you may have to wait an unbounded
time for Linux to let your task run.

With your approach, the first RT task would not leave the Xenomai
domain, but it would wait for the second RT task to complete. And the
second RT task would risk to wait for the same unbounded time.

So, in short, you gain nothing.

-- 
                                          Gilles


