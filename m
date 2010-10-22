Message-ID: <4CC206AE.5010704@domain.hid>
Date: Fri, 22 Oct 2010 17:48:30 -0400
From: Simon Leonard <sleonard@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] SMP load
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


I sort of have a newbie problem regarding getting multiple threads 
running on multiple cores (quad core). It did work on my previous system 
(2.5-rc1) but I can't get it to work with 2.5.5.2 (or 2.5.5.1, 2.5.4). 
Here's my small example:

#include <pthread.h>
void* thread( void* ){
   unsigned long long i=0;
   while( 1 ) i++;
   return NULL;
}

int main(){

   pthread_t tid1, tid2, tid3, tid4;
   pthread_attr_t at1, at2, at3, at4;

   pthread_attr_init( &at1 );
   pthread_attr_init( &at2 );
   pthread_attr_init( &at3 );
   pthread_attr_init( &at4 );

   pthread_create( &tid1, &at1, thread, NULL );
   pthread_create( &tid2, &at2, thread, NULL );
   pthread_create( &tid3, &at3, thread, NULL );
   pthread_create( &tid4, &at4, thread, NULL );

   pthread_join( tid1, NULL );

   return 0;
}

If I compile with
g++ main.cpp -lpthread
and run I get 400% load (4 cores)

If I compile with
g++ main.cpp `/usr/xenomai/bin/xeno-config --skin posix --cflags` 
`/usr/xenomai/bin/xeno-config --skin posix --ldflags`
I only get 100% load (1 core)

Regards.

/sl

