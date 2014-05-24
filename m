References: <1400958355.32393.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <5380F4E9.3010100@xenomai.org>
Message-ID: <1400961335.63138.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Date: Sat, 24 May 2014 20:55:35 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <5380F4E9.3010100@xenomai.org>
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
teperdrix@xenomai.org>=0A> To: Matthias Schneider <ma30002000@yahoo.de>; "x=
enomai@xenomai.org" <xenomai@xenomai.org>=0A> Cc: =0A> Sent: Saturday, May =
24, 2014 9:37 PM=0A> Subject: Re: [Xenomai] Question about scheduling and s=
ignals=0A> =0A> On 05/24/2014 09:05 PM, Matthias Schneider wrote:=0A>>  Hi =
all,=0A>> =0A>>  currently I am trying to make the following FreeRTOS test =
case run on =0A>>  forge/mercury on linux preempt_rt:=0A>> =0A>> =0A>>  //T=
ask 1, prio 1 / SCHED_FIFO=0A>>  for(;;) {=0A>> =A0  (*pulCounter)++;=0A>> =
=A0  if( *pulCounter >=3D priMAX_COUNT )=0A>> =A0 =A0 =A0 vTaskSuspend(NULL=
); // -> wait for signal SIGRESM=0A>>  }=0A>> =0A>>  //Task 2, prio 0 / SCH=
ED_OTHER=0A>>  vTaskSuspendAll(); //-> sched_lock=0A>>  vTaskResume(xLimite=
dIncrementHandle); //-> sends SIGRESM=0A>>  xTaskResumeAll(); //-> sched_un=
lock, seems not to unlock the waiting =0A> task=0A>> =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0  // right away (because signal is not yet delivered?)=0A> =
=0A> At this point, task 1 wakes up, increments ulCounter again, then suspe=
nd=0A> again, so now ulCounter =3D=3D priMAX_COUNT + 1=0A=0A=0AWhy priMAX_C=
OUNT + 1? Shouldnt vTaskSuspend be triggered when=A0=0A*pulCounter =3D=3D p=
riMAX_COUNT (which is actually is once task 1 gets=0Ascheduled while task 2=
 is raising abort - at least my debugger tells me=A0=0Ait is).=0A=0A>>  if =
(ulCounter !=3D priMAX_COUNT)=0A>> =A0  raise(SIGABRT);=0A> =0A> So this te=
st fails, and you get a SIGABORT=0A> =0A> I do not see how this test could =
do anything else than throwing a=0A> SIGABORT. Also note that on multi-proc=
essor systems, if task 0 and task=0A> 1 are not running on the same CPU, th=
ere is a race between task 1=0A> incrementing the counter and task 2 readin=
g its value to compare it to=0A> priMAX_COUNT.=0A=0A=0ACorrect, however I f=
orgot to mention that I set CPU affinity to make the=A0=0Aprocess use a sin=
gle CPU (which has basically worked for all scenarios I=A0=0Ahad previously=
 investigated).=0A

