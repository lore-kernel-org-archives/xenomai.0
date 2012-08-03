MIME-Version: 1.0
Date: Fri, 3 Aug 2012 16:23:07 +0800
Message-ID: <CAGVaUoE6O+Hi1DwCjfHZne0BD5R0z1ErobrP-CVtz2XgjtQKDg@mail.gmail.com>
From: Bao Rui <rbaocug@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Link error for the Xenomai 2.6.1 example
	"trivial-periodic.c"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi, I am trying to build Xenomai 2.6.1 for ubuntu 12.04 x86 version, after
patch the ipipe, build new kernel, everything is fine.

So I start build the Native example:
trivial-periodic.c<http://git.xenomai.org/?p=xenomai-head.git;a=blob;f=examples/native/trivial-periodic.c;h=d7d8945636d0f029fabca254d9373a3e5aac8551;hb=HEAD>


But I get following errors:
undefined reference to `rt_task_create'
......

I checked makefile, I do use the "-lnative", and everything is OK under
/usr/xenomai(I can run the cyclictest in the xenomai source code).

I see some one also meet such problem, but no solution for it, could anyone
can help me on this issue? It is very important to use Native skin.

Best Regards,
Henry
