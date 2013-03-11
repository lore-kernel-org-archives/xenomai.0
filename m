Message-ID: <1362975314.45141.YahooMailNeo@web161406.mail.bf1.yahoo.com>
Date: Sun, 10 Mar 2013 21:15:14 -0700 (PDT)
From: Tom Z <tomz30@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] how to install a "preemption hook"?
Reply-To: Tom Z <tomz30@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,=0A=0AI am using native APIs to do some development and have a question =
recently. I have a task A with a medium priority, so during A's execution, =
it could be preempted by higher-priority tasks or interrupts. What I want t=
o do is to install a hook so that whenever A is preempted, this hook is exe=
cuted immediately after A is preempted, but before the execution of the tas=
k that preempts A.=0A=0AHow can I accomplish this goal? Any ideas would be =
highly appreciated.=0A=0ATom
