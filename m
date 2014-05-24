Message-ID: <1400958355.32393.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Date: Sat, 24 May 2014 20:05:55 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Question about scheduling and signals
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

Hi all,=0A=0Acurrently I am trying to make the following FreeRTOS test case=
 run on=A0=0Aforge/mercury on linux preempt_rt:=0A=0A=0A//Task 1, prio 1 / =
SCHED_FIFO=0Afor(;;) {=0A=A0 (*pulCounter)++;=0A=A0 if( *pulCounter >=3D pr=
iMAX_COUNT )=0A=A0 =A0 =A0vTaskSuspend(NULL); // -> wait for signal SIGRESM=
=0A}=0A=0A//Task 2, prio 0 / SCHED_OTHER=0AvTaskSuspendAll(); //-> sched_lo=
ck=0AvTaskResume(xLimitedIncrementHandle); //-> sends SIGRESM=0AxTaskResume=
All(); //-> sched_unlock, seems not to unlock the waiting task=0A=A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 // right away (because signal is not yet delive=
red?)=0Aif (ulCounter !=3D priMAX_COUNT)=0A=A0 raise(SIGABRT);=0A=0AConside=
r task 1 in vTaskSuspend. Task 2 will take the "scheduler lock", i.e.=A0=0A=
raises its priority. vTaskResume will then signal task 1 to resume via=A0=
=0Asending SIGRESM. Once xTaskResumeAll lowers task 2's priority to 0,=A0=
=0AI would expect task 1 to be executed right away.=A0However it seems that=
=0Athis is not the case - SIGABRT is raised instead.=0A=0AWhat I do not ful=
ly understand is the delivery of the signal to task 1, which=A0=0Ashould un=
block it, allowing it to run once task calls xTaskResumeAll().=0AWhen the s=
ignal is sent, task 2 is still the highest priority task in the=A0=0Aproces=
s and will thus simply go on with its execution. Now, the signal seems=0Ato=
 be queued for task 1 somehow, but it is unclear to me when it is=A0=0Aactu=
ally delivered (apparently task 1 is not scheduled right away once task 2=
=A0=0Acalls xTaskResumeAll). Could anyone point me into the right direction=
 where=0Ato find the solution to this behavior (i.e. source-code wise)?=A0=
=0A=0AActually I am starting to have doubts about this this test case actua=
lly being=A0=0Ais worth the headaches since we already agreed on supporting=
=A0=0AvTaskSuspendAll/xTaskResumeAll only partially on xenomai-forge, but i=
t would=A0=0Astill be interesting to understand the mentioned behavior...=
=0A=0AThanks in advance for your help.=0A=0AMatthias=0A

