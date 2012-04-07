MIME-Version: 1.0
Date: Sat, 7 Apr 2012 11:03:45 +0530
Message-ID: <CAM1yFZ9eQND3KX-1D1zL4TxcUTSFaw7k4Xd_nuN_6ByGRCRKYA@mail.gmail.com>
From: Anisha Kaul <born.rebel.83@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] Disadvantages of preempt_rt
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Greetings,

>From here: http://www.xenomai.org/index.php/Xenomai:Roadmap#Xenomai_3_FAQ

Quote:
>the target hardware platform has limited horsepower, and/or you want the real-time job to put the smallest possible overhead on your system. This is where dual kernels are usually better than a native preemption system.


Preempt_rt does preempt the whole Linux. In what way does preempting
Linux put load on the system?

The FAQ there talks about the preempt_rt as compared to Xenomai.
Please enlighten.

I read this: http://lwn.net/Articles/146861/ but they don't seem to be
talking about the "disadvantage" of preempt_rt.

-Anisha

