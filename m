MIME-Version: 1.0
Date: Wed, 22 Jan 2014 04:04:32 -0500
Message-ID: <CAKKWdtc7uTkGTX30oso0ciV4JisdTXSNL6YbWbmsnoD6C_r_Uw@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Computer froze by a loop
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Watchdog is enabled and if i put "while(1);" command at the begining
of task2, or any where in task1, after 4 seconds all the tasks are
killed. But in the example I have attached ( please look at the place
of "while(1);") computer froze! Not <ctrl-C> nor Linux scheduling
works!

I have two questions:

1) Why computer freezes in the cae? It seems a bug
2) When I put "while(1);" instruction in task1, then task1 is killed
by SIGXCPU and the CPU time exceeded, why task2 and the parent task
are all killed? I mean only one task should be killed not all of them!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: examp9.c
Type: text/x-csrc
Size: 1256 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140122/7dfb8e5=
8/attachment.c>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config1
Type: application/octet-stream
Size: 131428 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140122/7dfb8e5=
8/attachment.obj>
