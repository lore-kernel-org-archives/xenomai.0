MIME-Version: 1.0
Sender: atannen@domain.hid
In-Reply-To: <4EFC677B.20500@domain.hid>
References: <4EF27CD5.4060603@domain.hid>
	<4EF8FBB6.4060107@domain.hid> <4EF8FD8D.2090306@domain.hid>
	<4EFB696E.8000508@domain.hid>
	<4EFC4E21.3000804@domain.hid> <4EFC677B.20500@domain.hid>
From: Andrew Tannenbaum <trb@domain.hid>
Date: Thu, 29 Dec 2011 10:18:09 -0500
Message-ID: <CAJPpvENavHPfvhuS-Ugsje738V=3kko+7dnvv6_AS3F09pbF4w@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] hang in rtcansend
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Dec 29, 2011 at 8:13 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 12/29/2011 12:25 PM, Gilles Chanteperdrix wrote:
>> On 12/28/2011 08:09 PM, Andrew Tannenbaum wrote:
>>> On 12/26/2011 06:04 PM, Gilles Chanteperdrix wrote:
>>>> On 12/26/2011 11:56 PM, Gilles Chanteperdrix wrote:
>>>>> On 12/22/2011 01:41 AM, Andrew Tannenbaum wrote:
>>>>>> Summary: I am having a problem running rtcansend/recv on Xenomai 2.6=
.0,
>>>>>> with the processes hanging in their cleanup code.
>>>>>>
>>>>>> I had been running Xenomai on an Intel Atom system with a PEAK PCI
>>>>>> SJA1000 CAN adapter.
>>>>>>
>>>>>> I was running Linux 2.5.35.7 with Xenomai 2.5.5.2. =A0I connected a =
servo
>>>>>> and motor to the PEAK adapter, and I was able to talk with it using
>>>>>> rtcansend and rtcanrecv.
>>>>>>
>>>>>> After working on other things for a few months, I need to return to =
this
>>>>>> project, so I downloaded the latest Linux/Xenomai pair, which I thin=
k is
>>>>>> Linux 2.5.38.8 and Xenomai 2.6.0.
>>>>>>
>>>>>> I was able to compile these (using the Debian build advice, generati=
ng
>>>>>> .deb files for Linux and Xenomai, which I install with dpkg -i). =A0=
I used
>>>>>> a Linux .config derived from my older build.
>>>>>>
>>>>>> With both the new and old installs, I am able to run xeno-test and g=
et
>>>>>> decent latencies and such, though some of the tests fail depending o=
n
>>>>>> what I have configured in Realtime/Drivers/Testing Drivers. =A0That =
is not
>>>>>> what I'm asking about.
>>>>>>
>>>>>>
>>>>>>
>>>>>> I am having a problem running rtcansend/recv on Xenomai 2.6.0:
>>>>>>
>>>>>> I can run rtcanconfig and it sets up my rtcan0 properly so I can see=
 and
>>>>>> configure the servo. =A0The data in /proc/rtcan looks ok.
>>>>>>
>>>>>> But when I try to talk with the servo using rtcansend, the rtcansend
>>>>>> process fails during the close phase, it looks like this:
>>>>>>
>>>>>> $ rtcansend rtcan0 -v -i 0x0 0x82 0x1
>>>>>> interface rtcan0
>>>>>> s=3D0, ifr_name=3Drtcan0
>>>>>> <0x000> [2] 82 01
>>>>>> Cleaning up...
>>>>>> ^CSignal 2 received
>>>>>> Cleaning up...
>>>>>> $
>>>>>>
>>>>>> So it hangs after the first "Cleaning up..." and I hit Control-C and
>>>>>> then it catches the ^C and exits. =A0The code at the bottom of
>>>>>
>>>>> After various attempts, the bug happens when the main thread exits wi=
th
>>>>> pthread_exit while other threads exist in the process. It was already
>>>>> there in 2.5.6 at least, but we did not see it with rtcansend because
>>>>> there was no other thread than the main thread, while in 2.6.0, there=
 is
>>>>> now the rt_print thread running.
>>>>>
>>>>
>>>> And it is in fact a linux/glibc behaviour. A test program compiled
>>>> without xenomai exhibits the same behaviour. Here is the test program,
>>>> simplified to the max:
>>>>
>>>> #include <pthread.h>
>>>> #include <sys/mman.h>
>>>> #include <time.h>
>>>>
>>>> void *loop(void *cookie)
>>>> {
>>>> =A0 =A0 struct timespec ts;
>>>>
>>>> =A0 =A0 ts.tv_sec =3D 0;
>>>> =A0 =A0 ts.tv_nsec =3D 100000000;
>>>>
>>>> =A0 =A0 pthread_detach(pthread_self());
>>>>
>>>> =A0 =A0 for(;;)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 nanosleep(&ts, NULL);
>>>> }
>>>>
>>>> int main(void)
>>>> {
>>>> =A0 =A0 pthread_t tid;
>>>>
>>>> =A0 =A0 mlockall(MCL_CURRENT | MCL_FUTURE);
>>>>
>>>> =A0 =A0 pthread_create(&tid, NULL, loop, NULL);
>>>>
>>>> =A0 =A0 pthread_exit(NULL);
>>>> }
>>>>
>>>> So, rtcansend should call exit.
>>>>
>>>
>>> Gilles,
>>>
>>> Thank you for your help, it explains and resolves my immediate needs. =
=A0I
>>> am not sure I understand the underlying problem, and I have more
>>> questions about it.
>>>
>>> Re the new loose private rt_print pthread, I am not comfortable with th=
e
>>> suggestion to call exit() explicitly (instead of pthread_exit() or
>>> rt_task_delete()). =A0Asking the user to call exit() instead of
>>> rt_task_delete() is not intuitive.
>>>
>>> In your simple example case, a simple solution would be to call
>>> pthread_cancel(tid) before pthread_exit(). =A0I understand that in a
>>> Xenomai program using rt_print, the user isn't really handling the
>>> rt_print thread. =A0If rt_task_delete() doesn't mean process exit, the
>>> question gets more difficult.
>>>
>>> Can the rt_print pthread be cleaned up automatically? =A0atexit()?
>>> use-count in rt_task_delete()? =A0If not, should rt_print be started an=
d
>>> stopped explicitly by the user?
>>>
>>> I'm wondering about old programs that may hang when they are ported fro=
m
>>> Xenomai pre-2.6 to post-2.6.
>>
>> Here is a patch which only spawns the rt_print thread if the user calls
>> rt_print_auto_init(1), or rt_print_init(). Then if you have called these
>> services, you are expected to call rt_print_cleanup() to cancel the
>> rt_print thread, before calling rt_task_delete().
>
> It is a proposition. What do you think?
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.
>

Gilles,

I will not be in my office until 2-Jan, I will not be able to try the
patch until then.

Giving the user control of explicitly loading and unloading the
rt_print system and thread sounds good to me.

It's not clear to me from a quick look at the patch, what will happen
if a user calls rt_printf() without first calling the rt_print_init
code?

-Andy

