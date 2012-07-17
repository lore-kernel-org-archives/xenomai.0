MIME-Version: 1.0
Date: Tue, 17 Jul 2012 13:56:29 +0430
Message-ID: <CAKKWdtfdsiPqa_eV8fbMM9oZmNmwdvOpRs+eSXE1LPLCy0eg+Q@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] question: rescheduling a blocked task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

If a real time task is blocked for some real time object, does Xenomai
guarantee the (re-)scheduling latency to be lower than a specific
number? Does the task enter the Linux domain when it is blocked?
or when it is blocked it may be in the blocked state for arbitrary time lengths?

