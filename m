MIME-Version: 1.0
Date: Mon, 29 Jun 2015 16:57:47 -0700
Message-ID: <CA+K1mPFgcxF5UAkMNXzit34sPHNWc+uzPTT45bngA6dd0wAyTw@mail.gmail.com>
From: C Smith <csmithquestions@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Unable to Read from Pipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

I am developing a set of applications which write to and read from a
rt_pipe. The writing app is in plain linux userspace, the reading app is a
periodic Xenomai task. I am using xenomai 2.6.3 on kernel 3.4.6 (32 bit).

The problem I have is that the Xenomai task gets this warning when it tries
to read the pipe:
"errno 11 -EWOULDBLOCK" and the bytes the userspace app sent never arrive
at the Xenomai task.

The Xenomai task creates the pipe this way:

ret = rt_pipe_create(&cmd_fifo_fd, "cmd_fifo", 0, 30);

The userspace app opens and writes to the pipe this way:

fd = open("/dev/rtp0", O_RDWR);
wr = write(fd, "Debug", sizeof("Debug"));

The Xenomai task becomes periodic like this:

 ret = rt_task_create(&main_task, "mytask", 0, 99, T_FPU | T_JOINABLE);
 ret = rt_task_start(&main_task, &Periodic_routine, NULL);

Each time the Xenomai periodic task 'wakes', it checks the pipe in a
non-blocking fashion (this is a requirement).
Here is most of the periodic code which reads the pipe:

void Periodic_routine(void *cookie) {
   RTIME next;
   rt_task_set_mode(0, T_WARNSW, NULL);
   next = rt_timer_read();
   while (1)   {
      next += 2000000000;
      retval = rt_task_sleep_until(next);
      retval = rt_pipe_read(&cmd_fifo_fd, msg, 6, TM_NONBLOCK);
   }
}

Yet the rt_pipe_read() above always returns errno 11 -EWOULDBLOCK and never
gets any bytes from the pipe, no matter how many times the periodic task
wakes up.

-CSmith
