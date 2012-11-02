MIME-Version: 1.0
Date: Fri, 2 Nov 2012 21:24:42 +0100
Message-ID: <CAOiXNkCw3e4mK7XeNif2MM5Ub2__xK8UKxaPNRzzMQUbWdhYRg@mail.gmail.com>
From: Andrey Nechypurenko <andreynech@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] rt_task_create fails when running over ssh
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Folks,

I just hit the problem where my simple user-space application which
uses rt_task_create() fails if started from the console session
running over ssh. The error code returned by rt_task_create() is
"-EPERM is returned if this service was called from an asynchronous
context".

Since I did not found further information in the documentation, I
would really appreciate if someone can say some words (or point to the
information source) why this function does not like if the program is
running over ssh and how to solve this issue.

Thank you,
Andrey.

