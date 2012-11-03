Message-ID: <50958DD4.1000702@xenomai.org>
Date: Sat, 03 Nov 2012 22:34:12 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOiXNkCw3e4mK7XeNif2MM5Ub2__xK8UKxaPNRzzMQUbWdhYRg@mail.gmail.com>	<ff881ad96344018ff2cbf9f8211d7603.squirrel@www.xenomai.org>	<CAOiXNkBMKNbXOAThav8L9esyRMLBHPk7uFg5fRPhifR_Sg4rXA@mail.gmail.com>	<9d3ef55df641c8657ce09c6f6e023e4a.squirrel@www.xenomai.org>	<CAOiXNkA8u2TjB7FXoJh7opxasgCvnuFkuqOEPZ=tCMz-f-HMpQ@mail.gmail.com>	<2b4941d6b09c5560d4074bc644ded41d.squirrel@www.xenomai.org>	<CAOiXNkC=C6A=Mfhqx2rjg61D9UaOB55bnm-n5mOArsmpXdU-sg@mail.gmail.com>	<50958A57.8010902@xenomai.org>
	<CAOiXNkAQxitHg=uQRhL-+h1vNGRQh-3-JXaOz78NmvwdtqDTdA@mail.gmail.com>
In-Reply-To: <CAOiXNkAQxitHg=uQRhL-+h1vNGRQh-3-JXaOz78NmvwdtqDTdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 11/03/2012 10:32 PM, Andrey Nechypurenko wrote:

>> Use the DESTDIR environment variable (you can look inside xeno-config to
>> see how it works, it should be pretty obvious).
> 
> Thanks for the hint. I'll definitely try. However I doubt that it
> would solve the issue with rt_task_create() since I were actually
> copy-pasting the output from xeno-config and only change the -I and -L
> flags to reflect my directory structure.


Yes, I also doubt that very much. What about the arm/thumb issue?

-- 
                                                                Gilles.

