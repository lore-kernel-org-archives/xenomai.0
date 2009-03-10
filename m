MIME-Version: 1.0
Date: Mon, 9 Mar 2009 17:27:52 -0700
Message-ID: <67b6b3430903091727o4a60a28ay91c7ba35ad7d08ef@domain.hid>
From: Mark Saiia <mark.saiia@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] rt_queue_write return 1, with no receiver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello all,

Running Xenomai 2.4.7 w/ linux 2.6.27.19 on Geode GX1.

We are writing to a queue.  This write is returning a 1, and we
believe that there is no corresponding read pending.  Are the API docs
correct in regards to the return value of rt_queue_write?  Has anyone
seen anything related to this issue?

Thanks,

Mark

