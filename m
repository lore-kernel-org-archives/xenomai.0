From: Jan Leupold <leupold@rsi-elektrotechnik.de>
Message-ID: <05275bfd-e65c-e60d-b0b8-f7c230d6fbb9@rsi-elektrotechnik.de>
Date: Mon, 24 Oct 2016 16:22:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] sigwait or pthread_sigmask behaviour misunderstood or
	broken?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

My question is about Linux signal handling as it is used in the examples in
Xenomai 3.0.3. My target runs on ipipe-core-4.1.18-arm7.
The test program:

#include <signal.h>
#include <stdio.h>

int
main()
{
    sigset_t blocked_signals;
    sigemptyset(&blocked_signals);
    sigaddset(&blocked_signals, SIGUSR1);
    pthread_sigmask(SIG_BLOCK, &blocked_signals, NULL);

    int sig;
    sigwait(&blocked_signals, &sig);
    printf("got signal %d\n", sig);
    return 0;
}

When compiled and linked with
$CC test-sigwait.c -lpthread
it works as expected: when I send SIGUSR1 it prints my message
exit code 0

But when compile and linked with
$CC test-sigwait.c $(xeno-config --skin=posix --cflags --ldflags)
it still waits for some Linux signal, but then prints
"User defined signal 1",
which seems to be a string from glibc.
exit code 138

Any ideas what is wrong here?

Best regards,
Jan

-- 
_____________________________________________________________
Jan Leupold
Dr.-Ing.
Entwicklung

Tel.: +49 8444 9204-32
Fax:  +49 8444 9204-50
leupold@rsi-elektrotechnik.de

R-S-I Elektrotechnik GmbH & Co. KG
Woelkestrasse 11
D-85301 Schweitenkirchen
www.rsi-elektrotechnik.de
_____________________________________________________________
Amtsgericht Ingolstadt - GmbH: HRB 191328 - KG: HRA 170363
Geschäftsführer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
USt-IdNr.: DE 128592548


