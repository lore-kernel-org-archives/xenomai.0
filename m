Date: Wed, 9 May 2007 15:35:16 +0200 (CEST)
From: Herman Bruyninckx <Herman.Bruyninckx@domain.hid>
In-Reply-To: <13086080.1178713660670.JavaMail.ngmail@domain.hid>
Message-ID: <Pine.LNX.4.64.0705091531560.22958@domain.hid>
References: <4641B5CF.80303@domain.hid>
	<22908039.1178707932628.JavaMail.ngmail@domain.hid>
	<13086080.1178713660670.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] Xenomai and futexes - Native API optimized for
Reply-To: Herman Bruyninckx <herman.bruyninckx@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

On Wed, 9 May 2007, M. Koehrer wrote:

[...]
> The critical region in the simulation are at locations when a lower prio
> thread and a higher prio thread access the same data. This happens at a
> couple of times within a simulation step (within that critical region
> there are typically some copy operations).

I agree with Jan Kiszka (in another reply in this thread) that it's
probably better to improve the design of your application than to shift the
problem to asking for "yet another feature" of the RTOS!

In our robot control framework (orocos.org) that works as a user space
application on top of Xenomai we have implemented lock-free data exchange,
which does'nt require involvement of the scheduler at all, and which
improves the timing performance of the highest priority thread. It might be
useful for you to discuss this implementation aspect on the orocos
developers mailinglist...

Herman Bruyninckx

--
   K.U.Leuven, Mechanical Eng.,  Mechatronics & Robotics Research Group
      <http://people.mech.kuleuven.be/~bruyninc> Tel: +32 16 322480
   Coordinator EURON (European Robotics Research Network)
      <http://www.euron.org>

Disclaimer: http://www.kuleuven.be/cwis/email_disclaimer.htm


