Message-ID: <55368E4F.4040101@siemens.com>
Date: Tue, 21 Apr 2015 19:52:15 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <E1Yka0Q-00008c-Jh@sd-51317.xenomai.org>
 <20150421152715.GV7109@hermes.click-hack.org> <5536751A.6080609@siemens.com>
 <20150421160625.GX7109@hermes.click-hack.org> <553676DF.8020607@siemens.com>
 <20150421161623.GY7109@hermes.click-hack.org> <553678CC.5020206@siemens.com>
 <20150421163247.GZ7109@hermes.click-hack.org> <55367CB0.90609@siemens.com>
In-Reply-To: <55367CB0.90609@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : lib/cobalt: Rework minimum
 stack size enforcement
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 2015-04-21 18:37, Jan Kiszka wrote:
> Possibly the crash was limited to the case where the application set a
> stack address and Xenomai messed up the size. I'm rechecking this right
> now, and if we are lucky, PTHREAD_STACK_MIN turns out to be fine for
> Xenomai as well.

Too bad, it wasn't that easy. Just try this, even without Xenomai:

#include <stdio.h>
#include <pthread.h>
#include <limits.h>

void *thread_func(void *arg)
{
	fprintf(stderr, "crash %s\n", "me");
	return NULL;
}

int main(int argc, char *argv[])
{
	pthread_t thread;
	pthread_attr_t attr;

	pthread_attr_init(&attr);
	pthread_attr_setstacksize(&attr, PTHREAD_STACK_MIN);

	pthread_create(&thread, &attr, thread_func, NULL);

	pthread_join(thread, NULL);

	return 0;
}

Crashes on my x86-64 boxes all the time. stdout/printf is fine. Some
internal glibc function requires a lot of stack space.

The problem is that we trigger the very same pattern with warning() in
Xenomai. When that is called by the thread trampoline, the user cannot
run threads with otherwise totally fine PTHREAD_STACK_MIN.

Now we can
- ask the user to specify for more stack (by contract)
- reject too small stacks (my patches)
- warn about too small stacks, but accept them (maybe a compromise)
- simply ignore this

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

