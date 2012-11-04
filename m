MIME-Version: 1.0
In-Reply-To: <5096A058.30204@xenomai.org>
References: <CAOiXNkCw3e4mK7XeNif2MM5Ub2__xK8UKxaPNRzzMQUbWdhYRg@mail.gmail.com>
	<ff881ad96344018ff2cbf9f8211d7603.squirrel@www.xenomai.org>
	<CAOiXNkBMKNbXOAThav8L9esyRMLBHPk7uFg5fRPhifR_Sg4rXA@mail.gmail.com>
	<9d3ef55df641c8657ce09c6f6e023e4a.squirrel@www.xenomai.org>
	<CAOiXNkA8u2TjB7FXoJh7opxasgCvnuFkuqOEPZ=tCMz-f-HMpQ@mail.gmail.com>
	<2b4941d6b09c5560d4074bc644ded41d.squirrel@www.xenomai.org>
	<CAOiXNkC=C6A=Mfhqx2rjg61D9UaOB55bnm-n5mOArsmpXdU-sg@mail.gmail.com>
	<50958A57.8010902@xenomai.org>
	<CAOiXNkAQxitHg=uQRhL-+h1vNGRQh-3-JXaOz78NmvwdtqDTdA@mail.gmail.com>
	<50958DD4.1000702@xenomai.org>
	<CAOiXNkANO_1205mweCok_34Z_fQgLFRtg4w4xehNj3X+xOpfQw@mail.gmail.com>
	<50969840.5010705@xenomai.org>
	<CAOiXNkDY0aofK=woRrF8+Uh0LZVPjx8qVLB6DUVS+xhmKsyB3g@mail.gmail.com>
	<5096A058.30204@xenomai.org>
Date: Sun, 4 Nov 2012 18:34:03 +0100
Message-ID: <CAOiXNkBWwsrM09p7zL4v3FuMqrZvDAz=Fr1ULgs9DnWMuv7qCw@mail.gmail.com>
From: Andrey Nechypurenko <andreynech@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] rt_task_create fails when running over ssh
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> The result is the same with thumb code. In order to know if a binary is
> thumb or arm, run objdump and check if the binary contains 16 bits
> instructions.

Seams like there are no 16 bits instructions. I've also recompiled the
binary with -marm and it behaves in the same way. So the only thing
which allows the program to run from ssh console was the change in
systemd.config file I mentioned in my previous post.

I know very little about systemd configuration, so probably it is not
the best solution but it works for me.

--
Andrey.

