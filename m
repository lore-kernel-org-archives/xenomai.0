Message-ID: <2ff1a98a0803111127p7868350axa976c68714cf4f05@domain.hid>
Date: Tue, 11 Mar 2008 19:27:52 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47D6CD29.4020700@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47D6CD29.4020700@domain.hid>
Subject: Re: [Xenomai-help] What have I misunderstood about condition
	variables
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Tue, Mar 11, 2008 at 7:19 PM, Anders Blomdell
>  To me the symptoms indicate that the high priority producer gets the mutex and
>  signals it before the consumer has properly started to wait on the condition.

I have not read your program in detail, but what may be your problem
is that condition variables are not semaphores: if you signal a
condition variable when nobody is waiting the signal is lost. A
condition variable is supposed to be associated with a condition
relying on variable external to the condition variables itself.

The following posix construct waits that the variable a changes values to 1:

waiter:
pthread_mutex_lock(&mutex);
while (a != 1)
          pthread_cond_wait(&cond, &mutex);
pthread_mutex_unlock(&mutex);

signaler:
pthread_mutex_lock(&mutex);
a = 1;
pthread_cond_signal(&cond);
pthread_mutex_unlock(&mutex);

Note the while loop, instead of a simple if, it is necessary to handle
correctly spurious wakeups.

-- 
 Gilles Chanteperdrix

