Message-ID: <555DF3D3.9090600@basystemes.fr>
Date: Thu, 21 May 2015 17:03:47 +0200
From: Thierry Bultel <thierry.bultel@basystemes.fr>
MIME-Version: 1.0
References: <555D77F6.7030007@basystemes.fr> <555D7C73.8030905@basystemes.fr>
 <555DCA94.1070909@xenomai.org>
In-Reply-To: <555DCA94.1070909@xenomai.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Are concurrent writes to XDDP sockets allowed ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org
Cc: =?windows-1252?Q?C=E9line?= <celine.leberre.prestataire@basystemes.fr>



Le 21/05/2015 14:07, Philippe Gerum a =E9crit :
> On 05/21/2015 08:34 AM, Thierry Bultel wrote:
>> Hi,
>> In an application, we have one regular thread listening on an RTP device,
>> and 2 realtime threads that concurrently write data in the XDDP socket
>> backend.
>> We use the POSIX skin.
>>
>> Sometimes, the regular thread gets its blocking read() call just return =
0.
>> That never happens with the classic "one reader, one writer" case.
>>
>> Also, we notice that the 'return 0' case occurrence is not the same,
>> depending
>> on the fact that the realtime task uses 'write' instead of 'sendto'
>> (more occurrences with 'sendto')
>>
> There is no restriction with respect to concurrent sending to such socket.
Ok, thanks
> Knowing about the Xenomai release number,
This is 2.6.4
> and a simple test code that
> actually illustrates the intended usage and ideally reproduces the issue
> would help.
Here is the test code, based on xddp-echo.c . Unfortunalely this does=20
not reproduce the issue.
Compared to our application, we also have 3 other additional=20
realtime-regular pairs communicating on 3 dedicated channels.

What would trigger the 'read' return with zero ?
Apparently, the allocated pool only impacts the realtime side, and we do=20
not see 'write' failures


-----------------

#include <sys/mman.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <string.h>
#include <malloc.h>
#include <pthread.h>
#include <fcntl.h>
#include <errno.h>
#include <rtdk.h>
#include <rtdm/rtipc.h>
pthread_t rt1, rt2, nrt;

int shared_sock =3D 0; /* socket shared between 2 rt threads */

#define XDDP_PORT 0     /* [0..CONFIG-XENO_OPT_PIPE_NRDEV - 1] */
static const char *msg[] =3D {
     "Surfing With The Alien",
     "Lords of Karma",
     "Banana Mango",
     "Psycho Monkey",
     "Luminous Flesh Giants",
     "Moroccan Sunset",
     "Satch Boogie",
     "Flying In A Blue Dream",
     "Ride",
     "Summer Song",
     "Speed Of Light",
     "Crystal Planet",
     "Raspberry Jam Delta-V",
     "Champagne?",
     "Clouds Race Across The Sky",
     "Engines Of Creation"
};
static void fail(const char *reason)
{
         perror(reason);
         exit(EXIT_FAILURE);
}

static void *realtime_thread(void * arg)
{
         struct sockaddr_ipc saddr;
         int ret, s, n =3D 0, len;
         struct timespec ts;
         size_t poolsz;
         char buf[128];
     char * name =3D(char*) arg;

     if (shared_sock)
         goto loop;

         /*
          * Get a datagram socket to bind to the RT endpoint. Each
          * endpoint is represented by a port number within the XDDP
          * protocol namespace.
          */
         s =3D socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP);
         if (s < 0) {
                 perror("socket");
                 exit(EXIT_FAILURE);
         }

         /*
          * Set a local 16k pool for the RT endpoint. Memory needed to
          * convey datagrams will be pulled from this pool, instead of
          * Xenomai's system pool.
          */
         poolsz =3D 16384; /* bytes */
         ret =3D setsockopt(s, SOL_XDDP, XDDP_POOLSZ,
                          &poolsz, sizeof(poolsz));
         if (ret)
                 fail("setsockopt");

         /*
          * Bind the socket to the port, to setup a proxy to channel
          * traffic to/from the Linux domain.
          *
          * saddr.sipc_port specifies the port number to use.
          */
         memset(&saddr, 0, sizeof(saddr));
         saddr.sipc_family =3D AF_RTIPC;
         saddr.sipc_port =3D XDDP_PORT;
         ret =3D bind(s, (struct sockaddr *)&saddr, sizeof(saddr));
         if (ret)
                 fail("bind");

     shared_sock=3Ds;
loop:
         for (;;) {
                 len =3D strlen(msg[n]);
                 /*
                  * Send a datagram to the NRT endpoint via the proxy.
                  * We may pass a NULL destination address, since a
                  * bound socket is assigned a default destination
                  * address matching the binding address (unless
                  * connect(2) was issued before bind(2), in which case
                  * the former would prevail).
                  */
                 ret =3D sendto(shared_sock, msg[n], len, 0, NULL, 0);
                 if (ret !=3D len)
                         fail("sendto");
/*                rt_printf("%s %s: sent %d bytes, \"%.*s\"\n",
                           name, __FUNCTION__, ret, ret, msg[n]);*/

                 n =3D (n + 1) % (sizeof(msg) / sizeof(msg[0]));
                 /*
                  * We run in full real-time mode (i.e. primary mode),
                  * so we have to let the system breathe between two
                  * iterations.
                  */
                 ts.tv_sec =3D 0;
                 ts.tv_nsec =3D 2000000; /* 2 ms */
                 clock_nanosleep(CLOCK_REALTIME, 0, &ts, NULL);
         }
         return NULL;
}

static void *regular_thread(void *arg)
{
         char buf[128], *devname;
         int fd, ret;
         if (asprintf(&devname, "/dev/rtp%d", XDDP_PORT) < 0)
                 fail("asprintf");
         fd =3D open(devname, O_RDWR);
         free(devname);
         if (fd < 0)
                 fail("open");
         for (;;) {
                 /* Get the next message from realtime_thread. */
                 ret =3D read(fd, buf, sizeof(buf));
                 if (ret <=3D 0)
                         fail("read");

         }
         return NULL;
}
static void cleanup_upon_sig(int sig)
{
         pthread_cancel(rt1);
         pthread_cancel(rt2);
         pthread_cancel(nrt);
         signal(sig, SIG_DFL);
         pthread_join(rt1, NULL);
     pthread_join(rt2, NULL);
         pthread_join(nrt, NULL);
}
int main(int argc, char **argv)
{
         struct sched_param rtparam =3D { .sched_priority =3D 42 };
         pthread_attr_t rtattr, regattr;
         sigset_t mask, oldmask;
         mlockall(MCL_CURRENT | MCL_FUTURE);
         sigemptyset(&mask);
         sigaddset(&mask, SIGINT);
         signal(SIGINT, cleanup_upon_sig);
         sigaddset(&mask, SIGTERM);
         signal(SIGTERM, cleanup_upon_sig);
         sigaddset(&mask, SIGHUP);
         signal(SIGHUP, cleanup_upon_sig);
         pthread_sigmask(SIG_BLOCK, &mask, &oldmask);
         /*
          * This is a real-time compatible printf() package from
          * Xenomai's RT Development Kit (RTDK), that does NOT cause
          * any transition to secondary (i.e. non real-time) mode when
          * writing output.
          */
         rt_print_auto_init(1);
         pthread_attr_init(&rtattr);
         pthread_attr_setdetachstate(&rtattr, PTHREAD_CREATE_JOINABLE);
         pthread_attr_setinheritsched(&rtattr, PTHREAD_EXPLICIT_SCHED);
         pthread_attr_setschedpolicy(&rtattr, SCHED_FIFO);
         pthread_attr_setschedparam(&rtattr, &rtparam);
         errno =3D pthread_create(&rt1, &rtattr, &realtime_thread, "rt1");
         if (errno)
                 fail("pthread_create for rt1");

     sleep(1);

         errno =3D pthread_create(&rt2, &rtattr, &realtime_thread, "rt2");
         if (errno)
                 fail("pthread_create for rt2");

         pthread_attr_init(&regattr);
         pthread_attr_setdetachstate(&regattr, PTHREAD_CREATE_JOINABLE);
         pthread_attr_setinheritsched(&regattr, PTHREAD_EXPLICIT_SCHED);
         pthread_attr_setschedpolicy(&regattr, SCHED_OTHER);
         errno =3D pthread_create(&nrt, &regattr, &regular_thread, NULL);
         if (errno)
                 fail("pthread_create");
         sigsuspend(&oldmask);
         return 0;
}

>


