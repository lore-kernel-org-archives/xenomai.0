Message-ID: <1366989762.33394.YahooMailNeo@web161406.mail.bf1.yahoo.com>
Date: Fri, 26 Apr 2013 08:22:42 -0700 (PDT)
From: Tom Z <tomz30@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] task status in Xenomai
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

Hi All,=0A=0ACan someone please tell me where I can find the documentation =
regarding the =0Atask status transition (is there a state machine describin=
g that)? Also, how the status values are defined? By reading rt_task_info::=
status during program execution, I can get some values. For example, while =
a task is running, I got a decimal of 3146112 for the task's rt_task_info::=
status. It seems this value is OR'ed with some macros, but what values are =
used to produce this status value? Where are they defined?=0A=0A=0AThanks,=
=0ATom=0A
