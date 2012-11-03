Message-ID: <9d3ef55df641c8657ce09c6f6e023e4a.squirrel@www.xenomai.org>
In-Reply-To: <CAOiXNkBMKNbXOAThav8L9esyRMLBHPk7uFg5fRPhifR_Sg4rXA@mail.gmail.com>
References: <CAOiXNkCw3e4mK7XeNif2MM5Ub2__xK8UKxaPNRzzMQUbWdhYRg@mail.gmail.com>
	<ff881ad96344018ff2cbf9f8211d7603.squirrel@www.xenomai.org>
	<CAOiXNkBMKNbXOAThav8L9esyRMLBHPk7uFg5fRPhifR_Sg4rXA@mail.gmail.com>
Date: Sat, 3 Nov 2012 11:55:29 +0100
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
>> Another reason for -EPERM is if the application is not launched as root.
>> For using Xenomai as a non-root user, see:
>
> Thanks Gilles for the hint, but I was loggin in as root with ssh.

Ok, but there is no code in xenomai which accesses or relies on the console
could you try to run the latency test from the ssh console to see if you
get the same issue?

-- 
                    Gilles.


