Message-ID: <e39c9190803080255s7020537co8ea96ab71ed6ecc2@domain.hid>
Date: Sat, 8 Mar 2008 11:55:32 +0100
From: "juanba romance" <juanba.romance@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_32535_23281925.1204973733035"
Subject: [Xenomai-help] Posix skin and message queues operation mode
	misunderstanding
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

------=_Part_32535_23281925.1204973733035
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all i am trying to use a POSIX message queue object to interface a
couple of application modules and  i am fully confused.

The execution environment is configured with a fully operational
xenomai-2.4.2 /linux 2.6.24-2 framework

First at all a test program is written/assembled using the librt stuff
without any xenomai component in order to check the "standard POSIX"
behavior
The program works in two modes via input switches
the "r" mode creates a POSIX queue and attach a notifier through the method
SIGEV_THREAD, the main sleeps a while before close the created object
for each callback the notifier empties the queue dumping the values and
register again the callback symbol up to main flow is timed out .
the "w" mode tries to push a pattern data set into the created queue in
burst mode
So one pid empties the queue and the other apply data. The linux domain
version using the librt works at expected.

The weird thing is when we compile the stuff using the xeno-config switches
so we build xenomai domain message queues..
Such stuff doesn't provide any feedback to the notifier symbol of the reader
PID ??
The writer PID however doesn't provide any error relative to queue open/send
system calls

It seems that i am misunderstanding something really basic when these
objects are applied on the Xenomai domain.

Could somebody provide me any hint ?

I attach the test-program below, the stuff is assembled with:
(Standard case ) gcc -Wall mqueue_test.c -o mqueue_test.x -lrt
( Xenomai one  ) gcc -Wall mqueue_test.c `xeno-config --xeno-cflags
--posix-cflags` `xeno-config --xeno-ldflags --posix-ldflags` -o
mqueue_test.x

Cheers

#include <stdlib.>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <mqueue.h>
#include <getopt.h>
#include <unistd.h>
#include <signal.h>

#define __PROBE_QUEUE "/probe-queue"

static void  aux_channel_callback( sigval_t sigval );
static void *attach_writer( );
static void *attach_reader( );
static void helper( char **argv );

static struct sigevent callback_spec = {
  .sigev_notify = SIGEV_THREAD,
  .sigev_notify_function = aux_channel_callback,
  .sigev_notify_attributes = NULL
};
static char mqname[32];
static int no_messages = 0;
static int operation_mode = -1;

typedef enum t_operation_mode{
  __READER_MODE,
  __WRITER_MODE
}t_operation_mode;


static void aux_channel_callback( sigval_t sigval ){
  mqd_t *mqd;
  unsigned priority;
  int value, so_data;

  mqd = ( mqd_t* )( sigval.sival_int );

  do{
    so_data = mq_receive( *mqd, ( void* )( & value ), sizeof( int ), &
priority );
    if( so_data < 0 ){
      printf("%s: %s\n", __func__ , strerror( errno ) );
      break;
    }
    else if ( so_data == 0 )
      break;
    else if( so_data != sizeof( int ) ){
      printf("\n%s: Expected %d versus %d\n", __func__ , so_data, sizeof(
int ) );
      break;
    }
    else
      printf("%d: %s(%d): received value $%08x\n", getpid( ),  __func__ ,
++no_messages, value );
  }while( 1 );

  if( mq_notify( *mqd, ( const struct sigevent* )( & callback_spec ) ) < 0 )
    printf("%s: notify registering FAILURE: %s\n", __func__ , strerror(
errno ) );

  printf("%d: %s T R I G G E R E D\n", getpid( ), __func__ );
  fflush( stdout );
  return;

}


static void helper( char **argv ){

  printf("\n%s usage:\n", argv[ 0 ] );
  printf("\t%-20s: %-20s\n", "-h, --help", "This help");
  printf("\t%-20s: %-20s\n", "-m, --mode", "(w)Writer mode/(r)Reader mode
using notifications based on SIGEV_THREAD" );
  printf("\t%-20s: %-20s\n", "-l, --loop", "the writer loop" );
  fflush( stdout );

}


int main( int argc, char **argv ){
  int c, no_iterations = 1, i, probe_value = 0xdeadbeef;
  extern char *optarg;
  mqd_t *mqd = NULL;
  struct option long_options[] = {
    { "help"  , no_argument, 0, 'h' },
    { "mode", required_argument, 0, 'm'},
    { "loop"  , required_argument, 0, 'l'},
    { 0, 0, 0, 0},
  };

  while ( ( c = getopt_long( argc, argv, "hm:l:",  long_options, NULL )) !=
EOF ){
    switch(c){

    case 'h':
    default:
      helper( argv );
      return( 0 );
      break;

    case 'm' :
      if( *optarg == 'w' ){
    operation_mode = __WRITER_MODE;
    if( ( mqd = ( mqd_t* )attach_writer( ) ) == NULL )
      return( -1 );
      }
      else if ( *optarg == 'r' ){
    operation_mode = __READER_MODE;
    if( ( mqd = ( mqd_t* )attach_reader( ) ) == NULL )
      return( -1 );
      }
      break;

    case 'l':
      no_iterations = atoi( optarg );
      break;
    }
  }

  printf( "%s: test selected: %s", __func__ ,
      operation_mode == __WRITER_MODE ? "W R I T E R" :
      operation_mode == __READER_MODE ? "R E A D E R" : "U N K N O W N" );

  switch( operation_mode ){
  default:
    helper( argv );
    return( -1 );

  case __WRITER_MODE:
    if( mqd ){
      printf( "\n\t%d iterations using pattern $%08x\n", no_iterations,
probe_value );
      fflush( stdout );
      for( i = 0; i < no_iterations; i++ ){
    if( mq_send( *mqd, ( void* )( & probe_value ), sizeof( probe_value ), 0
) < 0 ){
      printf("%s: %d.%d to queue %s: %s\n",
         __func__ , i, probe_value, mqname, strerror( errno ) );
      break;
    }
    probe_value = ~ probe_value;
      }
    }
    break;

  case __READER_MODE:
    printf( "\n\t%s wait activity\n", __func__ );
    fflush( stdout );
    sleep( 200 );
    break;
  }

  if( mqd )
    mq_close( *mqd );
  return( 1 );

}


static void* attach_writer( ){
   static mqd_t mqd;

   snprintf( mqname, sizeof( mqname ), __PROBE_QUEUE );
   mqd = mq_open( mqname, O_WRONLY );
   if( mqd == ( mqd_t )( -1 ) ){
     printf("%s: OPEN queue %s: %s\n", __func__ , mqname, strerror( errno )
);
     fflush( stdout );
     return( NULL );
   }
   return( ( void* )( & mqd ) );

}


static void* attach_reader( ){
  struct mq_attr mqattr;
  static mqd_t mqd;

  mqattr.mq_flags   = 0;
  mqattr.mq_maxmsg  = 100;
  mqattr.mq_msgsize = sizeof( int );
  snprintf( mqname, sizeof( mqname ), __PROBE_QUEUE );
  mqd = mq_open( mqname,  O_RDONLY| O_CREAT| O_EXCL, 0666, & mqattr );
  if( mqd == ( mqd_t )( -1 )  ){
    printf("%s: %s %s: ", __func__ , mqname, strerror( errno ) );
    if( errno == EEXIST ){
      printf("cleaning stuff" );
      mq_unlink( __PROBE_QUEUE );
    }
    printf("\n" );
    fflush( stdout );
    return( ( void* )NULL );

  }
  else{
    callback_spec.sigev_value.sival_int = ( int )( & mqd );
    if( mq_notify( mqd, ( const struct sigevent* )( & callback_spec ) ) < 0
){
      printf("%s: notify registering FAILURE: %s", __func__ , strerror(
errno ) );
    }
    else
      printf("Attached to %s\n",  __PROBE_QUEUE );
  }
  return( ( void* )( & mqd ) );

}

------=_Part_32535_23281925.1204973733035
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all i am trying to use a POSIX message queue object to interface a couple of application modules and&nbsp; i am fully confused.<br><br>The execution environment is configured with a fully operational&nbsp; xenomai-2.4.2 /linux 2.6.24-2 framework <br>
<br>First at all a test program is written/assembled using the librt stuff without any xenomai component in order to check the &quot;standard POSIX&quot; behavior<br>The program works in two modes via input switches <br>the &quot;r&quot; mode creates a POSIX queue and attach a notifier through the method SIGEV_THREAD, the main sleeps a while before close the created object<br>
for each callback the notifier empties the queue dumping the values and register again the callback symbol up to main flow is timed out .<br>the &quot;w&quot; mode tries to push a pattern data set into the created queue in burst mode<br>
So one pid empties the queue and the other apply data. The linux domain version using the librt works at expected.<br><br>The weird thing is when we compile the stuff using the xeno-config switches so we build xenomai domain message queues..<br>
Such stuff doesn&#39;t provide any feedback to the notifier symbol of the reader PID ??<br>The writer PID however doesn&#39;t provide any error relative to queue open/send system calls<br><br>It seems that i am misunderstanding something really basic when these objects are applied on the Xenomai domain. <br>
<br>Could somebody provide me any hint ?<br><br>I attach the test-program below, the stuff is assembled with:<br>(Standard case ) gcc -Wall mqueue_test.c -o mqueue_test.x -lrt<br>( Xenomai one&nbsp; ) gcc -Wall mqueue_test.c `xeno-config --xeno-cflags --posix-cflags` `xeno-config --xeno-ldflags --posix-ldflags` -o mqueue_test.x<br>
<br>Cheers<br><br>#include &lt;stdlib.&gt;<br>#include &lt;stdio.h&gt;<br>#include &lt;string.h&gt;<br>#include &lt;errno.h&gt;<br>#include &lt;mqueue.h&gt;<br>#include &lt;getopt.h&gt;<br>#include &lt;unistd.h&gt;<br>#include &lt;signal.h&gt;<br>
<br>#define __PROBE_QUEUE &quot;/probe-queue&quot;<br><br>static void&nbsp; aux_channel_callback( sigval_t sigval );<br>static void *attach_writer( );<br>static void *attach_reader( );<br>static void helper( char **argv );<br>
<br>static struct sigevent callback_spec = { <br>&nbsp; .sigev_notify = SIGEV_THREAD,<br>&nbsp; .sigev_notify_function = aux_channel_callback,<br>&nbsp; .sigev_notify_attributes = NULL<br>};<br>static char mqname[32]; <br>static int no_messages = 0;<br>
static int operation_mode = -1;<br><br>typedef enum t_operation_mode{<br>&nbsp; __READER_MODE,<br>&nbsp; __WRITER_MODE<br>}t_operation_mode;<br><br><br>static void aux_channel_callback( sigval_t sigval ){<br>&nbsp; mqd_t *mqd;<br>&nbsp; unsigned priority;<br>
&nbsp; int value, so_data;<br>&nbsp; <br>&nbsp; mqd = ( mqd_t* )( sigval.sival_int );<br><br>&nbsp; do{<br>&nbsp;&nbsp;&nbsp; so_data = mq_receive( *mqd, ( void* )( &amp; value ), sizeof( int ), &amp; priority );&nbsp; <br>&nbsp;&nbsp;&nbsp; if( so_data &lt; 0 ){<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;%s: %s\n&quot;, __func__ , strerror( errno ) );<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; else if ( so_data == 0 )<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp; else if( so_data != sizeof( int ) ){<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;\n%s: Expected %d versus %d\n&quot;, __func__ , so_data, sizeof( int ) );<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;%d: %s(%d): received value $%08x\n&quot;, getpid( ),&nbsp; __func__ , ++no_messages, value );<br>&nbsp; }while( 1 );<br><br>&nbsp; if( mq_notify( *mqd, ( const struct sigevent* )( &amp; callback_spec ) ) &lt; 0 )<br>
&nbsp;&nbsp;&nbsp; printf(&quot;%s: notify registering FAILURE: %s\n&quot;, __func__ , strerror( errno ) );<br><br>&nbsp; printf(&quot;%d: %s T R I G G E R E D\n&quot;, getpid( ), __func__ );<br>&nbsp; fflush( stdout );<br>&nbsp; return;<br><br>}<br><br>
<br>static void helper( char **argv ){<br><br>&nbsp; printf(&quot;\n%s usage:\n&quot;, argv[ 0 ] );<br>&nbsp; printf(&quot;\t%-20s: %-20s\n&quot;, &quot;-h, --help&quot;, &quot;This help&quot;);<br>&nbsp; printf(&quot;\t%-20s: %-20s\n&quot;, &quot;-m, --mode&quot;, &quot;(w)Writer mode/(r)Reader mode using notifications based on SIGEV_THREAD&quot; );<br>
&nbsp; printf(&quot;\t%-20s: %-20s\n&quot;, &quot;-l, --loop&quot;, &quot;the writer loop&quot; );<br>&nbsp; fflush( stdout );<br><br>}<br><br><br>int main( int argc, char **argv ){<br>&nbsp; int c, no_iterations = 1, i, probe_value = 0xdeadbeef;<br>
&nbsp; extern char *optarg;<br>&nbsp; mqd_t *mqd = NULL;<br>&nbsp; struct option long_options[] = {<br>&nbsp;&nbsp;&nbsp; { &quot;help&quot;&nbsp; , no_argument, 0, &#39;h&#39; },<br>&nbsp;&nbsp;&nbsp; { &quot;mode&quot;, required_argument, 0, &#39;m&#39;},<br>&nbsp;&nbsp;&nbsp; { &quot;loop&quot;&nbsp; , required_argument, 0, &#39;l&#39;},<br>
&nbsp;&nbsp;&nbsp; { 0, 0, 0, 0},<br>&nbsp; };<br><br>&nbsp; while ( ( c = getopt_long( argc, argv, &quot;hm:l:&quot;,&nbsp; long_options, NULL )) != EOF ){<br>&nbsp;&nbsp;&nbsp; switch(c){<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; case &#39;h&#39;:<br>&nbsp;&nbsp;&nbsp; default:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; helper( argv );<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return( 0 );<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br><br>&nbsp;&nbsp;&nbsp; case &#39;m&#39; :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if( *optarg == &#39;w&#39; ){<br>&nbsp;&nbsp;&nbsp; operation_mode = __WRITER_MODE;<br>&nbsp;&nbsp;&nbsp; if( ( mqd = ( mqd_t* )attach_writer( ) ) == NULL )<br>&nbsp;&nbsp;&nbsp; &nbsp; return( -1 );<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if ( *optarg == &#39;r&#39; ){<br>&nbsp;&nbsp;&nbsp; operation_mode = __READER_MODE;<br>&nbsp;&nbsp;&nbsp; if( ( mqd = ( mqd_t* )attach_reader( ) ) == NULL )<br>&nbsp;&nbsp;&nbsp; &nbsp; return( -1 );<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br><br>&nbsp;&nbsp;&nbsp; case &#39;l&#39;:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no_iterations = atoi( optarg );<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp; }<br><br>&nbsp; printf( &quot;%s: test selected: %s&quot;, __func__ , <br>&nbsp;&nbsp;&nbsp; &nbsp; operation_mode == __WRITER_MODE ? &quot;W R I T E R&quot; : <br>&nbsp;&nbsp;&nbsp; &nbsp; operation_mode == __READER_MODE ? &quot;R E A D E R&quot; : &quot;U N K N O W N&quot; );<br>
&nbsp;&nbsp;&nbsp; &nbsp; <br>&nbsp; switch( operation_mode ){<br>&nbsp; default:<br>&nbsp;&nbsp;&nbsp; helper( argv );<br>&nbsp;&nbsp;&nbsp; return( -1 );<br>&nbsp;&nbsp;&nbsp; <br>&nbsp; case __WRITER_MODE:<br>&nbsp;&nbsp;&nbsp; if( mqd ){<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf( &quot;\n\t%d iterations using pattern $%08x\n&quot;, no_iterations, probe_value ); <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fflush( stdout );<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for( i = 0; i &lt; no_iterations; i++ ){<br>&nbsp;&nbsp;&nbsp; if( mq_send( *mqd, ( void* )( &amp; probe_value ), sizeof( probe_value ), 0&nbsp; ) &lt; 0 ){<br>&nbsp;&nbsp;&nbsp; &nbsp; printf(&quot;%s: %d.%d to queue %s: %s\n&quot;, <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;__func__ , i, probe_value, mqname, strerror( errno ) );<br>&nbsp;&nbsp;&nbsp; &nbsp; break;<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; probe_value = ~ probe_value;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; break;<br><br>&nbsp; case __READER_MODE:<br>&nbsp;&nbsp;&nbsp; printf( &quot;\n\t%s wait activity\n&quot;, __func__ );<br>
&nbsp;&nbsp;&nbsp; fflush( stdout );<br>&nbsp;&nbsp;&nbsp; sleep( 200 );<br>&nbsp;&nbsp;&nbsp; break;<br>&nbsp; }<br><br>&nbsp; if( mqd )<br>&nbsp;&nbsp;&nbsp; mq_close( *mqd );<br>&nbsp; return( 1 );<br><br>}<br><br><br>static void* attach_writer( ){<br>&nbsp;&nbsp; static mqd_t mqd;<br><br>&nbsp;&nbsp; snprintf( mqname, sizeof( mqname ), __PROBE_QUEUE );<br>
&nbsp;&nbsp; mqd = mq_open( mqname, O_WRONLY );<br>&nbsp;&nbsp; if( mqd == ( mqd_t )( -1 ) ){<br>&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;%s: OPEN queue %s: %s\n&quot;, __func__ , mqname, strerror( errno ) );<br>&nbsp;&nbsp;&nbsp;&nbsp; fflush( stdout );<br>&nbsp;&nbsp;&nbsp;&nbsp; return( NULL );<br>&nbsp;&nbsp; }<br>
&nbsp;&nbsp; return( ( void* )( &amp; mqd ) );<br><br>}<br><br><br>static void* attach_reader( ){<br>&nbsp; struct mq_attr mqattr;<br>&nbsp; static mqd_t mqd;<br><br>&nbsp; mqattr.mq_flags&nbsp;&nbsp; = 0;<br>&nbsp; mqattr.mq_maxmsg&nbsp; = 100;<br>&nbsp; mqattr.mq_msgsize = sizeof( int );<br>
&nbsp; snprintf( mqname, sizeof( mqname ), __PROBE_QUEUE );<br>&nbsp; mqd = mq_open( mqname,&nbsp; O_RDONLY| O_CREAT| O_EXCL, 0666, &amp; mqattr );<br>&nbsp; if( mqd == ( mqd_t )( -1 )&nbsp; ){<br>&nbsp;&nbsp;&nbsp; printf(&quot;%s: %s %s: &quot;, __func__ , mqname, strerror( errno ) );<br>
&nbsp;&nbsp;&nbsp; if( errno == EEXIST ){<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;cleaning stuff&quot; );<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mq_unlink( __PROBE_QUEUE );<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; printf(&quot;\n&quot; );<br>&nbsp;&nbsp;&nbsp; fflush( stdout );<br>&nbsp;&nbsp;&nbsp; return( ( void* )NULL );<br><br>&nbsp; }<br>
&nbsp; else{<br>&nbsp;&nbsp;&nbsp; callback_spec.sigev_value.sival_int = ( int )( &amp; mqd );<br>&nbsp;&nbsp;&nbsp; if( mq_notify( mqd, ( const struct sigevent* )( &amp; callback_spec ) ) &lt; 0 ){<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;%s: notify registering FAILURE: %s&quot;, __func__ , strerror( errno ) );<br>
&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;Attached to %s\n&quot;,&nbsp; __PROBE_QUEUE );<br>&nbsp; }<br>&nbsp; return( ( void* )( &amp; mqd ) );<br><br>}<br><br><br><br>

------=_Part_32535_23281925.1204973733035--

