From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mMjmnkjHUR"
Content-Transfer-Encoding: 7bit
Message-ID: <17636.25216.681949.487750@domain.hid>
Date: Thu, 17 Aug 2006 14:35:12 +0200
Subject: Re: [Xenomai-help] Debugging
In-Reply-To: <200608171405.44978.s.zimmermann@domain.hid>
References: <200608171405.44978.s.zimmermann@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: xenomai@xenomai.org


--mMjmnkjHUR
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Stephan Zimmermann wrote:
 > Hello List,
 > I am facing some trouble debugging my Xenomai application. When I set a 
 > breakpoint in my main() task, everything works fine. If I set a breakpoint in 
 > another task, the debugger won't stop the application. Is this a known 
 > problem, or am I doing something wrong (compiler/debugger options)? I tryed 
 > it within Eclipse and gdb commandline interface, both gave me the same 
 > results. Can someone give me a Hint?

I tested putting a breakpoint on the function "thread_routine" of the
attached program, and it works. Could you send us a minimal program
where this does not work ? 

Another detail: in order to correctly debug threaded programs, gdb needs
the libthread_db library, do you see the following line when starting
gdb:
Using host libthread_db library "/lib/libthread_db.so.1".

 > 
 > My System:
 > Debian 3.1 on AMD X2, running in 32bit mode
 > Xenomai 2.2 on Kernel 2.6.17.6, with no other patches
 > debian standard gcc 3.3.5
 > (same problem on intel notebook)
 > The program I'm working on is written in C++, wrapping classes around the 
 > native skin.

You may be reinventing the wheel, there is a xenomm projects which
provides a C++ interface to the native skin, see:
https://gna.org/projects/xenomm

-- 


					    Gilles Chanteperdrix.

--mMjmnkjHUR
Content-Type: text/plain
Content-Disposition: inline;
	filename="test_thread_bpt.c"
Content-Transfer-Encoding: 7bit

#include <pthread.h>
#include <semaphore.h>

void *thread_routine(void *cookie)
{
	sem_t *sem = (sem_t *) cookie;
	sem_wait(sem);
	return NULL;
}

int main(int argc, const char *argv[])
{
	pthread_t thread;
	sem_t sem;

	sem_init(&sem, 0, 0);
	pthread_create(&thread, NULL, &thread_routine, &sem);
	sem_post(&sem);

	pthread_join(thread, NULL);
	
	return 0;
}

--mMjmnkjHUR--

