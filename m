MIME-Version: 1.0
Date: Tue, 22 Jan 2013 10:41:55 +0100
Message-ID: <CAPpP=rM-0xrf5N9iKVq2S+7wRrD4LoHxMTUxnxYb6aYbNP9nEA@mail.gmail.com>
From: alex alex <duch.alexandre@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] [Posix skin] program test with pthread_set_mode_np
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

In the attached test program I test the scheduler lock operation with
pthread_set_mode_np and the PTHREAD_LOCK_SCHED bit mask.

Description:
Two tasks are created.
t1 lock the scheduler then load the cpu, sleep then load the cpu again but
t2 task start when t1 sleep while the scheduler is locked. Why t1 is
preempted?

I run on Xenomai 2.6.2 with linux kernel 3.2.21.

Thanks in advance.

Alex
-------------- next part --------------
A non-text attachment was scrubbed...
Name: test-pthread_set_mode_np.bz
Type: application/octet-stream
Size: 1302 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130122/97ba44e=
9/attachment.obj>
