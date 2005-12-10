Message-ID: <439AB3B6.2080503@domain.hid>
Date: Sat, 10 Dec 2005 11:53:42 +0100
From: Paolo Gai <pj@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai 2.0.1 - Posix Skin - realtime priorities
	-	what I'm doing wrong?
References: <439995C0.6030006@domain.hid>	<200512091650.11637.schwab@domain.hid>	<17305.51026.541872.815402@domain.hid>	<4399E716.8060502@domain.hid>
	<17305.63307.340805.330709@domain.hid>
In-Reply-To: <17305.63307.340805.330709@domain.hid>
Content-Type: multipart/mixed; boundary="------------070206070905020606050007"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------070206070905020606050007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:

>Paolo Gai wrote:
> > Gilles Chanteperdrix wrote:
> > >Working around this issue means using calls to unlocked versions of =
libc
> > >functions protected with Xenomai POSIX mutexes, such as, for example=
,
> > >myputs and myputchar (sufficient for Paolo example) defined as :
> > >[...]
> > > =20
> > >
> > Ok! I tried it, and I also tried another slightly modified version of=
=20
> > the demo, that simply replaces putchars with an unprotected array of =

> > chars (let's suppose there are no race conditions) that is printed ou=
t=20
> > to stdout at the end of the game.
>
>There is no race condition in the SCHED_FIFO case or ahem, there should
>be none.
>
Yes, that's true...

> Please also note that the "volatile" qualifier seem misplaced
>in your declaration of buf_current, it may matter since the compiler
>will probably inline calls to myputchar in the "medium" function, and
>buf_current will end up in a register. But this would have no effect
>only in the SCHED_FIFO case.
> =20
>
Ouch! I just added it in the last tries and I forgot to remove it - sorry=
;
However, I checked the source code produced by the compiler on i386 with =

the default compiler of FC3 and the code produced is the same with and=20
without volatile;

> > the results are the following, where the first part is RR and the sec=
ond=20
> > is FIFO (it's quite strange for me that FIFO has more contect changes=
=20
> > than RR (?))
>
>Please also note that any thread created with the SCHED_RR attribute
>will be a plain Linux thread, and due to a bug in glibc, the thread will=

>use the default policy. The results are strange indeed for SCHED_FIFO,
>it may be a bug, this needs a closer look... Maybe threads are not
>Xenomai threads using SCHED_FIFO policy at all ?
> =20
>
Ok... I've done some more experiments. here are some results, with=20
screenshots :-)

First thing, I found this snippet
http://sources.redhat.com/ml/glibc-bugs/2004-05/msg00003.html
that shows how on Linux and NPTL setting realtime priorities simply=20
fails... I tried it on my FC3, and the behavior is the same, confirming=20
the bug on my distro.

Then, I slightly modified the example of the previous posts, setting the =

thread priorities with pthread_setschedparam.

----------------------------
Case 1/Linux: Printing on the console using stdio, Linux real-time thread=
s

Screenshot:
[root@domain.hid xenomai-demos]# ./ex_rr3
thread id =3D 0xb7f0dbb0, policy =3D SCHED_OTHER, priority =3D 0
thread id =3D 0xb7f0dbb0, policy =3D SCHED_RR, priority =3D 3
=2E..........###########............############...........###########...=
=2E.......###########............############...........###########......=
=2E....###########............############...........###########.........=
=2E..###########...........############...........###########............=
############...........###########...........###########............#####=
#######...........###########...........###########............##########=
##...........###########............###########...........############...=
=2E.......###########............############...........###########......=
=2E....###########.....#####LOW=20
priority thread!!!
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E...............#######################################################=
#########################################################################=
#########################################################################=
#########################################################################=
##########################LOW=20
priority thread!!!
[root@domain.hid xenomai-demos]#

everything is fine, SCHED_RR and SCHED_FIFO works as expected, while the =

demo runs the XServer is freezed.

----------------------------

Case 1/Xenomai: Printing on the console using stdio, Xenomai real-time=20
threads

Screenshot:
[root@domain.hid xenomai-demos]# ./rt_ex_rr3
thread id =3D 0xb7fc7bb0, policy =3D SCHED_OTHER, priority =3D 0
pthread_setschedparam failed: Success
thread id =3D 0xb7fc7bb0, policy =3D SCHED_OTHER, priority =3D 0
pthread_setschedparam failed: Success
pthread_setschedparam failed: Success
=2E....########LOW priority thread!!!
#########################################################################=
#########################................................................=
=2E...................................................###################=
#########################################################################=
######...................................................................=
=2E............................##########################################=
######################################################...................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E........................##############################################=
#########################################################################=
#########################################################################=
#########################################################################=
###################################LOW=20
priority thread!!!
[root@domain.hid xenomai-demos]#

1) why do i get "pthread_setschedparam failed: Success" ?? Why the=20
policy is not changed (am I still calling the Linux functions?)
2) The SCHED_FIFO seems to work as expected, whereas SCHED_RR seems to=20
have a strange behavior when it starts (the low priority thread is=20
started before the others...
3) the XServer freezes but for a SHORTER time - I guess they are the=20
Xenomai threads, one thing I do not understand is why with Linux the=20
XServer stops for around 10 seconds, and in Xenomai less than one second!=
!!

----------------------------

Case 2/Linux: Printing on the console using a shared buffer, Linux=20
real-time threads

Screenshot:
[root@domain.hid xenomai-demos]# ./ex_rr4
thread id =3D 0xb7fcabb0, policy =3D SCHED_OTHER, priority =3D 0
thread id =3D 0xb7fcabb0, policy =3D SCHED_RR, priority =3D 3
=2E............############...........###########...........###########..=
=2E........############............###########...........###########.....=
=2E.....############............###########...........###########........=
=2E..###########............############...........###########...........=
###########...........############............###########...........#####=
######...........############............###########...........##########=
#............############...........###########...........############...=
=2E........###########...........###########...........############......=
=2E.....###########....#####L  =20
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E...............#######################################################=
#########################################################################=
#########################################################################=
#########################################################################=
##########################L
[root@domain.hid xenomai-demos]#

works as expected, the same behavior as Case1/Linux.

----------------------------

Case 2/xenomai: Printing on the console using a shared buffer, Xenomai=20
real-time threads

Screenshot:
[root@domain.hid xenomai-demos]# ./rt_ex_rr4
thread id =3D 0xb7f25bb0, policy =3D SCHED_OTHER, priority =3D 0
pthread_setschedparam failed: Success
thread id =3D 0xb7f25bb0, policy =3D SCHED_OTHER, priority =3D 0
pthread_setschedparam failed: Success
pthread_setschedparam failed: Success
=2E..............#############L..........................................=
=2E......................................................................=
=2E..............................................########################=
#########################################################################=
#################################################################........=
=2E......................................................................=
=2E.............................................#########################=
#########################################################################=
###########################  =20
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E...............#######################################################=
#########################################################################=
#########################################################################=
#########################################################################=
##########################L
[root@domain.hid xenomai-demos]#

Again, the same behavior as before in Case 1/Xenomai

which make me think that
- the behavior on Xenomai does not depend a lot on the fact i called=20
stdio functions
- the SCHED_RR maybe still has some problems (???)



ok, that's all for now, sorry again for the long mail.

Paolo

--------------070206070905020606050007
Content-Type: text/x-csrc;
 name="ex_rr3.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ex_rr3.c"

/*
 * this version uses pthread_setschedparam as a workaround of the
 * glibc bug, prints using stdio
 */


#include <string.h>
#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>

/* for sched_param.c */
#include <sched.h> 

/* --------------------------------------------- */
/* source from http://sources.redhat.com/ml/glibc-bugs/2004-05/msg00003.html */

#define LPRIO  1
#define MPRIO  2
#define HPRIO 3

void show_sched(void)
{
	struct sched_param sp;
	int policy;
	const char *pstr;
	
	if (pthread_getschedparam(pthread_self(), &policy, &sp) != 0) {
		perror("pthread_getschedparam failed");
		return;
	}

	switch(policy) {
		case SCHED_OTHER:
			pstr = "SCHED_OTHER";
			break;
		case SCHED_FIFO:
			pstr = "SCHED_FIFO";
			break;
		case SCHED_RR:
			pstr = "SCHED_RR";
			break;
		default:
			pstr = "unknown";
	}

	printf("thread id = 0x%lx, policy = %s, priority = %d\n",
			pthread_self(), pstr, sp.sched_priority);

	return;
}

void set_sched(int policy, int priority)
{
	struct sched_param schedp;

	memset(&schedp, 0, sizeof(schedp));
	schedp.sched_priority = priority;
	if (pthread_setschedparam(pthread_self(), policy, &schedp) != 0)
		perror("pthread_setschedparam failed");

}

/* --------------------------------------------- */



void *low(void *arg)
{
  set_sched(SCHED_FIFO, LPRIO);
  printf("LOW priority thread!!!\n");
  return NULL;
}

struct medium_par_t {
  int policy;
  char *c;
} mp1, mp2;

void *medium(void *arg)
{
  int i,j;

  struct medium_par_t *p = (struct medium_par_t *)arg;

  set_sched(p->policy, MPRIO);

  for (i=0; i<300; i++) {
    for (j=0; j<1000000; j++) ;
    printf(p->c);
  }

  return NULL;
}

void my_create(int policy)
{
  pthread_t th1, th2, th3;
  pthread_attr_t medium_attr, low_attr;
  struct sched_param medium_policy, low_policy;

  pthread_attr_init(&medium_attr);
  pthread_attr_setschedpolicy(&medium_attr, policy);
  medium_policy.sched_priority = 2;
  pthread_attr_setschedparam(&medium_attr, &medium_policy);

  pthread_attr_init(&low_attr);
  pthread_attr_setschedpolicy(&low_attr, SCHED_FIFO);
  low_policy.sched_priority = 1;
  pthread_attr_setschedparam(&low_attr, &low_policy);

  mp1.policy = mp2.policy = policy;
  mp1.c = ".";
  mp2.c = "#";

  pthread_create(&th1, &medium_attr, medium, (void *)&mp1);
  pthread_create(&th2, &medium_attr, medium, (void *)&mp2);
  pthread_create(&th3, &low_attr, low, NULL);
  
  pthread_attr_destroy(&medium_attr);
  pthread_attr_destroy(&low_attr);

  pthread_join(th1, NULL);
  pthread_join(th2, NULL);
  pthread_join(th3, NULL);
}


void *high(void *arg)
{
  show_sched();
  set_sched(SCHED_RR, HPRIO);
  show_sched();

  /* first experiment:
     - two medium priority thread scheduled with RR
     - one low priority thread scheduled with FIFO
  */
  my_create(SCHED_RR);

  /* second experiment:
     - two medium priority thread scheduled with FIFO
     - one low priority thread scheduled with FIFO
  */
  my_create(SCHED_FIFO);

  return NULL;

}

int main()
{
  pthread_t mythread;
  pthread_attr_t myattr;
  struct sched_param myparam;

  int err;
  int parameter;
  void *returnvalue;

  /* initializes the thread attribute */
  pthread_attr_init(&myattr);
  pthread_attr_setschedpolicy(&myattr, SCHED_FIFO);
  myparam.sched_priority = 3;
  pthread_attr_setschedparam(&myattr, &myparam);

  err = pthread_create(&mythread, &myattr, high, (void *)&parameter);

  if (err) {
    perror("ERROR");
    exit(1);
  }

  pthread_attr_destroy(&myattr);

  /* wait the end of the thread we just created */
  pthread_join(mythread, &returnvalue);

  return 0;
}


--------------070206070905020606050007
Content-Type: text/x-csrc;
 name="ex_rr4.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ex_rr4.c"

/*
 * this version uses pthread_setschedparam as a workaround of the
 * glibc bug, prints using a shared buffer
 */

#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <string.h>

/* for sched_param.c */
#include <sched.h> 


/* --------------------------------------------- */
/* source from http://sources.redhat.com/ml/glibc-bugs/2004-05/msg00003.html */

#define LPRIO  1
#define MPRIO  2
#define HPRIO 3

void show_sched(void)
{
	struct sched_param sp;
	int policy;
	const char *pstr;
	
	if (pthread_getschedparam(pthread_self(), &policy, &sp) != 0) {
		perror("pthread_getschedparam failed");
		return;
	}

	switch(policy) {
		case SCHED_OTHER:
			pstr = "SCHED_OTHER";
			break;
		case SCHED_FIFO:
			pstr = "SCHED_FIFO";
			break;
		case SCHED_RR:
			pstr = "SCHED_RR";
			break;
		default:
			pstr = "unknown";
	}

	printf("thread id = 0x%lx, policy = %s, priority = %d\n",
			pthread_self(), pstr, sp.sched_priority);

	return;
}

void set_sched(int policy, int priority)
{
	struct sched_param schedp;

	memset(&schedp, 0, sizeof(schedp));
	schedp.sched_priority = priority;
	if (pthread_setschedparam(pthread_self(), policy, &schedp) != 0)
		perror("pthread_setschedparam failed");

}

/* --------------------------------------------- */



/* ------------------------------------------------------------ */
/* unprotected buffer to avoid migrations */

char buf[10000];
char *buf_current=buf;

void myputchar(char c)
{
  *buf_current++ = c;
}

void myprintbuf(void)
{
  *buf_current=0;
  puts(buf);
}
/* ------------------------------------------------------------ */


void *low(void *arg)
{
  set_sched(SCHED_FIFO, LPRIO);
  myputchar('L');
  return NULL;
}

struct medium_par_t {
  int policy;
  char *c;
} mp1, mp2;

void *medium(void *arg)
{
  int i,j;

  struct medium_par_t *p = (struct medium_par_t *)arg;

  set_sched(p->policy, MPRIO);

  for (i=0; i<300; i++) {
    for (j=0; j<1000000; j++) ;
    myputchar(p->c[0]);
  }

  return NULL;
}

void my_create(int policy)
{
  pthread_t th1, th2, th3;
  pthread_attr_t medium_attr, low_attr;
  struct sched_param medium_policy, low_policy;

  pthread_attr_init(&medium_attr);
  pthread_attr_setschedpolicy(&medium_attr, policy);
  medium_policy.sched_priority = 2;
  pthread_attr_setschedparam(&medium_attr, &medium_policy);

  pthread_attr_init(&low_attr);
  pthread_attr_setschedpolicy(&low_attr, SCHED_FIFO);
  low_policy.sched_priority = 1;
  pthread_attr_setschedparam(&low_attr, &low_policy);

  mp1.policy = mp2.policy = policy;
  mp1.c = ".";
  mp2.c = "#";

  pthread_create(&th1, &medium_attr, medium, (void *)&mp1);
  pthread_create(&th2, &medium_attr, medium, (void *)&mp2);
  pthread_create(&th3, &low_attr, low, NULL);
  
  pthread_attr_destroy(&medium_attr);
  pthread_attr_destroy(&low_attr);

  pthread_join(th1, NULL);
  pthread_join(th2, NULL);
  pthread_join(th3, NULL);
  
  myputchar(' ');
  myputchar(' ');
  myputchar(' ');
}


void *high(void *arg)
{
  show_sched();
  set_sched(SCHED_RR, HPRIO);
  show_sched();

  /* first experiment:
     - two medium priority thread scheduled with RR
     - one low priority thread scheduled with FIFO
  */
  my_create(SCHED_RR);

  /* second experiment:
     - two medium priority thread scheduled with FIFO
     - one low priority thread scheduled with FIFO
  */
  my_create(SCHED_FIFO);

  return NULL;

}

int main()
{
  pthread_t mythread;
  pthread_attr_t myattr;
  struct sched_param myparam;

  int err;
  void *returnvalue;


  /* initializes the thread attribute */
  pthread_attr_init(&myattr);
  pthread_attr_setschedpolicy(&myattr, SCHED_FIFO);
  myparam.sched_priority = 3;
  pthread_attr_setschedparam(&myattr, &myparam);

  err = pthread_create(&mythread, &myattr, high, NULL);

  if (err) {
    perror("ERROR");
    exit(1);
  }

  pthread_attr_destroy(&myattr);

  /* wait the end of the thread we just created */
  pthread_join(mythread, &returnvalue);

  myprintbuf();

  return 0;
}


--------------070206070905020606050007--

