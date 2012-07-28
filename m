Message-ID: <1343501377.68444.YahooMailNeo@web193906.mail.sg3.yahoo.com>
Date: Sun, 29 Jul 2012 02:49:37 +0800 (SGT)
From: Uttamkumar Sinojia <uttamkumarsinojia@yahoo.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] jitter-test
Reply-To: Uttamkumar Sinojia <uttamkumarsinojia@yahoo.in>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=0APlease post the test code, tell us which version of xenomai you use, =
and=0Apost the kernel configuration. And explain with the code what you wou=
ld=0Aexpect and what you get.=0A=0A--=A0=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 Gilles.=0A=0A=0ATest code.........=0A=0AVersion XENOMA=
I 2.5.6=0A=0A=0AFirst setup with task periods 1ms, 2ms, 3ms, 4ms, 5ms.=0A=
=0A=0A#include <native/task.h>=0A#include <native/timer.h>=0A=0A=0A#define =
NO_TASK5//number of task descripter=0A#define TASK_STKSZ4096=0A#define TASK=
_MODE(T_FPU | T_CPU(0))=0A=0A=0A#define u_NSEC 1000//one microsecond in nan=
oseconds=0A#define m_NSEC 1000000//one millisecond in nanoseconds=A0=0A#def=
ine s_NSEC1000000000//one second in nanoseconds=0A=0A#define SETUP_TICK_NSE=
C =A0 =A0 =A0 =A0 =A0 =A0 =A0 1000000 =A0 =A0 =A0 =A0 //one millisecond tim=
er tick - can be reasonably=A0=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 //modified (increas=
ed or decreased)=0A=0A=0A#define PERIOD_1(m_NSEC*1)=0A#define PERIOD_2(m_NS=
EC*2)=0A#define PERIOD_3(m_NSEC*3)=0A#define PERIOD_4(m_NSEC*4)=0A#define P=
ERIOD_5(m_NSEC*5)=0A=0A/*=0A#define PERIOD_1(u_NSEC*100)=0A#define PERIOD_2=
(u_NSEC*200)=0A#define PERIOD_3(u_NSEC*300)=0A#define PERIOD_4(u_NSEC*400)=
=0A#define PERIOD_5(u_NSEC*500)=0A*/=0A=0A=0A#define WAKE_TIME(m_NSEC*200)=
=0A#define NO_ITERATION10=0A=0A#define ONE_SHOT_MODE1//if it is define 1 th=
en then select oneshot mode otherwise select=A0=0A=A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 //periodic mode=0A=0A=0ART_TASK task_desc[N=
O_TASK];=0A=0A=0Aint ret;=0A=0ARTIME tmp=3D0;=0ARTIME task_pstart_time=3D0,=
 systime1=3D0,systime2=3D0;=0A=0Avoid rt_task_1(void *cookie)=0A{=0ART_TASK=
_INFO rttinfo;=0ARTIME reltime;//to store wokenup time=0ARTIME =A0expected_=
time=3D0,cur_sys_time=3D0,jitter=3D0;=0Aint i;=0Aint tmp_ret;=0Asystime2 =
=3D rt_timer_read();//read the current system time=0A=A0 =A0 =A0 =A0 xnprin=
tf("1->initial task system time ....value =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 %=
llu \n", systime2);=0A=A0 =A0 =A0 =A0=A0=0A=A0 =A0 =A0 =A0=A0=0A=A0 =A0 =A0=
 =A0 xnprintf("1->expected initial task wake up time ..value =A0 =A0 =A0 =
=A0 %llu \n",task_pstart_time);=0A=A0 =A0 =A0 =A0=A0=0Aret =3D rt_task_set_=
periodic(NULL, task_pstart_time, PERIOD_1);=0Aif(ret<0) { xnprintf("1->erro=
r in rt_task_set_periodic() =A0%d ...\n",ret); return ;}=0A=0Asystime2 =3D =
rt_timer_read();//read the current system time=0A=A0 =A0 =A0 =A0 xnprintf("=
1->actual system time after first task wake-up...value%llu \n",=A0=0A=A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 systime2);=0A=A0 =A0 =A0 =A0=A0=0A=A0 =A0 =
=A0 =A0 xnprintf("1->initial jitter after first task wake-up....value =A0 %=
lld \n",=A0=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 systime2-task_pstart_time=
);=0A=0A=0Afor(i=3D1; i<=3DNO_ITERATION; ++i){=0Art_task_wait_period(NULL);=
=0A=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0cur_sys_time =3D rt_timer_read();//read th=
e sys_time=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0expected_time =3D task_pstart_time =
+ i*PERIOD_1;=0A=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0xnprintf("1->iteration %d ..e=
xpected task wake-up....value =A0 =A0 =A0 =A0 %llu \n",i,expected_time);=0A=
=A0=A0=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0xnprintf("1->iteration %d ..actual task=
 wake-up....value =A0 =A0 =A0 =A0 =A0 %llu \n", i, cur_sys_time);=0A=A0 =A0=
 =A0 =A0 =A0 =A0 =A0jitter =3D cur_sys_time - expected_time;=0A=A0 =A0 =A0 =
=A0 =A0// =A0 =A0xnprintf("1->iteration %d ..actual task wake-up....value =
=A0 =A0 =A0 =A0 =A0 %llu \n", i, cur_sys_time);=0A=A0 =A0 =A0 =A0 =A0 =A0 =
=A0xnprintf("1->iteration %d jitter after task wake-up....value %lld \n\n",=
 i, jitter );=0A}//end of while=0AEND:ret =3D 0;=0A=0A}//end of rt_task_1 f=
unction=0A=0A=0A=0A=0A=0Avoid rt_task_2(void *cookie)=0A{=0ART_TASK_INFO rt=
tinfo;=0ARTIME reltime;//to store wokenup time=0ARTIME =A0expected_time=3D0=
,cur_sys_time=3D0,jitter=3D0;=0Aint i;=0Aint tmp_ret;=0Asystime2 =3D rt_tim=
er_read();//read the current system time=0A=A0 =A0 =A0 =A0 xnprintf("2->ini=
tial task system time ....value =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 %llu \n", s=
ystime2);=0A=A0 =A0 =A0 =A0=A0=0A=A0 =A0 =A0 =A0=A0=0A=A0 =A0 =A0 =A0 xnpri=
ntf("2->expected initial task wake up time ..value =A0 =A0 =A0 =A0 %llu \n"=
,task_pstart_time);=0A=A0 =A0 =A0 =A0=A0=0Aret =3D rt_task_set_periodic(NUL=
L, task_pstart_time, PERIOD_2);=0Aif(ret<0) { xnprintf("2->error in rt_task=
_set_periodic() =A0%d ...\n",ret); return ;}=0A=0Asystime2 =3D rt_timer_rea=
d();//read the current system time=0A=A0 =A0 =A0 =A0 xnprintf("2->actual sy=
stem time after first task wake-up...value%llu \n",=A0=0A=A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 systime2);=0A=A0 =A0 =A0 =A0=A0=0A=A0 =A0 =A0 =A0 xnpri=
ntf("2->initial jitter after first task wake-up....value =A0 %lld \n",=A0=
=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 systime2-task_pstart_time);=0A=0A=0A=
for(i=3D1; i<=3DNO_ITERATION; ++i){=0Art_task_wait_period(NULL);=0A=0A=A0 =
=A0 =A0 =A0 =A0 =A0 =A0cur_sys_time =3D rt_timer_read();//read the sys_time=
=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0expected_time =3D task_pstart_time + i*PERIOD=
_2;=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0xnprintf("2->iteration %d ..expected task =
wake-up....value =A0 =A0 =A0 =A0 %llu \n",i,expected_time);=0A=A0 =A0 =A0=
=A0=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0xnprintf("2->iteration %d ..actual task wa=
ke-up....value =A0 =A0 =A0 =A0 =A0 %llu \n", i, cur_sys_time);=0A=A0 =A0 =
=A0 =A0 =A0 =A0 =A0jitter =3D cur_sys_time - expected_time;=0A=A0 =A0 =A0 =
=A0 =A0 =A0 =A0xnprintf("2->iteration %d jitter after task wake-up....value=
 %lld \n\n", i, jitter );=0A}//end of while=0AEND:ret =3D 0;=0A=0A}//end of=
 rt_task_2 function=0A=0A=0A=0Avoid rt_task_3(void *cookie)=0A{=0ART_TASK_I=
NFO rttinfo;=0ARTIME reltime;//to store wokenup time=0ARTIME =A0expected_ti=
me=3D0,cur_sys_time=3D0,jitter=3D0;=0Aint i;=0Aint tmp_ret;=0Asystime2 =3D =
rt_timer_read();//read the current system time=0A=A0 =A0 =A0 =A0 xnprintf("=
3->initial task system time ....value =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 %llu =
\n", systime2);=0A=A0 =A0 =A0 =A0=A0=0A=A0 =A0 =A0 =A0=A0=0A=A0 =A0 =A0 =A0=
 xnprintf("3->expected initial task wake up time ..value =A0 =A0 =A0 =A0 %l=
lu \n",task_pstart_time);=0A=A0 =A0 =A0 =A0=A0=0Aret =3D rt_task_set_period=
ic(NULL, task_pstart_time, PERIOD_3);=0Aif(ret<0) { xnprintf("3->error in r=
t_task_set_periodic() =A0%d ...\n",ret); return ;}=0A=0Asystime2 =3D rt_tim=
er_read();//read the current system time=0A=A0 =A0 =A0 =A0 xnprintf("3->act=
ual system time after first task wake-up...value%llu \n",=A0=0A=A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 systime2);=0A=A0 =A0 =A0 =A0=A0=0A=A0 =A0 =A0 =A0 x=
nprintf("3->initial jitter after first task wake-up....value =A0 %lld \n",=
=A0=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 systime2-task_pstart_time);=0A=0A=
=0Afor(i=3D1; i<=3DNO_ITERATION; ++i){=0Art_task_wait_period(NULL);=0A=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0cur_sys_time =3D rt_timer_read();//read the sys_=
time=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0expected_time =3D task_pstart_time + i*PE=
RIOD_3;=0A=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0xnprintf("3->iteration %d ..expecte=
d task wake-up....value =A0 =A0 =A0 =A0 %llu \n",i,expected_time);=0A=A0=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0xnprintf("3->iteration %d ..actual task wake-up.=
...value =A0 =A0 =A0 =A0 =A0 %llu \n", i, cur_sys_time);=0A=A0 =A0 =A0 =A0 =
=A0 =A0 =A0jitter =3D cur_sys_time - expected_time;=0A=A0 =A0 =A0 =A0 =A0 =
=A0 xnprintf("3->iteration %d jitter after task wake-up....value %lld \n\n"=
, i, jitter );=0A}//end of while=0AEND:ret =3D 0;=0A=0A}//end of rt_task_3 =
function=0A=0A=0A=0Avoid rt_task_4(void *cookie)=0A{=0ART_TASK_INFO rttinfo=
;=0ARTIME reltime;//to store wokenup time=0ARTIME =A0expected_time=3D0,cur_=
sys_time=3D0,jitter=3D0;=0Aint i;=0Aint tmp_ret;=0Asystime2 =3D rt_timer_re=
ad();//read the current system time=0A=A0 =A0 =A0 =A0 xnprintf("4->initial =
task system time ....value =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 %llu \n", systim=
e2);=0A=A0 =A0 =A0 =A0=A0=0A=A0 =A0 =A0 =A0=A0=0A=A0 =A0 =A0 =A0 xnprintf("=
4->expected initial task wake up time ..value =A0 =A0 =A0 =A0 %llu \n",task=
_pstart_time);=0A=A0 =A0 =A0 =A0=A0=0Aret =3D rt_task_set_periodic(NULL, ta=
sk_pstart_time, PERIOD_4);=0Aif(ret<0) { xnprintf("4->error in rt_task_set_=
periodic() =A0%d ...\n",ret); return ;}=0A=0Asystime2 =3D rt_timer_read();/=
/read the current system time=0A=A0 =A0 =A0 =A0 xnprintf("4->actual system =
time after first task wake-up...value%llu \n",=A0=0A=A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 systime2);=0A=A0 =A0 =A0 =A0=A0=0A=A0 =A0 =A0 =A0 xnprintf("4-=
>initial jitter after first task wake-up....value =A0 %lld \n",=A0=0A=A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 systime2-task_pstart_time);=0A=0A=0Afor(i=
=3D1; i<=3DNO_ITERATION; ++i){=0Art_task_wait_period(NULL);=0A=0A=A0 =A0 =
=A0 =A0 =A0 =A0 =A0cur_sys_time =3D rt_timer_read();//read the sys_time=0A=
=A0 =A0 =A0 =A0 =A0 =A0 expected_time =3D task_pstart_time + i*PERIOD_4;=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0xnprintf("4->iteration %d ..expected task wake-u=
p....value =A0 =A0 =A0 =A0 %llu \n",i,expected_time);=0A=A0=0A=A0 =A0 =A0 =
=A0 =A0 =A0 =A0xnprintf("4->iteration %d ..actual task wake-up....value =A0=
 =A0 =A0 =A0 =A0 %llu \n", i, cur_sys_time);=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0j=
itter =3D cur_sys_time - expected_time;=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0xnprin=
tf("4->iteration %d jitter after task wake-up....value %lld \n\n", i, jitte=
r );=0A}//end of while=0AEND:ret =3D 0;=0A=0A}//end of rt_task_4 function=
=0A=0A=0A=0Avoid rt_task_5(void *cookie)=0A{=0ART_TASK_INFO rttinfo;=0ARTIM=
E reltime;//to store wokenup time=0ARTIME =A0expected_time=3D0,cur_sys_time=
=3D0,jitter=3D0;=0Aint i;=0Aint tmp_ret;=0Asystime2 =3D rt_timer_read();//r=
ead the current system time=0A=A0 =A0 =A0 =A0 xnprintf("5->initial task sys=
tem time ....value =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 %llu \n", systime2);=0A=
=A0 =A0 =A0 =A0=A0=0A=A0 =A0 =A0 =A0=A0=0A=A0 =A0 =A0 =A0 xnprintf("5->expe=
cted initial task wake up time ..value =A0 =A0 =A0 =A0 %llu \n",task_pstart=
_time);=0A=A0 =A0 =A0 =A0=A0=0Aret =3D rt_task_set_periodic(NULL, task_psta=
rt_time, PERIOD_5);=0Aif(ret<0) { xnprintf("5->error in rt_task_set_periodi=
c() =A0%d ...\n",ret); return ;}=0A=0Asystime2 =3D rt_timer_read();//read t=
he current system time=0A=A0 =A0 =A0 =A0 xnprintf("5->actual system time af=
ter first task wake-up...value%llu \n",=A0=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 systime2);=0A=A0 =A0 =A0 =A0=A0=0A=A0 =A0 =A0 =A0 xnprintf("5->init=
ial jitter after first task wake-up....value =A0 %lld \n",=A0=0A=A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 systime2-task_pstart_time);=0A=0A=0Afor(i=3D1; i<=
=3DNO_ITERATION; ++i){=0Art_task_wait_period(NULL);=0A=0A=A0 =A0 =A0 =A0 =
=A0 =A0 =A0cur_sys_time =3D rt_timer_read();//read the sys_time=0A=A0 =A0 =
=A0 =A0 =A0 =A0 =A0expected_time =3D task_pstart_time + i*PERIOD_5;=0A=A0 =
=A0 =A0 =A0 =A0 =A0 =A0xnprintf("5->iteration %d ..expected task wake-up...=
.value =A0 =A0 =A0 =A0 %llu \n",i,expected_time);=0A=0A=A0 =A0 =A0 =A0 =A0 =
=A0 =A0xnprintf("5->iteration %d ..actual task wake-up....value =A0 =A0 =A0=
 =A0 =A0 %llu \n", i, cur_sys_time);=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0jitter =
=3D cur_sys_time - expected_time;=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0xnprintf("5-=
>iteration %d jitter after task wake-up....value %lld \n\n", i, jitter );=
=0A}//end of while=0AEND:ret =3D 0;=0A=0A}//end of rt_task_5 function=0A=0A=
=0A=0A=0A=0Achar *rt_task_name[NO_TASK]=3D{"rt_task_1", "rt_task_2", "rt_ta=
sk_3", "rt_task_4", "rt_task_5"};=0Aint rt_task_prio[NO_TASK] =3D {5, 5, 5,=
 5, 5};//set the priority for each task=0Avoid(*rt_task_body[NO_TASK])(void=
 *cookie) =3D {rt_task_1, rt_task_2, rt_task_3, rt_task_4, rt_task_5};=0Ain=
t init_module()=0A{=0Aint i;=0Aret =3D 0;=0A#if ONE_SHOT_MODE =3D=3D 1=0Are=
t =3D rt_timer_set_mode(TM_ONESHOT);=0Axnprintf("timer base in one-shot mod=
e =A0***********");=0A#else=0Aret =3D rt_timer_set_mode(SETUP_TICK_NSEC);=
=0Axnprintf("timer base in periodic mode =A0*********");=0A#endif=0Aif(ret<=
0) {=0Axnprintf("error in rt_timer_set_mode()...\n");=0Areturn ret;=0A}=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=0A=A0 =A0 =A0 =A0 systime1 =3D rt_timer_=
read(); =A0//get system time=A0=0Atask_pstart_time =3D systime1+WAKE_TIME;=
=0A=A0 =A0 =A0 =A0 xnprintf("init...system time value =A0%llu \n", systime1=
);=0A=0Afor(i=3D0; i<NO_TASK; ++i) {=0A//create task=0A=A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 //=0Aret =3D rt_task_create(&task_desc[i], rt_task_name[i], TAS=
K_STKSZ, rt_task_prio[i], TASK_MODE);=0Aif(ret<0) {xnprintf("error in rt_ta=
sk_create()_1...\n"); return ret;}=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 //star=
t task=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 //=0Aret =3D rt_task_start(&task_d=
esc[i], rt_task_body[i], NULL);=0Aif(ret<0) {=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xnprintf("error in rt_task_start()_1...\n");=
=A0=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rt_task_delet=
e(&task_desc[i]);=A0=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 return ret;=0A=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }=0A}//en=
d of for_loop=0A=0Axnprintf("end of init_module()...\n");=0Areturn 0;=0A}//=
end of init_module=0A=0Avoid cleanup_module()=0A{=0Aint i;=0Afor(i=3D0; i<N=
O_TASK; ++i)=0A{=0Aret =3D rt_task_delete(&task_desc[i]);=0Aif(ret<0 && ret=
!=3D -EINVAL)=A0=0Axnprintf("error in rt_task_delete()_1...\n");=0A}=0A=0A=
=0A}//end of cleanup_module=0A=0A=0A---End of code=0A=0AHere as all the tas=
k are having same priority. So when expected wake-up time of more than one =
task is same, in such case which task will wake-up first can not be predict=
ed. But as per the output (shown below), the task with higher priority=A0=
=A0is woken-up first----WHY SO??????=0A=0A=0AOutput of above code (I have s=
hown here few of the iterations)=0A=0A=0A[ 1021.907885] Xenomai: timer base=
 in one-shot mode =A0***********=0A[ 1021.907888] Xenomai: init...system ti=
me value =A01343517552907502766=A0=0A[ 1021.907902] Xenomai: 1->initial tas=
k system time ....value =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1343517552907513332=
=A0=0A[ 1021.907904] Xenomai: 1->expected initial task wake up time ..value=
 =A0 =A0 =A0 =A0 1343517553107502766=A0=0A[ 1021.907910] Xenomai: 2->initia=
l task system time ....value =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 13435175529075=
23652=A0=0A[ 1021.907912] Xenomai: 2->expected initial task wake up time ..=
value =A0 =A0 =A0 =A0 1343517553107502766=A0=0A[ 1021.907918] Xenomai: 3->i=
nitial task system time ....value =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 134351755=
2907531443=A0=0A[ 1021.907920] Xenomai: 3->expected initial task wake up ti=
me ..value =A0 =A0 =A0 =A0 1343517553107502766=A0=0A[ 1021.907926] Xenomai:=
 4->initial task system time ....value =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1343=
517552907539224=A0=0A[ 1021.907928] Xenomai: 4->expected initial task wake =
up time ..value =A0 =A0 =A0 =A0 1343517553107502766=A0=0A[ 1021.907933] Xen=
omai: 5->initial task system time ....value =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 1343517552907546834=A0=0A[ 1021.907935] Xenomai: 5->expected initial task =
wake up time ..value =A0 =A0 =A0 =A0 1343517553107502766=A0=0A[ 1021.907937=
] Xenomai: end of init_module()...=0A[ 1022.107903] Xenomai: 1->actual syst=
em time after first task wake-up...value1343517553107504736=A0=0A[ 1022.107=
906] Xenomai: 1->initial jitter after first task wake-up....value =A0 1970=
=A0=0A[ 1022.107909] Xenomai: 2->actual system time after first task wake-u=
p...value1343517553107508839=A0=0A[ 1022.107911] Xenomai: 2->initial jitter=
 after first task wake-up....value =A0 6073=A0=0A[ 1022.107913] Xenomai: 3-=
>actual system time after first task wake-up...value1343517553107510938=A0=
=0A[ 1022.107916] Xenomai: 3->initial jitter after first task wake-up....va=
lue =A0 8172=A0=0A[ 1022.107918] Xenomai: 4->actual system time after first=
 task wake-up...value1343517553107512833=A0=0A[ 1022.107920] Xenomai: 4->in=
itial jitter after first task wake-up....value =A0 10067=A0=0A[ 1022.107923=
] Xenomai: 5->actual system time after first task wake-up...value1343517553=
107514827=A0=0A[ 1022.107925] Xenomai: 5->initial jitter after first task w=
ake-up....value =A0 12061=A0=0A[ 1022.108889] Xenomai: 1->iteration 1 ..exp=
ected task wake-up....value =A0 =A0 =A0 =A0 1343517553108502766=A0=0A[ 1022=
.108892] Xenomai: 1->iteration 1 ..actual task wake-up....value =A0 =A0 =A0=
 =A0 =A0 1343517553108501087=A0=0A[ 1022.108893] Xenomai: 1->iteration 1 ji=
tter after task wake-up....value -1679=A0=0A[ 1022.108894]=A0<--Here first =
task2(2ms) than task1(1ms)??=0A[ 1022.109894] Xenomai: 2->iteration 1 ..exp=
ected task wake-up....value =A0 =A0 =A0 =A0 1343517553109502766=A0=0A[ 1022=
.109897] Xenomai: 2->iteration 1 ..actual task wake-up....value =A0 =A0 =A0=
 =A0 =A0 1343517553109501863=A0=0A[ 1022.109900] Xenomai: 2->iteration 1 ji=
tter after task wake-up....value -903=A0=0A[ 1022.109901]=A0=0A[ 1022.10990=
3] Xenomai: 1->iteration 2 ..expected task wake-up....value =A0 =A0 =A0 =A0=
 1343517553109502766=A0=0A[ 1022.109905] Xenomai: 1->iteration 2 ..actual t=
ask wake-up....value =A0 =A0 =A0 =A0 =A0 1343517553109505481=A0=0A[ 1022.10=
9908] Xenomai: 1->iteration 2 jitter after task wake-up....value 2715=A0=0A=
[ 1022.109909]=A0=A0<--Here first task3(3ms) than task1(1ms)??=0A[ 1022.110=
894] Xenomai: 3->iteration 1 ..expected task wake-up....value =A0 =A0 =A0 =
=A0 1343517553110502766=A0=0A[ 1022.110897] Xenomai: 3->iteration 1 ..actua=
l task wake-up....value =A0 =A0 =A0 =A0 =A0 1343517553110501886=A0=0A[ 1022=
.110899] Xenomai: 3->iteration 1 jitter after task wake-up....value -880=A0=
=0A[ 1022.110901]=A0=0A[ 1022.110903] Xenomai: 1->iteration 3 ..expected ta=
sk wake-up....value =A0 =A0 =A0 =A0 1343517553110502766=A0=0A[ 1022.110905]=
 Xenomai: 1->iteration 3 ..actual task wake-up....value =A0 =A0 =A0 =A0 =A0=
 1343517553110505324=A0=0A[ 1022.110907] Xenomai: 1->iteration 3 jitter aft=
er task wake-up....value 2558=A0=0A[ 1022.110909]=A0=A0<--Here first task4(=
4ms), task2(2ms) than task1(1ms)??=0A[ 1022.111897] Xenomai: 4->iteration 1=
 ..expected task wake-up....value =A0 =A0 =A0 =A0 1343517553111502766=A0=0A=
[ 1022.111900] Xenomai: 4->iteration 1 ..actual task wake-up....value =A0 =
=A0 =A0 =A0 =A0 1343517553111501967=A0=0A[ 1022.111902] Xenomai: 4->iterati=
on 1 jitter after task wake-up....value -799=A0=0A[ 1022.111903]=A0=0A[ 102=
2.111905] Xenomai: 2->iteration 2 ..expected task wake-up....value =A0 =A0 =
=A0 =A0 1343517553111502766=A0=0A[ 1022.111907] Xenomai: 2->iteration 2 ..a=
ctual task wake-up....value =A0 =A0 =A0 =A0 =A0 1343517553111505589=A0=0A[ =
1022.111910] Xenomai: 2->iteration 2 jitter after task wake-up....value 282=
3=A0=0A[ 1022.111911]=A0=0A[ 1022.111913] Xenomai: 1->iteration 4 ..expecte=
d task wake-up....value =A0 =A0 =A0 =A0 1343517553111502766=A0=0A[ 1022.111=
915] Xenomai: 1->iteration 4 ..actual task wake-up....value =A0 =A0 =A0 =A0=
 =A0 1343517553111508100=A0=0A[ 1022.111918] Xenomai: 1->iteration 4 jitter=
 after task wake-up....value 5334=A0=0A[ 1022.111919]=A0=0A[ 1022.112891] X=
enomai: 5->iteration 1 ..expected task wake-up....value =A0 =A0 =A0 =A0 134=
3517553112502766=A0=0A[ 1022.112893] Xenomai: 5->iteration 1 ..actual task =
wake-up....value =A0 =A0 =A0 =A0 =A0 1343517553112501104=A0=0A[ 1022.112895=
] Xenomai: 5->iteration 1 jitter after task wake-up....value -1662=A0=0A[ 1=
022.112896]=A0=0A[ 1022.112897] Xenomai: 1->iteration 5 ..expected task wak=
e-up....value =A0 =A0 =A0 =A0 1343517553112502766=A0=0A[ 1022.112899] Xenom=
ai: 1->iteration 5 ..actual task wake-up....value =A0 =A0 =A0 =A0 =A0 13435=
17553112503723=A0=0A[ 1022.112901] Xenomai: 1->iteration 5 jitter after tas=
k wake-up....value 957=A0=0A[ 1022.112902]=A0=0A=0A=0A=0A=0A=0AFor second s=
etup.....=0ATask period 100us, 200us, 300us, 400us, 500us=0A=0AIn the first=
 code modify the task period as below=0A=0A/*=0A#define PERIOD_1(m_NSEC*1)=
=0A#define PERIOD_2(m_NSEC*2)=0A#define PERIOD_3(m_NSEC*3)=0A#define PERIOD=
_4(m_NSEC*4)=0A#define PERIOD_5(m_NSEC*5)=0A*/=0A=0A#define PERIOD_1(u_NSEC=
*100)=0A#define PERIOD_2(u_NSEC*200)=0A#define PERIOD_3(u_NSEC*300)=0A#defi=
ne PERIOD_4(u_NSEC*400)=0A#define PERIOD_5(u_NSEC*500)=0A=0A=0AHere regardi=
ng to the task wake-up, i am not getting any relation like in previous case=
 which was with respect to the period but the any number of time i load the=
 module it is giving same seuence which should not happen as all the task a=
re having same priority?????=0A=0A=0A=0A[ 1304.914062] Xenomai: timer base =
in one-shot mode =A0***********=0A[ 1304.914066] Xenomai: init...system tim=
e value =A01343517835913573705=A0=0A[ 1304.914079] Xenomai: 1->initial task=
 system time ....value =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1343517835913584110=
=A0=0A[ 1304.914081] Xenomai: 1->expected initial task wake up time ..value=
 =A0 =A0 =A0 =A0 1343517836113573705=A0=0A[ 1304.914088] Xenomai: 2->initia=
l task system time ....value =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 13435178359135=
94547=A0=0A[ 1304.914090] Xenomai: 2->expected initial task wake up time ..=
value =A0 =A0 =A0 =A0 1343517836113573705=A0=0A[ 1304.914096] Xenomai: 3->i=
nitial task system time ....value =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 134351783=
5913602454=A0=0A[ 1304.914097] Xenomai: 3->expected initial task wake up ti=
me ..value =A0 =A0 =A0 =A0 1343517836113573705=A0=0A[ 1304.914103] Xenomai:=
 4->initial task system time ....value =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1343=
517835913610031=A0=0A[ 1304.914105] Xenomai: 4->expected initial task wake =
up time ..value =A0 =A0 =A0 =A0 1343517836113573705=A0=0A[ 1304.914111] Xen=
omai: 5->initial task system time ....value =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 1343517835913617629=A0=0A[ 1304.914112] Xenomai: 5->expected initial task =
wake up time ..value =A0 =A0 =A0 =A0 1343517836113573705=A0=0A[ 1304.914114=
] Xenomai: end of init_module()...=0A[ 1305.114082] Xenomai: 1->actual syst=
em time after first task wake-up...value1343517836113575411=A0=0A[ 1305.114=
085] Xenomai: 1->initial jitter after first task wake-up....value =A0 1706=
=A0=0A[ 1305.114088] Xenomai: 2->actual system time after first task wake-u=
p...value1343517836113580708=A0=0A[ 1305.114090] Xenomai: 2->initial jitter=
 after first task wake-up....value =A0 7003=A0=0A[ 1305.114093] Xenomai: 3-=
>actual system time after first task wake-up...value1343517836113582777=A0=
=0A[ 1305.114095] Xenomai: 3->initial jitter after first task wake-up....va=
lue =A0 9072=A0=0A[ 1305.114097] Xenomai: 4->actual system time after first=
 task wake-up...value1343517836113584717=A0=0A[ 1305.114100] Xenomai: 4->in=
itial jitter after first task wake-up....value =A0 11012=A0=0A[ 1305.114102=
] Xenomai: 5->actual system time after first task wake-up...value1343517836=
113586696=A0=0A[ 1305.114104] Xenomai: 5->initial jitter after first task w=
ake-up....value =A0 12991=A0=0A[ 1305.114167] Xenomai: 1->iteration 1 ..exp=
ected task wake-up....value =A0 =A0 =A0 =A0 1343517836113673705=A0=0A[ 1305=
.114170] Xenomai: 1->iteration 1 ..actual task wake-up....value =A0 =A0 =A0=
 =A0 =A0 1343517836113671710=A0=0A[ 1305.114172] Xenomai: 1->iteration 1 ji=
tter after task wake-up....value -1995=A0=0A[ 1305.114173]=A0=0A[ 1305.1142=
69] Xenomai: 1->iteration 2 ..expected task wake-up....value =A0 =A0 =A0 =
=A0 1343517836113773705=A0=0A[ 1305.114272] Xenomai: 1->iteration 2 ..actua=
l task wake-up....value =A0 =A0 =A0 =A0 =A0 1343517836113771737=A0=0A[ 1305=
.114274] Xenomai: 1->iteration 2 jitter after task wake-up....value -1968=
=A0=0A[ 1305.114275]=A0=0A[ 1305.114277] Xenomai: 2->iteration 1 ..expected=
 task wake-up....value =A0 =A0 =A0 =A0 1343517836113773705=A0=0A[ 1305.1142=
80] Xenomai: 2->iteration 1 ..actual task wake-up....value =A0 =A0 =A0 =A0 =
=A0 1343517836113774504=A0=0A[ 1305.114282] Xenomai: 2->iteration 1 jitter =
after task wake-up....value 799=A0=0A[ 1305.114283]=A0=0A[ 1305.114369] Xen=
omai: 1->iteration 3 ..expected task wake-up....value =A0 =A0 =A0 =A0 13435=
17836113873705=A0=0A[ 1305.114371] Xenomai: 1->iteration 3 ..actual task wa=
ke-up....value =A0 =A0 =A0 =A0 =A0 1343517836113871673=A0=0A[ 1305.114374] =
Xenomai: 1->iteration 3 jitter after task wake-up....value -2032=A0=0A[ 130=
5.114375]=A0=0A[ 1305.114377] Xenomai: 3->iteration 1 ..expected task wake-=
up....value =A0 =A0 =A0 =A0 1343517836113873705=A0=0A[ 1305.114379] Xenomai=
: 3->iteration 1 ..actual task wake-up....value =A0 =A0 =A0 =A0 =A0 1343517=
836113874284=A0=0A[ 1305.114382] Xenomai: 3->iteration 1 jitter after task =
wake-up....value 579=A0=0A[ 1305.114383]=A0=0A[ 1305.114471] Xenomai: 1->it=
eration 4 ..expected task wake-up....value =A0 =A0 =A0 =A0 1343517836113973=
705=A0=0A[ 1305.114474] Xenomai: 1->iteration 4 ..actual task wake-up....va=
lue =A0 =A0 =A0 =A0 =A0 1343517836113971733=A0=0A[ 1305.114476] Xenomai: 1-=
>iteration 4 jitter after task wake-up....value -1972=A0=0A[ 1305.114478]=
=A0=0A[ 1305.114479] Xenomai: 4->iteration 1 ..expected task wake-up....val=
ue =A0 =A0 =A0 =A0 1343517836113973705=A0=0A[ 1305.114482] Xenomai: 4->iter=
ation 1 ..actual task wake-up....value =A0 =A0 =A0 =A0 =A0 1343517836113974=
325=A0=0A[ 1305.114484] Xenomai: 4->iteration 1 jitter after task wake-up..=
..value 620=A0=0A[ 1305.114485]=A0=0A[ 1305.114487] Xenomai: 2->iteration 2=
 ..expected task wake-up....value =A0 =A0 =A0 =A0 1343517836113973705=A0=0A=
[ 1305.114490] Xenomai: 2->iteration 2 ..actual task wake-up....value =A0 =
=A0 =A0 =A0 =A0 1343517836113976729=A0=0A[ 1305.114492] Xenomai: 2->iterati=
on 2 jitter after task wake-up....value 3024=A0=0A[ 1305.114493]=A0=0A[ 130=
5.114569] Xenomai: 1->iteration 5 ..expected task wake-up....value =A0 =A0 =
=A0 =A0 1343517836114073705=A0=0A[ 1305.114572] Xenomai: 1->iteration 5 ..a=
ctual task wake-up....value =A0 =A0 =A0 =A0 =A0 1343517836114071663=A0=0A[ =
1305.114574] Xenomai: 1->iteration 5 jitter after task wake-up....value -20=
42=A0=0A[ 1305.114575]=A0=0A[ 1305.114577] Xenomai: 5->iteration 1 ..expect=
ed task wake-up....value =A0 =A0 =A0 =A0 1343517836114073705=A0=0A[ 1305.11=
4580] Xenomai: 5->iteration 1 ..actual task wake-up....value =A0 =A0 =A0 =
=A0 =A0 1343517836114074334=A0=0A[ 1305.114582] Xenomai: 5->iteration 1 jit=
ter after task wake-up....value 629=A0=0A[ 1305.114583]=A0=0A[ 1305.114669]=
 Xenomai: 1->iteration 6 ..expected task wake-up....value =A0 =A0 =A0 =A0 1=
343517836114173705=A0=0A[ 1305.114671] Xenomai: 1->iteration 6 ..actual tas=
k wake-up....value =A0 =A0 =A0 =A0 =A0 1343517836114171632=A0=0A[ 1305.1146=
73] Xenomai: 1->iteration 6 jitter after task wake-up....value -2073=A0=0A[=
 1305.114674]=A0=0A=0A=0A=0ASo can you help me understand the wake-up of ta=
sk for both cases.
