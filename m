MIME-Version: 1.0
Date: Tue, 5 Feb 2013 18:47:17 +0530
Message-ID: <CAFv1zn7-zGPw71e4fFJAdf9FodKskesq1NRXooY4AOZ0Bojo5g@mail.gmail.com>
From: RAGHAVENDRA GANIGA <ravi23ganiga@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] PandaBoard related issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Sir i have compiled the linux 3.5.7 with xenomai 2.6.2.1 using
toolchain arm-none-linux-gnueabi from codesourcery and we were
testing the code which i have attached with the mail the non real
time tasks are working properly but the real time tasks are
giving some unexpected results like the code which i have attached
, in that when i execute the code the task gets registered in
/proc/xenomai/sched but there is no output from the tasks routine
like the first thing it should print is "in real time task" but
it is not printing, i have also attached the dmesg and the latency
test result from user space and kernel space.
Thanking you.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: dmesg1
Type: application/octet-stream
Size: 20628 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130205/2fff296=
c/attachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: susertest1.c
Type: text/x-csrc
Size: 777 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130205/2fff296=
c/attachment.c>
