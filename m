Message-ID: <4BF01291.7060008@domain.hid>
Date: Sun, 16 May 2010 17:43:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D72A@alpine.pivotalsys.com>
In-Reply-To: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D72A@alpine.pivotalsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_mutex created prior to main causes board to
 freeze?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sherk Chung <sherk.chung@domain.hid>
Cc: xenomai@xenomai.org

Sherk Chung wrote:
> We are using Xenomai on an AT91 ARM board.  We wrote a program that
> creates multiple Xenomai tasks, which use rt_mutexes to when accessing
> some shared global variables.  The rt_mutexes used are declared
> globally, as in the example below.  Since the objects sharedVar1,
> shredVar2, etc. are declared on the global stack, the rt_mutexes are
> created prior to main() getting executed.  The problem we are having is
> that our program is causing our HW to freeze up on program load, it
> never gets to the first line of main(), and our HW supplier pointed out
> that we must call mlockall() and the set up the signal handlers before
> creating the mutexes.
> 
>  
> 
> Is there a problem with creating rt_mutexes the way we are doing, and
> should that cause the ARM board to freeze?  (the same program loads fine
> on an x86)

Hi,

your test program does not compile, next time, please provide a 
self-contained test which I only have to compile in order to be able to 
run it. I compiled and ran the following program:

#include <native/queue.h>
#include <native/mutex.h>
#include <signal.h>
#include <sys/mman.h>


template <class T>
class SyncObject {
private:
        RT_MUTEX mutex;

public:
        T value;

        SyncObject(const char* desc)
        {
                printf("mutex_create !\n");
                rt_mutex_create(&mutex, desc);
        }

        ~SyncObject()
        {
                rt_mutex_delete(&mutex);
        }

        void lock()

        void unlock()
        {
                rt_mutex_release(&mutex);
        }
} ;

SyncObject<int> g_sharedVar1 = "var1";
SyncObject<int> g_sharedVar2 = "var2";
SyncObject<int> g_sharedVar3 = "var3";

extern "C" int main(void)
{
        printf ("Starting execution of main");   //  Program crashes before

        mlockall(MCL_CURRENT | MCL_FUTURE);
	return 0;
}

And it runs just fine. So, I need more details, such as your kernel
configuration.

-- 
					    Gilles.

