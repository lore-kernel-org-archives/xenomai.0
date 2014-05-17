References: <1399222750.71931.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <536689FE.5060503@xenomai.org>
 <1399238572.11209.YahooMailNeo@web171603.mail.ir2.yahoo.com>
Message-ID: <1400337646.61499.YahooMailNeo@web171604.mail.ir2.yahoo.com>
Date: Sat, 17 May 2014 15:40:46 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <1399238572.11209.YahooMailNeo@web171603.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] FreeRTOS skin
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

> From: Matthias Schneider <ma30002000@yahoo.de>=0A=0A>>  From: Gilles Chan=
teperdrix <gilles.chanteperdrix@xenomai.org>=0A>>  On 05/04/2014 06:59 PM, =
Matthias Schneider wrote:=0A>>>  Hi all,=0A>>> =A0=0A>>>  please find enclo=
sed a patch with a FreeRTOS skin for xenomai-forge I have=A0=0A>>>  been=A0=
 working on for some time. I would like to get some feedback and advice=0A>=
>>  what still needs to be done to get it accepted in Xenomai.=A0=0A=0A[...=
]=0A=0A=0AI have removed all already addressed items (most of them) raised =
by Gilles. I=A0=0Awill publish an=A0updated patch soon. However, the follow=
ing points are=A0still=0Aopen:=0A=0A>>  I believe there is an error in thes=
e macros definition:=0A>>  This one looks strange:=0A>>  +#define portNOP()=
 __asm__ __volatile__ ("nop");=0A>> =A0=0A>>  If you do not care whether po=
rtNOP is a barrier you can drop the=A0"volatile"=0A>>  otherwise you should=
 add "memory" as clobber.=0A> =0A> The original FreeRTOS implementation is =
"just" volatile (actually it is=A0=0A> defined exactly the same way as in m=
y header file), so it is a little=A0=0A> difficult to guess the original au=
thors' motives. Since I do not have any=0A> sample code that makes use of t=
his macro, I am not sure of the implications=A0=0A> on existing source code=
 when changing it, independent from removing the volatile=0A> or adding the=
 clobbering.=0A=0ANot sure how to go on here, I propose to leave it as it i=
s.=0A=0A>>  +#define xSemaphoreAltGive(xSemaphore) xSemaphoreGive(xMutex)=
=0A>>  +=0A>>  +#define xSemaphoreGiveFromISR(xSemaphore, pxHigherPriorityT=
askWoken) \=0A>>  +=A0 =A0 =A0 xSemaphoreGive(xMutex)=0A>>  +=0A>> =A0=0A>>=
  About the testsuite: does it really make sense to include both the unpatc=
hed=A0=0A>>  testsuite and xenomai-specific patches? I mean if you want to =
include the=A0=0A>>  tests in xenomai sources, then include them patched, o=
r do not include them,=A0=0A>>  and include the patch.=0A>=0A> I cannot 100=
% follow here. There is one xenomai-specific test suite included,=0A> which=
 is written for xenomai specifically and the original FreeRTOS "demo".=A0=
=0A> The FreeRTOS "demo" is downloadable with and will be patched by the =
=0A> patches=A0=0A> that are checked in. This demo code might be checked in=
 with patches applied=A0=0A> alternatively. Is it that what you were sugges=
ting? Or did I simply not make=A0=0A> clear the difference between the "tes=
tsuite" and the "demo"?=0A=0A=0AAnything else I can do to clarify?=0A=0AMat=
thias=0A

