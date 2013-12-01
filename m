From: Ryan Wilkins <ryan@deadfrog.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Message-Id: <D1DE22A7-3BD6-4D79-A85B-55A9D5CF2587@deadfrog.net>
Date: Sat, 30 Nov 2013 22:08:39 -0500
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: [Xenomai] Question about context switching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I=92ve been working with Xenomai 2.6.x on a Core 2 Quad (Q9000) CPU =
running at 2 GHz and it seems to be running fine so far.  The Linux OS =
is compiled with Buildroot for a project that I=92m working on for my =
employer.  Recently, I tried running my build on a new board with a Core =
i5 CPU at 3 GHz.  While it ran, I noticed while running xeno-test that =
the context switch test reported significantly less context switches on =
the Core i5 (~380K) than on the previous Core 2 Quad (~930K).  =
Otherwise, it seems to be running fine so far.  I would have expected =
the Core i5 to complete context switches even quicker, and to that end I =
don=92t even know that it=92s going to be a problem since not all the =
code is done yet.

Specifics on the current build.. Linux kernel 3.8.13.  Xenomai 2.6.3.  =
Buildroot 2013-08.1.  Compiled with 32-bit support only.

My question to anyone on the list is why such the difference in context =
switches?  Is there something obvious that I=92m missing here?

Thanks in advance for any help on figuring this one out.

Best,
Ryan Wilkins


