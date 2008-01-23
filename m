Message-ID: <d3f72a390801230120k1412d9acvce5ebdf11b72eb0b@domain.hid>
Date: Wed, 23 Jan 2008 10:20:52 +0100
From: "axel axel" <softaxel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_6091_30986311.1201080052131"
Subject: [Xenomai-core] TASK SCHEDULING E PRIORITY
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_6091_30986311.1201080052131
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

i'm testing xenomai but i have a problem:

i try to run 2 TASKS with the same PRIORITY that never exit out of the cycle
( down there is the code of task )
and never SLEEP but i see with the oscilloscope that the second task never
execute.

I set also round robin mode for the task, with rt_task_set_mode( 0,T_RRB,0
), and xnpod_activate_rr( LATCH ) kernel side.

Which is the problem for you ?

Thanks a lot in advance.

Roberto Bielli

--------------CODE---------------------------------------------------------------------------------------

void task1samePrio (void *cookie)
{
    if( rt_task_set_mode( 0,T_RRB,0 ) != 0 )
    {
        printf( "Error rt_task_set_mode on task3samePrio\n" );
        fflush( stdout );
        return;
    }

     rt_sem_p( &rtSemStartAll, TM_INFINITE );
     rt_sem_v( &rtSemStartAll );


     for (;;) {


        //    P9 on
        *mapp_dout = *mapp_dout | 0x00000004;

        //    P9 off
        *mapp_dout = *mapp_dout & 0xFFFFFFFB;
     }
 }

void task2samePrio (void *cookie)
{

    int err;
    if( rt_task_set_mode( 0,T_RRB,0 ) != 0 )
    {
        printf( "Error rt_task_set_mode on task2samePrio\n" );
        fflush( stdout );
        return;
    }

    rt_sem_p( &rtSemStartAll, TM_INFINITE );
    rt_sem_v( &rtSemStartAll );

     for (;;) {


        //    P8 on
        *mapp_dout = *mapp_dout | 0x00000008;

        //    P8 off
        *mapp_dout = *mapp_dout & 0xFFFFFFF7;

     }
 }

void task3samePrio (void *cookie)
{
    if( rt_task_set_mode( 0,T_RRB,0 ) != 0 )
    {
        printf( "Error rt_task_set_mode on task3samePrio\n" );
        fflush( stdout );
        return;
    }

    rt_sem_p( &rtSemStartAll, TM_INFINITE );
    rt_sem_v( &rtSemStartAll );

     for (;;) {

        //    P7 on
        *mapp_dout = *mapp_dout | 0x00000010;

        //    P7 off
        *mapp_dout = *mapp_dout & 0xFFFFFFEF;

     }
 }


void testPriority( void )
{
     int err;

     err = rt_sem_create( &rtSemStartAll, "rtSemStartAll", 0, S_FIFO );

     if( err != 0 )
     {
        printf( "Error on rt_sem_create rtSemStartAll \n" );
        fflush( stdout );

        return;
     }

     err = rt_task_spawn( &rtTask1prio, "task1prio", 0, 1, 0,
task1samePrio,NULL );
     if( err != 0 )
     {
        printf( "Error on rt_task_spawn rtTask1prio\n" );
        fflush( stdout );

        rt_task_delete(&rtTask1prio);

        return;
     }

     err = rt_task_spawn( &rtTask2prio, "task2prio", 0, 1, 0,
task2samePrio,NULL );
     if( err != 0 )
     {
        printf( "Error on rt_task_spawn rtTask2prio\n" );
        fflush( stdout );

        rt_task_delete(&rtTask2prio);

        return;
     }

     err = rt_task_spawn( &rtTask3prio, "task3prio", 0, 1, 0,
task3samePrio,NULL );
     if( err != 0 )
     {
        printf( "Error on rt_task_spawn rtTask3prio\n" );
        fflush( stdout );

        rt_task_delete(&rtTask3prio);

        return;
     }

     rt_sem_v( &rtSemStartAll );


}

------=_Part_6091_30986311.1201080052131
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>i&#39;m testing xenomai but i have a problem:<br><br>i try to run 2 TASKS with the same PRIORITY that never exit out of the cycle ( down there is the code of task )<br>and never SLEEP but i see with the oscilloscope that the second task never execute. 
<br><br>I set also round robin mode for the task, with rt_task_set_mode( 0,T_RRB,0 ), and xnpod_activate_rr( LATCH ) kernel side.<br><br>Which is the problem for you ?<br><br>Thanks a lot in advance.<br><br>Roberto Bielli
<br><br>--------------CODE---------------------------------------------------------------------------------------<br><br>void task1samePrio (void *cookie)<br>{<br>&nbsp;&nbsp;&nbsp; if( rt_task_set_mode( 0,T_RRB,0 ) != 0 ) <br>&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf( &quot;Error rt_task_set_mode on task3samePrio\n&quot; );<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fflush( stdout );<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; &nbsp;rt_sem_p( &amp;rtSemStartAll, TM_INFINITE );<br>&nbsp;&nbsp;&nbsp; &nbsp;rt_sem_v( &amp;rtSemStartAll );
<br>&nbsp;&nbsp;&nbsp; &nbsp;<br><br>&nbsp;&nbsp;&nbsp;&nbsp; for (;;) {<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp; P9 on<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; *mapp_dout = *mapp_dout | 0x00000004;<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp; P9 off<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; *mapp_dout = *mapp_dout &amp; 0xFFFFFFFB;<br>&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;}<br>
<br>void task2samePrio (void *cookie)<br>{<br><br>&nbsp;&nbsp;&nbsp; int err;<br>&nbsp;&nbsp;&nbsp; if( rt_task_set_mode( 0,T_RRB,0 ) != 0 ) <br>&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf( &quot;Error rt_task_set_mode on task2samePrio\n&quot; );<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fflush( stdout );
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; rt_sem_p( &amp;rtSemStartAll, TM_INFINITE );<br>&nbsp;&nbsp;&nbsp; rt_sem_v( &amp;rtSemStartAll );<br><br>&nbsp;&nbsp;&nbsp;&nbsp; for (;;) {<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp; P8 on<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; *mapp_dout = *mapp_dout | 0x00000008;
<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp; P8 off<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; *mapp_dout = *mapp_dout &amp; 0xFFFFFFF7;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;}<br><br>void task3samePrio (void *cookie)<br>{<br>&nbsp;&nbsp;&nbsp; if( rt_task_set_mode( 0,T_RRB,0 ) != 0 ) <br>&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf( &quot;Error rt_task_set_mode on task3samePrio\n&quot; );
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fflush( stdout );<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; rt_sem_p( &amp;rtSemStartAll, TM_INFINITE );<br>&nbsp;&nbsp;&nbsp; rt_sem_v( &amp;rtSemStartAll );<br><br>&nbsp;&nbsp;&nbsp;&nbsp; for (;;) {<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp; P7 on<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; *mapp_dout = *mapp_dout | 0x00000010;
<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; //&nbsp;&nbsp;&nbsp; P7 off<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; *mapp_dout = *mapp_dout &amp; 0xFFFFFFEF;<br><br>&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;}<br><br><br>void testPriority( void )<br>{<br>&nbsp;&nbsp;&nbsp; &nbsp;int err;<br><br>&nbsp;&nbsp;&nbsp; &nbsp;err = rt_sem_create( &amp;rtSemStartAll, &quot;rtSemStartAll&quot;, 0, S_FIFO );
<br><br>&nbsp;&nbsp;&nbsp; &nbsp;if( err != 0 ) <br>&nbsp;&nbsp;&nbsp; &nbsp;{<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf( &quot;Error on rt_sem_create rtSemStartAll \n&quot; );<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fflush( stdout );<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>&nbsp;&nbsp;&nbsp; &nbsp;}<br><br>&nbsp;&nbsp;&nbsp; &nbsp;err = rt_task_spawn( &amp;rtTask1prio, &quot;task1prio&quot;, 0, 1, 0, task1samePrio,NULL );
<br>&nbsp;&nbsp;&nbsp; &nbsp;if( err != 0 ) <br>&nbsp;&nbsp;&nbsp; &nbsp;{<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf( &quot;Error on rt_task_spawn rtTask1prio\n&quot; );<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fflush( stdout );<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; rt_task_delete(&amp;rtTask1prio);<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>&nbsp;&nbsp;&nbsp; &nbsp;}<br><br>
&nbsp;&nbsp;&nbsp; &nbsp;err = rt_task_spawn( &amp;rtTask2prio, &quot;task2prio&quot;, 0, 1, 0, task2samePrio,NULL );<br>&nbsp;&nbsp;&nbsp; &nbsp;if( err != 0 ) <br>&nbsp;&nbsp;&nbsp; &nbsp;{<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf( &quot;Error on rt_task_spawn rtTask2prio\n&quot; );<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fflush( stdout );
<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; rt_task_delete(&amp;rtTask2prio);<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>&nbsp;&nbsp;&nbsp; &nbsp;}<br><br>&nbsp;&nbsp;&nbsp; &nbsp;err = rt_task_spawn( &amp;rtTask3prio, &quot;task3prio&quot;, 0, 1, 0, task3samePrio,NULL );<br>&nbsp;&nbsp;&nbsp; &nbsp;if( err != 0 ) <br>&nbsp;&nbsp;&nbsp; &nbsp;{
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf( &quot;Error on rt_task_spawn rtTask3prio\n&quot; );<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fflush( stdout );<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; rt_task_delete(&amp;rtTask3prio);<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>&nbsp;&nbsp;&nbsp; &nbsp;}<br><br>&nbsp;&nbsp;&nbsp; &nbsp;rt_sem_v( &amp;rtSemStartAll );
<br>&nbsp;&nbsp;&nbsp; &nbsp;<br><br>}<br><br><br><br>

------=_Part_6091_30986311.1201080052131--

