References: <1400958355.32393.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <5380F4E9.3010100@xenomai.org>
 <1400961335.63138.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <5380FAB2.5060809@xenomai.org>
Message-ID: <1400964626.89274.YahooMailNeo@web171601.mail.ir2.yahoo.com>
Date: Sat, 24 May 2014 21:50:26 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <5380FAB2.5060809@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Question about scheduling and signals
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

----- Original Message -----=0A=0A> From: Gilles Chanteperdrix <gilles.chan=
teperdrix@xenomai.org>=0A> On 05/24/2014 09:55 PM, Matthias Schneider wrote=
:=0A>>  ----- Original Message -----=0A>>>  From: Gilles Chanteperdrix <gil=
les.chanteperdrix@xenomai.org>=0A[...]=0A>> =0A>>  Why priMAX_COUNT + 1? Sh=
ouldnt vTaskSuspend be triggered when =0A>>  *pulCounter =3D=3D priMAX_COUN=
T (which is actually is once task 1 gets=0A>>  scheduled while task 2 is ra=
ising abort - at least my debugger tells me =0A>>  it is).=0A> =0A> The tas=
k1 first suspends when pulCounter =3D=3D priMAX_COUNT, right?=0A> Then you =
wake it up, so, since there is a for loop, it will do=0A> =0A>>>> =A0 =A0 (=
*pulCounter)++;=0A>>>> =A0 =A0 if( *pulCounter >=3D priMAX_COUNT )=0A>>>> =
=A0 =A0 =A0  vTaskSuspend(NULL); // -> wait for signal SIGRESM=0A> =0A> So,=
 now task 1 is suspended again, and *pulCounter =3D=3D priMAX_COUNT + 1=0A=
=0A=0A=0AYou are right, I forgot to include an essential piece of code in m=
y=A0=0Afirst snippet(sorry about that):=0A=0A//Task 1, prio 1 / SCHED_FIFO=
=0A=0AvTaskSuspend(NULL); // forgot this in my first snippet=0Afor(;;) {=0A=
=0A=A0 (*pulCounter)++;=0A=A0 if( *pulCounter >=3D priMAX_COUNT )=0A=A0 =A0=
 =A0vTaskSuspend(NULL);=0A}=0A=0A//Task 2, prio 0 / SCHED_OTHER=0AvTaskSusp=
endAll();=0AvTaskResume(xLimitedIncrementHandle);=0AxTaskResumeAll();=A0=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=0Aif (ulCounter !=3D priMAX_COUNT)=0A=
=A0 raise(SIGABRT);=0A=0A=0ANow task will block in the first suspend. Task =
2 will do its thing,=0Aand when task 2's priority gets lowered, I would exp=
ect task 1 being=0Ascheduled right away, increasing the counter up to priMA=
X_COUNT, before=0Atask 2 is scheduled again when task 1 enters the second v=
TaskSuspend.=0AHowever, ulCounter seems to be 0 when SIGABRT is raised.=0A=
=0AMatthias

