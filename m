Message-ID: <ff881ad96344018ff2cbf9f8211d7603.squirrel@www.xenomai.org>
In-Reply-To: <CAOiXNkCw3e4mK7XeNif2MM5Ub2__xK8UKxaPNRzzMQUbWdhYRg@mail.gmail.com>
References: <CAOiXNkCw3e4mK7XeNif2MM5Ub2__xK8UKxaPNRzzMQUbWdhYRg@mail.gmail.com>
Date: Sat, 3 Nov 2012 02:20:13 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] rt_task_create fails when running over ssh
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andrey Nechypurenko <andreynech@googlemail.com>
Cc: xenomai@xenomai.org


Andrey Nechypurenko wrote:
> Hi Folks,
>
> I just hit the problem where my simple user-space application which
> uses rt_task_create() fails if started from the console session
> running over ssh. The error code returned by rt_task_create() is
> "-EPERM is returned if this service was called from an asynchronous
> context".
>
> Since I did not found further information in the documentation, I
> would really appreciate if someone can say some words (or point to the
> information source) why this function does not like if the program is
> running over ssh and how to solve this issue.

Another reason for -EPERM is if the application is not launched as root.
For using Xenomai as a non-root user, see:

http://www.xenomai.org/index.php/Non-root_RT

-- 
                    Gilles.


