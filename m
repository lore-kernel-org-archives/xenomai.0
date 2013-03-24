Message-ID: <1364092805.60885.YahooMailNeo@web161402.mail.bf1.yahoo.com>
Date: Sat, 23 Mar 2013 19:40:05 -0700 (PDT)
From: Tom Z <tomz30@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] native task status
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

Hi,=0A=0AI create a rt_task in user space program by rt_task_create(), and =
in a kernel module I use use rt_task_inquire to get rt_task_info of this ta=
sk during execution. I notice that rt_task_info:status of this task is 0x30=
0180 during its execution, and if I call rt_task_suspend on it, the status =
is 0x300181. So where is the task status value defined? I examined nucleus/=
thread.h, and it seems there are numbers like 0x300180 or 0x300181.=0A=0A=
=0AThanks,=0ATom=0A
