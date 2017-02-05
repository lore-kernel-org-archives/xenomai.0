MIME-Version: 1.0
From: Ran Shalit <ranshalit@gmail.com>
Date: Sun, 5 Feb 2017 15:49:22 +0200
Message-ID: <CAJ2oMh+gxphHKPqo8QcJqZ5yH0LfdoEyJOsiqoRVNm5mVzrZhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Switching between cobalt & mercury
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I am trying to evaluate  mercury and cobalt kernels from same version
of kernel source code.
I am using the documentation in
https://xenomai.org/installing-xenomai-3-x/
I am trying to see how simply it is to switch between the cores and
test each of them.
(without repeating the steps for each core using duplicated source folder)


1. I have applied the prepare-kernel script, can I now just add RT
PREEMPT in order to use mercury kernel , or must I also disable all
Xenomai configuration and build again ? Is it possible to use kernel
which support both RT PRREMPT and Xenomai ?

2. I also assume that I will also need to install the correct build of
the Xenomai library (there is a build for mercury and another one for
cobalt).

Best Regards,
Ran

