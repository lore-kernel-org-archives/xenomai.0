Message-ID: <b647ffbd0606280818l472911a9na1b7747aadf80a99@domain.hid>
Date: Wed, 28 Jun 2006 17:18:52 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [PATCH 6/6] Introduce IRQ latency benchmark
In-Reply-To: <44A29429.4060609@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060626172116.019532000@domain.hid> <20060626172120.322015000@domain.hid>
	<17570.29185.754625.871443@domain.hid>
	<44A275DE.5080500@domain.hid>
	<17570.34620.38518.404171@domain.hid>
	<b647ffbd0606280714q142553dag79cd39c4068992e8@domain.hid>
	<44A29429.4060609@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

> >
> > Then all other threads must block signal delivering with sigprocmask()
> > so that the main thread is the only one which "accepts" signals.
>
> Is that required, i.e. does pause() only wake up if the signal handler
> executed in the main thread's context? Then cyclictest contains a bug as
> well...

If strictly speaking, then yes, it's required. But I expect your fix
to be working perfectly, just because the current linux implementation
always favors the main thread when it comes to choosing a thread to
handle the signal.

look at signal.c :: __group_complete_signal() routine where the actual
magic happens.

from the comments

/*
         * Now find a thread we can wake up to take the signal off the queue.
         *
         * If the main thread wants the signal, it gets first crack.
         * Probably the least surprising to the average bear.
         */

...

As I understand, the only case when another thread may handle the
signal indeed is when the main thread has already another pending
signal. But even then nothing bad happens as pause() (in the main
thread) will be interrupted by this pending signal. Just "finished"
will be set up by some other thread but it doesn't really matter.


-- 
Best regards,
Dmitry Adamushko

