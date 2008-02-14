Date: Thu, 14 Feb 2008 17:05:15 +0100
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200802141705.17258@domain.hid>
References: 00802141029.19685@domain.hid> <200802141055.1177@domain.hid>
	<200802141058.2356@domain.hid>
	<2ff1a98a0802140532v36aed06bnff68387cc04cbec9@domain.hid>
	<200802141648.10545@domain.hid>
In-Reply-To: <200802141648.10545@domain.hid>
Content-Type: text/plain; charset="windows-1250"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Slow sin function
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

_
>On Thu, Feb 14, 2008 at 10:58 AM, Petr Cervenka <grugh@domain.hid> wrote:
>> Hello again.
>>  I have another problem and I'm not sure if it is connected with Xenomai ,
>>  but perhaps you already met similar problem.
>>  Occasionally  the math sin function takes an enormous amount of time
>>  (400-450 us on Athlon A64 X2 4800+). When I detect this and make the sin function
>>  call with the same parameter again, it takes the same (long) time. I
>>  suspect that this function is for some values is unreasonably slow. I'll
>>  try to capture some such values and post them here.
>>  I don't remember such behavior before the transition to newer 64bit linux
>>  distribution (Kubuntu 7.10 amd64 and kernel 2.6.24).
>>  Petr Cervenka
>
>I would expect the sin function to be built-in, at least, I think it
>is built-in on x86_32.
>
>Now, looking at glibc code, there seem to be a loop in the
>implementation of these functions.
>
>-- 
> Gilles Chanteperdrix
>
I managed to capture two such numbers:
0.93340582292648832662962377071381	(0x00b06be375deed3f)
3.9225160069792437411706487182528 	(0x5019801250610f40)

Tried on similar 32bit machine (2.6.19.7), everything is OK there.
Any idea how to solve it or who to inform about this problem?

Short program for trying this problem:
usage: hextodbl 00 b0 6b e3 75 de ed 3f
or          hextodbl 0.93340582292648832662962377071381

#include <stdlib.h>
#include <sstream>
#include <iostream>
#include <iomanip>
#include <math.h>
#include <sys/time.h>

using namespace std;

int main(int argc, char** argv) {
    
    unsigned char hexdbl_hex[sizeof(double)];
    volatile double &hexdbl_dbl = *((double*)hexdbl_hex);
    
    if (argc == sizeof(double)+1) {
        for (int i=0; i < sizeof(double); i++) {
            istringstream s(argv[i+1]);
            int tmp;
            s >> hex >> tmp;
            hexdbl_hex[i] = tmp;
        }
    } else if (argc == 2) {
        istringstream s(argv[1]);
        double tmp;
        s >> tmp;
        hexdbl_dbl = tmp;
    } else {
        cout << "usage: hextodbl 11 02 f3 e4 d5 c6 b7 a8\n"
		"       hextodbl 0.123456789\n";
        return (EXIT_FAILURE);
    }
    
    cout.precision(32);
    cout << hexdbl_dbl << endl;

    struct timeval time1, time2;
    struct timeval diftime;
    cout << "start\n";
    gettimeofday(&time1, NULL);
    for (int i=0; i < 10000; i++) {
        volatile double out = sin(hexdbl_dbl);
        out = 0;
    }
    gettimeofday(&time2, NULL);
    diftime.tv_usec = time2.tv_usec - time1.tv_usec;
    diftime.tv_sec = time2.tv_sec - time1.tv_sec;
    
    while (diftime.tv_usec < 0) {
        diftime.tv_usec += 1000000;
        diftime.tv_sec--;
    }
    while (diftime.tv_usec >= 1000000) {
        diftime.tv_usec -= 1000000;
        diftime.tv_sec++;
    }
    cout << "end: " << diftime.tv_sec << '.' << setw(6) << setfill('0') << diftime.tv_usec << endl;
    
    return (EXIT_SUCCESS);
}


