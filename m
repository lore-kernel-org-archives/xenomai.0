From: Jack Lee <jacklee11@foxmail.com>
Message-ID: <b9dc71b8-119f-71dc-56f8-ae59bfb51a27@foxmail.com>+7621F2EF33B7A4FC
Date: Mon, 27 Nov 2017 12:00:44 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [Xenomai] Linux 4.1.18 with xenomai 3.0.3, libraries build failed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

My board cpu is intel Atom N2800, OS is Lubuntu 17.10, gcc version is 
7.2.0.
Since the newest 3.0.6 cannot setup on my board, I tried the older version.
It works now. But when I build the xenomai libraries, it encounters the 
following error:

-r and -pie can not be used together.

then I changed the configuration to

../configure --with-core=cobalt --enable-smp --enable-pshared 
CFLAGS="-no-pie"

It didn't work with the new error:

In file included from ../../../utils/analogy/calibration_ni_m.h:27:0,
                  from ../../../utils/analogy/calibration_ni_m.c:26:
../../../utils/analogy/analogy_calibrate.h: In function ‘__debug’:
../../../utils/analogy/analogy_calibrate.h:95:2: error: implicit 
declaration of function ‘clock_gettime’ 
[-Werror=implicit-function-declaration]
   clock_gettime(CLOCK_MONOTONIC, &now);
   ^~~~~~~~~~~~~
../../../utils/analogy/analogy_calibrate.h:95:16: error: 
‘CLOCK_MONOTONIC’ undeclared (first use in this function)
   clock_gettime(CLOCK_MONOTONIC, &now);
                 ^~~~~~~~~~~~~~~
../../../utils/analogy/analogy_calibrate.h:95:16: note: each undeclared 
identifier is reported only once for each function it appears in

Can anyone help?
Thanks.



