References: <b9dc71b8-119f-71dc-56f8-ae59bfb51a27@foxmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b338d27d-a4f7-3d8f-4b6e-c5edbaf1f6f3@xenomai.org>
Date: Mon, 27 Nov 2017 10:13:21 +0100
MIME-Version: 1.0
In-Reply-To: <b9dc71b8-119f-71dc-56f8-ae59bfb51a27@foxmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Linux 4.1.18 with xenomai 3.0.3,
	libraries build failed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jack Lee <jacklee11@foxmail.com>, xenomai <xenomai@xenomai.org>

On 11/27/2017 05:00 AM, Jack Lee wrote:
> My board cpu is intel Atom N2800, OS is Lubuntu 17.10, gcc version is
> 7.2.0.
> Since the newest 3.0.6 cannot setup on my board, I tried the older version.
> It works now. But when I build the xenomai libraries, it encounters the
> following error:
> 
> -r and -pie can not be used together.
> 
> then I changed the configuration to
> 
> ../configure --with-core=cobalt --enable-smp --enable-pshared
> CFLAGS="-no-pie"
> 
> It didn't work with the new error:
> 
> In file included from ../../../utils/analogy/calibration_ni_m.h:27:0,
>                  from ../../../utils/analogy/calibration_ni_m.c:26:
> ../../../utils/analogy/analogy_calibrate.h: In function ‘__debug’:
> ../../../utils/analogy/analogy_calibrate.h:95:2: error: implicit
> declaration of function ‘clock_gettime’
> [-Werror=implicit-function-declaration]
>   clock_gettime(CLOCK_MONOTONIC, &now);
>   ^~~~~~~~~~~~~
> ../../../utils/analogy/analogy_calibrate.h:95:16: error:
> ‘CLOCK_MONOTONIC’ undeclared (first use in this function)
>   clock_gettime(CLOCK_MONOTONIC, &now);
>                 ^~~~~~~~~~~~~~~
> ../../../utils/analogy/analogy_calibrate.h:95:16: note: each undeclared
> identifier is reported only once for each function it appears in
> 
> Can anyone help?

Instead of downgrading to a release with known core issues, you have the
option to pull fixes for v3.0.6 from the maintenance branch:

URL: http://git.xenomai.org/xenomai-3.git/
branch: stable-3.0.x

-- 
Philippe.

