From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <307528.52616.qm@domain.hid>
References: <307528.52616.qm@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Jan 2010 14:42:49 +0100
Message-ID: <1262698969.2220.91.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] __ipipe_walk_pipeline()
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: A C <adrien_chiron@domain.hid>
Cc: adeos <adeos-main@gna.org>

On Tue, 2010-01-05 at 13:03 +0000, A C wrote:
> Hello,
> In  __ipipe_handle_irq, there is a call to the function
> __ipipe_walk_pipeline() "that plays interrupts pending in the log", is
> it really the execution of the treatement linked to an interruption ? 
> If yes, what happens when there is a new interruption ? In fact, we
> know that Hw interrupts are off on entry. So, if a new interruption
> for a more prioritary domain comes during the execution of
> __ipipe_walk_pipeline() for a less prioritary domain, how
> __ipipe_walk_pipeline() is preempted ?

Look for __ipipe_run_isr().

> Cheers
> Adrien Chiron & Vincent Vanbesien
> 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 
Philippe.



