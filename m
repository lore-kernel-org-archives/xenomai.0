Subject: Re: xenomai 3.1/ipipe-core-4.19.128-cip28-arm-10.patch
References: <16c407c9-8ed4-4b43-b38b-aac8a270e686@gmail.com>
 <CALLqZ8RXOhONVAti+XyW6dRSCWYcnLnyG1=fYyXQgU+k7RPWAA@mail.gmail.com>
 <a1b13b3e-3d27-586a-c8bb-fec44a368f58@gmail.com>
 <CALLqZ8REwJXSjZ4m3D3_VGdfgf66ZcG0_oWq0MajEn3jMCXQWw@mail.gmail.com>
 <d88931aa-2a36-c29a-6dc5-919617dfde8d@gmail.com>
 <2bca51d7-9d10-18f5-e454-88a50e4e0354@siemens.com>
From: Robert Berger <xenomai.list@gmail.com>
Message-ID: <57389d5d-9620-dc0b-9412-976e953777bb@gmail.com>
Date: Tue, 14 Jul 2020 01:00:21 +0300
MIME-Version: 1.0
In-Reply-To: <2bca51d7-9d10-18f5-e454-88a50e4e0354@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

My comments are in-line.

On 13/07/2020 20:08, Jan Kiszka wrote:
> On 08.07.20 01:04, Robert Berger via Xenomai wrote:
>> It looks like either we hit a glibc issue, or something is not clear 
>> to me in the xenomai test case.
>>
>> The glibc has a fallback for the unknown syscall. clock_nanosleep_time64
>>
>> Is this what the xenomai testcase tries to tell us?
>>
>> Than that is not an error, but fine;)
>>
> 
> If glibc is probing the existence of the new syscall by calling it, we 
> may silence the warning path. To my current reading, it must have been 
> triggered from a Xenomai thread in primary domain - are we sure that 
> this is correct behavior? Could you set a breakpoint on glibc call and 
> provide a backtrace?

When clock_nanosleep() is called from Linux the glibc first calls the 
clock_nanosleep_time64() syscall (which fails on a 4.19 kernel and 
succeeds on a 5.4 kernel). In case it fails glibc calls the old 
clock_nanosleep() syscall and all is good.

The problem here is that the testcase protect_trylock 
(posix-mutex.c:1063) calls __real_usleep()(lib/cobalt/wrappers.c:553); 
which causes [Xenomai] bad syscall <0x197>.

I guess __real_usleep should call the real POSIX implementation.

__weak
int __real_usleep(useconds_t usec)
{
         return usleep(usec);
}

usleep calls __nanosleep and this seems to cause the bad syscall.

Thread 1 "smokey" hit Breakpoint 3, usleep (useconds=useconds@entry=1) 
at ../sysdeps/posix/usleep.c:26
26        struct timespec ts = { .tv_sec = (long int) (useconds / 1000000),
(gdb) bt
#0  usleep (useconds=useconds@entry=1) at ../sysdeps/posix/usleep.c:26
#1  0xb6f81140 in __real_usleep (usec=usec@entry=1) at wrappers.c:555
#2  0x00418bf8 in protect_trylock () at posix-mutex.c:933
#3  run_posix_mutex (t=<optimized out>, argc=<optimized out>, 
argv=<optimized out>) at posix-mutex.c:1063
#4  run_posix_mutex (t=<optimized out>, argc=<optimized out>, 
argv=<optimized out>) at posix-mutex.c:1027
#5  0x004041c4 in main (argc=1, argv=0x438750) at main.c:34
(gdb) l
21      #include <unistd.h>
22
23      int
24      usleep (useconds_t useconds)
25      {
26        struct timespec ts = { .tv_sec = (long int) (useconds / 1000000),
27                               .tv_nsec = (long int) (useconds % 
1000000) * 1000ul };
28
29        /* Note the usleep() is a cancellation point.  But since we call
30           nanosleep() which itself is a cancellation point we do not have
(gdb) n
32        return __nanosleep (&ts, NULL);
(gdb) n
[ 2168.741990] [Xenomai] bad syscall <0x197>
protect_trylock () at posix-mutex.c:935
935             if (!__T(ret, pthread_mutex_trylock(&mutex)))
(gdb)

Just FYI this code with usleep() seems to work without xenomai:

int my_usleep(unsigned int millisec)
{
         int rc;
         rc = usleep(millisec);
         if (rc < 0) {
                 perror("my_usleep: ");
         }
         return rc;
}

int main(int argc, char *argv[])
{
         argc = argc;
         argv = argv;

         unsigned int millisec = 1;
         int rc;

         rc = my_usleep(millisec);

         exit(rc);
}


> 
> Jan
> 

Regards,

Robert

