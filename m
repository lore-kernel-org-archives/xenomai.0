Date: Thu, 1 Apr 2010 19:08:43 -0400
Message-ID: <20100401230843.GF3755@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
From: Andreas Glatz <andreasglatz@domain.hid>
Subject: [Xenomai-help] New scheduler class
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org, xenomai@xenomai.org

Hi Philippe,

At the Xenomai Users Meeting last year I asked you if Xenomai would offer a possibility to lower the priority of certain Xenomai tasks below that of Linux. We need this feature since we have tasks in our RT application which should only run when Linux is idle (A statistics collection task which part of the RT application and hard to isolate from this application).

You suggested that in 2.5 you would introduce scheduling classes and by writing a special scheduling class we would be able to do that.

I took a look at the 2.5 source code and found 4 different scheduling classes but not a lot of documentation :)

Is there any documentation available?
What does sched_tp.c implement? Partition scheduling?

Best regards,

Andreas 

