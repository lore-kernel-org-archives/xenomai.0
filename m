References: <1400958355.32393.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <5380F4E9.3010100@xenomai.org>
 <1400961335.63138.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <5380FAB2.5060809@xenomai.org>
 <1400964626.89274.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53810C71.7090007@xenomai.org>
Message-ID: <1401005131.89995.YahooMailNeo@web171602.mail.ir2.yahoo.com>
Date: Sun, 25 May 2014 09:05:31 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53810C71.7090007@xenomai.org>
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

=0A=0A=0A=0A=0A----- Original Message -----=0A> From: Gilles Chanteperdrix =
<gilles.chanteperdrix@xenomai.org>=0A> To: Matthias Schneider <ma30002000@y=
ahoo.de>; "xenomai@xenomai.org" <xenomai@xenomai.org>=0A> Cc: =0A> Sent: Sa=
turday, May 24, 2014 11:17 PM=0A> Subject: Re: [Xenomai] Question about sch=
eduling and signals=0A> =0A> On 05/24/2014 10:50 PM, Matthias Schneider wro=
te:=0A>>  ----- Original Message -----=0A>> =0A>>>  From: Gilles Chanteperd=
rix <gilles.chanteperdrix@xenomai.org>=0A>>>  On 05/24/2014 09:55 PM, Matth=
ias Schneider wrote:=0A>>>> =A0 ----- Original Message -----=0A>>>>> =A0 Fr=
om: Gilles Chanteperdrix =0A> <gilles.chanteperdrix@xenomai.org>=0A>>  [...=
]=0A>>>> =0A>>>> =A0 Why priMAX_COUNT + 1? Shouldnt vTaskSuspend be trigger=
ed when =0A>>>> =A0 *pulCounter =3D=3D priMAX_COUNT (which is actually is o=
nce task 1 gets=0A>>>> =A0 scheduled while task 2 is raising abort - at lea=
st my debugger =0A> tells me =0A>>>> =A0 it is).=0A>>> =0A>>>  The task1 fi=
rst suspends when pulCounter =3D=3D priMAX_COUNT, right?=0A>>>  Then you wa=
ke it up, so, since there is a for loop, it will do=0A>>> =0A>>>>>> =A0 =A0=
  (*pulCounter)++;=0A>>>>>> =A0 =A0  if( *pulCounter >=3D priMAX_COUNT )=0A=
>>>>>> =A0 =A0 =A0 =A0 vTaskSuspend(NULL); // -> wait for signal SIGRESM=0A=
>>> =0A>>>  So, now task 1 is suspended again, and *pulCounter =3D=3D priMA=
X_COUNT + 1=0A>> =0A>> =0A>> =0A>>  You are right, I forgot to include an e=
ssential piece of code in my =0A>>  first snippet(sorry about that):=0A>> =
=0A>>  //Task 1, prio 1 / SCHED_FIFO=0A>> =0A>>  vTaskSuspend(NULL); // for=
got this in my first snippet=0A>>  for(;;) {=0A>> =0A>> =A0  (*pulCounter)+=
+;=0A>> =A0  if( *pulCounter >=3D priMAX_COUNT )=0A>> =A0 =A0 =A0 vTaskSusp=
end(NULL);=0A>>  }=0A>> =0A>>  //Task 2, prio 0 / SCHED_OTHER=0A>>  vTaskSu=
spendAll();=0A>>  vTaskResume(xLimitedIncrementHandle);=0A>>  xTaskResumeAl=
l(); =0A>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =0A>>  if (ulCounter !=3D pr=
iMAX_COUNT)=0A>> =A0  raise(SIGABRT);=0A>> =0A>> =0A>>  Now task will block=
 in the first suspend. Task 2 will do its thing,=0A>>  and when task 2's pr=
iority gets lowered, I would expect task 1 being=0A>>  scheduled right away=
, increasing the counter up to priMAX_COUNT, before=0A>>  task 2 is schedul=
ed again when task 1 enters the second vTaskSuspend.=0A>>  However, ulCount=
er seems to be 0 when SIGABRT is raised.=0A> =0A> Are you running an unipro=
cessor, or multi-processor system?=0A> =0A=0A=0AIt was an mp system, but wi=
th processor affinity set and pegged to=A0=0Aa single core (which had so fa=
r produced the expected results in=A0=0Aother tests).=0A

