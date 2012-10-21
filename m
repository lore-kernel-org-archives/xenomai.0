MIME-Version: 1.0
From: Soroush Rabiei <soroush.rabiei@gmail.com>
Date: Sun, 21 Oct 2012 20:59:26 +0330
Message-ID: <CAOMsk2RXfU-OuuRtkmjP484UWJGm2+TKWwfr2kJdN74e1_UmfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai]  After compile, how do I use Xenomai POSIX skin?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all

I working on a project aimed to control a mechanical system. One part of
controller software needs to be handled with a real-time system to satisfy
timing constraints.
I've compiled Xenomai 2.6.0 on kernel 2.6.38-8. Compilation was successful
and kernel logs show that the RT subsystem is active. Now I want to
re-write the critical thread of my application to use Xenomai subsystem
instead of kernel scheduling. The application runs in user space and has
5~8 POSIX threads which only on of them needs to be hard-RT.
How do I change my code to use Xenomai instead of NPTL? And how compile it?

Thanks
