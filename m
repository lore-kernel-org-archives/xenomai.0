Message-ID: <44FF3A22.5060901@domain.hid>
Date: Wed, 06 Sep 2006 16:14:10 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] max size for pipes and rt-fifos?
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

Here are a couple of questions that I hope someone can answer:

It appears that the maximum pipe size that can be created using rt_pipe_create() is 16 MB.  Is this correct?  If so, what is the cause of this limitation, and are there any work-arounds?  I am using a 128 MB FIFO in my rtlinux simulation.  Any ideas on how I can port this?

It appears that the maximum size for RT-FIFOs created with the rtai skin's rtf_create() is much less than 16 MB.  It's hard to quantify, since the errors are given at FIFO write time, and not creation time, but it appears to be around 100 kB or so.  Why is this not the same as for rt_pipe_create()?  Also, why is the memory allocation not done at creation time?  It looks like the memory allocation is done on the first rtf_put() -- which is called from my real-time thread!  I assumed the memory allocation would be a non-realtime operation.  (It also appears that I am getting some kind of memory leak when the memory allocation fails, because I can not allocate as much memory the next time around.  I am cleaning up the FIFO with rtf_destroy, so I don't know what I could be doing wrong...)

Thanks,

Jeff

