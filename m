MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18253.13326.22540.125750@domain.hid>
Date: Wed, 28 Nov 2007 10:25:34 +0100
In-Reply-To: <231e15c10711280045p3dd7ec1arf871b8d3395a7167@domain.hid>
References: <231e15c10711280045p3dd7ec1arf871b8d3395a7167@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] native pipe can not write
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?GB2312?B?xtbSwcfH?= <heyanandsu@domain.hid>
Cc: xenomai@xenomai.org

 wrote:
 > Hi,
 > I try to use the message pipe in native API, but I can not write to the
 > pipe. Can anyone help me to find what is wrong?
 > And in Linux side it says:"write failed: Cannot allocate memory"
 > Thank you!
 > Following is the program and return message.
 > #./test_pipe
 > create return: 0, write return: -12, read return: -110
 > 
 > #include <stdio.h>
 > #include <errno.h>
 > #include <native/task.h>
 > #include <sys/mman.h>
 > 
 > RT_PIPE pipe_desc;
 > RT_TASK task;
 > 
 > void op_pipe(void *arg)
 > {
 >         int  err, pipe_fd, wre, rre;
 >         char buf[16] = {'a', 'b', 'c'};
 >         char rd;
 > 
 >         err = rt_pipe_create(&pipe_desc, "my_testpipe2", 3, 128);
 >         char tmp[] = {"test pipe"};
 > 
 >         wre = rt_pipe_write(&pipe_desc, buf, 2, P_NORMAL);
 >         rre = rt_pipe_read(&pipe_desc, &rd, 2, 100);

I do not know if this is related with your issue, but the receive buff
is too small: you want write 2 bytes in a 1 byte buffer.


-- 


					    Gilles Chanteperdrix.

