MIME-Version: 1.0
In-Reply-To: <4FF585C4.1000708@xenomai.org>
References: <CAL7_A_WEXhEBQr+LFb_mfaqLxBh=hsHJg6WiY08cmkgb=Y2TNA@mail.gmail.com>
	<4FF369E5.5040007@xenomai.org>
	<CAL7_A_WYVjFhh9RuxAm1jtVp7HqakB5gEzkSt8i7XsWJNJrh=Q@mail.gmail.com>
	<4FF402AD.3020601@xenomai.org> <4FF415AB.2030503@xenomai.org>
	<CAL7_A_Xr432pEEEiG4D5xsD-2yqWdgSd0tD26aEi4q0FzeWD_w@mail.gmail.com>
	<CAL7_A_XMD_KY9nryEyb3xzHpCb1PFYTG6qJupLWqRZhJXjkYRw@mail.gmail.com>
	<4FF44389.3030209@xenomai.org>
	<CAL7_A_WTJUeWNTTra2t9veiyWMxC5VtpotocMHGPdU1v7QAxKA@mail.gmail.com>
	<4FF44C52.6050809@xenomai.org>
	<CAL7_A_VUC8JD9yeMnLt2iJQ0ex_at3QMhiL3cQ5CHPFh0rcJRA@mail.gmail.com>
	<4FF585C4.1000708@xenomai.org>
Date: Mon, 19 Nov 2012 14:29:59 +0100
Message-ID: <CAL7_A_WZ=mQ9F_Od92qQKFS85QcOtOwqyXu+omrhOBgnZpJFNQ@mail.gmail.com>
From: =?ISO-8859-1?Q?Jens_K=F6hler?= <jenskxxx@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Xenomai and normal linux application - Wait time with
 select() not reliable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

Now is Xenomai 2.6 installed. But I have sometimes still delays in
user space applications.

Delay: 0.003064
Delay: 0.003066
Delay: 0.003504
Delay: 0.003066
Delay: 0.003066
Delay: 0.003066
Delay: 0.003090
Delay: 0.003064
Delay: 0.003066
Delay: 0.003067
Delay: 0.053807 <- 53 ms instead 3ms
Delay: 0.003067
Delay: 0.003067

I found out that problem depends from a real time queue between two
Xenomai tasks.

retval = rt_queue_create(&RtMeasureData, "RtMeasureData", 1000 * 256,
Q_UNLIMITED, Q_FIFO | Q_SHARED);

A real time task writes measurement data every 2 ms to a rt_queue.
retval = rt_queue_write(&RtMeasureData, &FifoMeasureData, 256, Q_NORMAL);

Another Xenomai task reads all measured data from queue and makes them
available for user land applications. (Task is not real time, context
switches)

retval = rt_queue_read(&RtMeasureData, &FifoMeasureData, 256, TM_NONBLOCK);

When nothing is written to queue is there also never an unexpected delay.

Any ideas or recommendations to find reason for problem?

Jens

