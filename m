MIME-Version: 1.0
Date: Tue, 14 Jan 2014 13:35:52 +0100
Message-ID: <CA+6vZpS6Mw7rfvHnNBkB-9Jd9C-UUjRJ_hD6Ket_f__8F8iaLg@mail.gmail.com>
From: David <david35k@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] filter ipipe tracing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear,

I'm actually tracing my Xenomai drivers/syscalls thanks to the ipipe trace
facility. Actually, every "ipipe/xenomai/rtdm drivers" procedures are
traced. I give a try with 5000 points, I'm able to trace about 5ms of
execution. This is already a huge help for some problems but (a) it is too
short for my new needs. The performance impact of tracing appears big
(about x2 on performance ?), (b) it makes my application instable (100% of
CPU usage).

(a) Is it possible to trace about 1-10s of execution ? (any hint ?).
(b) Could we reduce performance impact for tracing ? I used FTRACE in the
past, it was possible to filter the events or procedure names traced but I
don't know how to proceed with ipipe tracing.

Regards.
