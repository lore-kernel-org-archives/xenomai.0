MIME-Version: 1.0
Date: Wed, 23 Oct 2013 16:10:36 +0330
Message-ID: <CAKKWdtch=7=QoFz5QqmF+fLuFDtbQiMOcpjq3Hj0Ff+9baygyg@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] system freeze for xenomai-2.6.2.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

I have installed xenomai-2.6.2.1 under Fedora 13, kernel: 3.5.7, CPU:
Intel, core to quad, 2.4GHZ, machine: i686, 32 bits

I execute ./examp3, then ./examp4 and at last ./examp2. The computer
freezes and not responsive at the end.

Meanwhile when i played with the Native functions, "alarm"  and
"timer" and "task" services, sometimes i had kernel Ooops and panic
and the system froze. The crash dump showed, "xentask1" responsible.

Meanwhile when i delete an alarm object and then i inquire it
(rt_alarm_inquire) or want to start it (rt_alarm_start), the return
value is (-3), it is not -EINVAL, or -EIDRM!!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: examp2.c
Type: text/x-csrc
Size: 4432 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131023/52cb440=
5/attachment.c>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: examp3.c
Type: text/x-csrc
Size: 1169 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131023/52cb440=
5/attachment-0001.c>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: examp4.c
Type: text/x-csrc
Size: 783 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131023/52cb440=
5/attachment-0002.c>
