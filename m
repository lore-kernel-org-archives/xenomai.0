Message-ID: <4B96501F.3000701@domain.hid>
Date: Tue, 09 Mar 2010 14:41:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.4538.1268063562.8399.xenomai-git@xenomai.org>	<4B9527FD.3040806@domain.hid>	<4B952D13.3080306@domain.hid>	<4B952EFD.5020509@domain.hid>	<4B95308A.1000309@domain.hid>
	<4B953139.2050503@domain.hid> <4B953986.3030107@domain.hid>
In-Reply-To: <4B953986.3030107@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] common: do not let u_mode
 exceptional cases leak out of current.[ch]
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> So why this fallback? Does it simplify something else that I miss ATM?
>> After the TSD cleanup is run, the TSD are set to NULL. Actually, I
>> assumed that when doing this change. I need to check.
> 
> That is the way I implemented it in the kernel-space skin. But reading
> the spec again, I may have been overzealous:
> http://www.opengroup.org/onlinepubs/000095399/functions/pthread_key_create.html

>From the results of the following test case:

#include <stdio.h>
#include <pthread.h>

pthread_key_t key;
pthread_key_t other_key;

void dest(void *foo)
{
	if ((long)foo == 1) {
		printf("other tsd, self == 0x%016lx, first pass: %p\n",
		       pthread_self(), pthread_getspecific(other_key));
		pthread_setspecific(key, (void *)2L);
	} else
		printf("other tsd, self == 0x%016lx, second pass: %p\n",
		       pthread_self(), pthread_getspecific(other_key));
}

void *thread(void *cookie)
{
	pthread_setspecific(key, (void *)1L);
	pthread_setspecific(other_key, (void *)1L);
	return cookie;
}

int main(void)
{
	pthread_t tid;

	pthread_key_create(&key, dest);
	pthread_key_create(&other_key, NULL);

	pthread_create(&tid, NULL, thread, NULL);
	pthread_join(tid, NULL);
	
	return 0;
}

It appears that the glibc I run here is implemented the same way as I
implemented it in xenomai kernel-space posix skin.

So, we still have this issue.

-- 
					    Gilles.

