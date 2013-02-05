Message-ID: <511122D3.8000501@icid.cu>
Date: Tue, 05 Feb 2013 10:18:43 -0500
From: raespi <raespi@icid.cu>
MIME-Version: 1.0
References: <510FFDE0.4080703@icid.cu>
	<510FFE7C.1090601@xenomai.org>	<51100A6B.90701@icid.cu>
	<5110122C.2090807@xenomai.org>	<511021FC.7080906@icid.cu>
	<51102316.9090107@xenomai.org>	<511027E6.4080202@icid.cu>
	<51110A7E.4020506@icid.cu> <51111CC2.3040204@xenomai.org>
	<51111DB6.4030809@icid.cu> <51111E46.4070706@xenomai.org>
In-Reply-To: <51111E46.4070706@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] about switchtest ...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Yes I saw your answer and understood what you were talking about. =20
Again, the "-march=3Darmv4t -msoft-float" options are passed to every=20
package Buildroot builds since it's an option I enable in the Buildroot=20
config file.  The problem may lie in how it passes them to Xenomai=20
specifically.  For a fact, I can assure you they weren't passed to the=20
right of the ./configure script as you suggested since I double checked=20
the config.log for the Xenomai build.   Why the "Illegal Instruction"=20
message wasn't showing up I don't know but it's not something that=20
popped up to me before for not passing the flags, at least not in the=20
smdk2440 target.

Facts:
1- Buildroot doesn't build correctly the Xenomai package ( test suite=20
fails to launch )
2- When passing the flags in Buildroot manually ( for now ) to the=20
Xenomai package the test suite runs normally
3- The solution is either fixing the parameter passing scheme on Xenomai=20
or how Buildroot passes the parameters ( I go with this last one ).

El 02/05/2013 09:59 AM, Gilles Chanteperdrix escribi=C3=B3:
> On 02/05/2013 03:56 PM, raespi wrote:
>
>> The problem was fixed ... The buildroot system didn't pass the specifi=
c
>> CFLAGS and LDFLAGS for my machine.  In your Getting Started guide this
>> is something necessary.  That's what fixed the problem and allowed me =
to
>> run the tests.  What I'm checking with him is how those flags are pass=
ed
>> to Xenomai.  Perhaps he didn't notice it before since no one ran the
>> test suite for this machine ?? IDK ...
>
> No, read my answer again. If buildroot did not pass correct CFLAGS or
> LDFLAGS, you would get an "illegal instruction" trap. So, you have not
> really understood what your problem is, and you have not understood why
> passing specific CFLAGS and LDFLAGS in addition to the ones passed by
> buildroot fixes it.
>



