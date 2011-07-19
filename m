From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <OF5F5F8716.FADBDF2A-ONC12578D2.0050F2D0-C12578D2.00525819@domain.hid>
References: <OF5F5F8716.FADBDF2A-ONC12578D2.0050F2D0-C12578D2.00525819@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Jul 2011 17:05:59 +0200
Message-ID: <1311087959.2154.532.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Scheduling policy
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolf.magnus@domain.hid
Cc: xenomai@xenomai.org

On Tue, 2011-07-19 at 16:59 +0200, rolf.magnus@domain.hid wrote:
> 
> Hi,
> 
> the xenomai documentation says that you can specify scheduling
> policies:
> 
> "The Xenomai scheduler ensures that concurrent tasks are run according
> to one of the supported scheduling policies. Currently, the Xenomai
> scheduler supports fixed priority-based FIFO and round-robin
> policies."
> 
> The documentation of the function rt_task_set_mode says:
> 
> "Each Xenomai task has a set of internal bits determining various
> operating conditions; the rt_task_set_mode() service allows to alter
> three of them, respectively controlling:
> 
> whether the task locks the rescheduling procedure,
> whether the task undergoes a round-robin scheduling,
> whether the task blocks the delivery of signals."
> 
> but there is no way to actually set the scheduling policy. In Xenomai
> 2.4, there was the flag T_RRB, but in 2.5, that has been removed from
> the documentation, and also from the interface. So how do you set the
> policy in 2.5?

rt_task_slice()

T_RRB was abusing the interface, since there was no way to specify the
time slice via rt_task_set_mode().

> 
> 
> Rolf Magnus
> 
> If you are not the intended addressee, please inform us immediately
> that you have received this e-mail in error, and delete it. We thank
> you for your cooperation. 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



