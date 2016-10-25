References: <05275bfd-e65c-e60d-b0b8-f7c230d6fbb9@rsi-elektrotechnik.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <573bcd4e-33a5-224f-0178-32ceb2706162@xenomai.org>
Date: Tue, 25 Oct 2016 19:11:39 +0200
MIME-Version: 1.0
In-Reply-To: <05275bfd-e65c-e60d-b0b8-f7c230d6fbb9@rsi-elektrotechnik.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] sigwait or pthread_sigmask behaviour misunderstood or
 broken?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Leupold <leupold@rsi-elektrotechnik.de>, xenomai@xenomai.org

On 10/24/2016 04:22 PM, Jan Leupold wrote:
> Hi,
> 
> My question is about Linux signal handling as it is used in the examples in
> Xenomai 3.0.3. My target runs on ipipe-core-4.1.18-arm7.
> The test program:
> 
> #include <signal.h>
> #include <stdio.h>
> 
> int
> main()
> {
>     sigset_t blocked_signals;
>     sigemptyset(&blocked_signals);
>     sigaddset(&blocked_signals, SIGUSR1);
>     pthread_sigmask(SIG_BLOCK, &blocked_signals, NULL);
> 
>     int sig;
>     sigwait(&blocked_signals, &sig);
>     printf("got signal %d\n", sig);
>     return 0;
> }
> 
> When compiled and linked with
> $CC test-sigwait.c -lpthread
> it works as expected: when I send SIGUSR1 it prints my message
> exit code 0
> 
> But when compile and linked with
> $CC test-sigwait.c $(xeno-config --skin=posix --cflags --ldflags)
> it still waits for some Linux signal, but then prints
> "User defined signal 1",
> which seems to be a string from glibc.
> exit code 138
> 
> Any ideas what is wrong here?
> 

If SIGUSR1 is sent by the glibc's (pthread_)kill() service, then a
linux-originated signal is received by the target process. Therefore,
libcobalt's sigwait() won't receive it, since this is an interface for
receiving signals originated from the Cobalt kernel, which implements a
completely separate handling. When the shell's kill command is used to
send SIGUSR1, the glibc's implementation is picked, which explains the
behavior you described: glibc's internal handler will notice, but not
libcobalt's sigwait() call.

In addition, Xenomai/cobalt does not support asynchronous delivery of
(real-time) signals, only synchronous wait services are available. So
pthread_sigmask() will only deal with linux-originated events and won't
have any effect on Xenomai's handling of such events. Please see for
more details:
http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/#Real-time_signals

To sum up, signals with actual real-time guarantees (i.e. with a bounded
latency required on delivery) have to be sent and received via Xenomai's
libcobalt services.

-- 
Philippe.

