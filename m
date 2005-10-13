From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17230.8141.436906.810841@domain.hid>
Date: Thu, 13 Oct 2005 10:50:21 +0200
Subject: Re: [Xenomai-core] Future of fusion
In-Reply-To: <Pine.LNX.4.64.0510131033300.5110@domain.hid>
References: <000d01c5cfcb$8b5dfaf0$0600a8c0@domain.hid>
	<434E19AD.4030500@domain.hid>
	<Pine.LNX.4.64.0510131033300.5110@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Herman Bruyninckx <herman.bruyninckx@domain.hid>
Cc: xenomai@xenomai.org

Herman Bruyninckx wrote:
 > On Thu, 13 Oct 2005, Philippe Gerum wrote:
 > 
 > [...]
 > > - New skins: Any new colors for the "chameleon"?
 > "Perfect POSIX" is, to me, more important than new skins. "Perfect" means,
 > among other things, that the interference problem with the Posix thread
 > library (libraries) under Linux is solved.

What is wrong with the current implementation ? For me, the current
POSIX skin is close to final, in term of functionalities (on my todo
list, remain shared memories, implementation of mq_notify, and maybe
barriers, rwlocks and spinlocks, which are not a big deal). Of course,
some improvements are needed, such as a "process level" cleanup, which
would allow to reclaim automatically the memory used by anonymous
objects at the process death, or real-time signals, since for the
moments signals are handled in secondary mode, and an implementation of
message queues using shared memory, to avoid copies. But I assumed the
interference with the posix thread library was solved. Could you
elaborate a bit more on the issues you observed ?

-- 


					    Gilles Chanteperdrix.

