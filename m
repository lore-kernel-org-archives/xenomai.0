Message-ID: <439AB897.1020304@domain.hid>
Date: Sat, 10 Dec 2005 12:14:31 +0100
From: Paolo Gai <pj@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai 2.0.1 - Posix Skin - realtime priorities
	-	what I'm doing wrong?
References: <439995C0.6030006@domain.hid>	<200512091650.11637.schwab@domain.hid>	<17305.51026.541872.815402@domain.hid>	<4399E716.8060502@domain.hid>	<17305.63307.340805.330709@domain.hid>
	<439AB3B6.2080503@domain.hid>
In-Reply-To: <439AB3B6.2080503@domain.hid>
Content-Type: multipart/mixed; boundary="------------080807060302080408080102"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Paolo Gai <pj@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------080807060302080408080102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Ok, after having clicked ion the send button, I also discovered that=20
NPTL uses INHERIT_SCHED by default in the pthread attributes
http://sources.redhat.com/bugzilla/show_bug.cgi?id=3D145

I added it to the original examples, and I obtained the following=20
(basically it is similar to the Case 1 depicted before...)

Linux Real-Time Threads

[root@domain.hid xenomai-demos]# ./ex_rr
LOW priority thread!!!
=2E..........###########............############...........###########...=
=2E.......###########............############...........###########......=
=2E.....############...........###########...........###########.........=
=2E..############...........###########...........###########............=
############...........###########...........###########............#####=
#######...........###########............############...........#########=
##...........###########............############...........###########...=
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
##########################[root@domain.hid
xenomai-demos]#

--> that's fine;

Xenomai Threads:

[root@domain.hid xenomai-demos]# ./rt_ex_rr
LOW priority thread!!!
=2E....###...............................................................=
=2E................######################################################=
#########################................................................=
=2E..............................########################################=
########################################.................................=
=2E..............................................########################=
#######################################################..................=
=2E.....................................#################################=
##########################...............................................=
=2E......................................................................=
=2E......................................................................=
=2E......................................................................=
=2E.......................................LOW=20
priority thread!!!
#########################################################################=
#########################################################################=
#########################################################################=
#########################################################################=
########[root@domain.hid
xenomai-demos]#

That is not what should be :-(

Again, in this case there may be an additional influence of using the=20
stdio with mutexes and so on...

bye

Paolo



--------------080807060302080408080102
Content-Type: text/x-csrc;
 name="ex_rr.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ex_rr.c"

/*
 * Linux FIFO/RR scheduler demo
 * 
 * This demo creates a few tasks scheduled with the SCHED_FIFO or the
 * SCHED_RR scheduler
 *
 * Copyright (C) 2002 by Paolo Gai
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */


#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>

/* for sched_param.c */
#include <sched.h> 

void *low(void *arg)
{
  printf("LOW priority thread!!!\n");
  return NULL;
}

void *medium(void *arg)
{
  int i,j;

  for (i=0; i<300; i++) {
    for (j=0; j<1000000; j++) ;
    printf((char *)arg);
  }

  return NULL;
}

void my_create(int policy)
{
  pthread_t th1, th2, th3;
  pthread_attr_t medium_attr, low_attr;
  struct sched_param medium_policy, low_policy;

  pthread_attr_init(&medium_attr);
  pthread_attr_setinheritsched(&medium_attr, PTHREAD_EXPLICIT_SCHED);
  pthread_attr_setschedpolicy(&medium_attr, policy);
  medium_policy.sched_priority = 2;
  pthread_attr_setschedparam(&medium_attr, &medium_policy);

  pthread_attr_init(&low_attr);
  pthread_attr_setinheritsched(&medium_attr, PTHREAD_EXPLICIT_SCHED);
  pthread_attr_setschedpolicy(&low_attr, SCHED_FIFO);
  low_policy.sched_priority = 1;
  pthread_attr_setschedparam(&low_attr, &low_policy);

  pthread_create(&th1, &medium_attr, medium, (char *)".");
  pthread_create(&th2, &medium_attr, medium, (char *)"#");
  pthread_create(&th3, &low_attr, low, NULL);
  
  pthread_attr_destroy(&medium_attr);
  pthread_attr_destroy(&low_attr);

  pthread_join(th1, NULL);
  pthread_join(th2, NULL);
  pthread_join(th3, NULL);
}


void *high(void *arg)
{
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
  pthread_attr_setinheritsched(&myattr, PTHREAD_EXPLICIT_SCHED);
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


--------------080807060302080408080102--

