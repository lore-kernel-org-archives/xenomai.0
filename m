From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <OFCD74EB74.DD79A30F-ONC12572D6.00260A10@domain.hid>
References: <OFCD74EB74.DD79A30F-ONC12572D6.00260A10@domain.hid>
Content-Type: text/plain
Date: Wed, 09 May 2007 09:55:15 +0200
Message-Id: <1178697316.5004.8.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Antwort: Re:  Arguments in psos t_start()
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Markus Osterried <Markus.Osterried@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-05-09 at 09:07 +0200, Markus Osterried wrote:
> Hello Gerum,
> 
> sorry for not knowing the details. But there is another question.
> Is it okay to move the pointer to the arguments to the newly created task?
> Isn't it possible that the task which created the new task is rescheduled?
> The old task could change the value of the argument and because the new
> task only holds a reference to this argument, the new task is also
> affected.
> 

Yes, such side-effect would be possible, not necessarily for the
creator, but for the thread calling t_start() though. The worst case
would happen when calling t_start() with args laid into the caller's
stack space, and the caller unwinding the current frame immediately
since it has a higher priority than the started thread.

This boils down to one question: does actually pSOS pass the argument
array by reference, or by value? In the latter case, the current
implementation would be wrong, otherwise, the side-effect would be
admitted.

-- 
Philippe.



