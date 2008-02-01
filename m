Message-ID: <d3f72a390802010142g3ac085b5qb2104ccd108796ec@domain.hid>
Date: Fri, 1 Feb 2008 10:42:26 +0100
From: "axel axel" <softaxel@domain.hid>
In-Reply-To: <2ff1a98a0802010120u6fdf215apf0a542e0c2b2bcff@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_40281_14052484.1201858946645"
References: <d3f72a390802010108l4f24cc4bq81272fdae55089e9@domain.hid>
	<2ff1a98a0802010120u6fdf215apf0a542e0c2b2bcff@domain.hid>
Subject: Re: [Xenomai-core] rt_task_sleep doesn't work with round robin
	scheduling
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_40281_14052484.1201858946645
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2008/2/1, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>
> On Fri, Feb 1, 2008 at 10:08 AM, axel axel <softaxel@domain.hid> wrote:
> > Hi,
> >
> > i try to use rt_task_sleep( 10000000 ) in a user-space task under
> > round-robin scheduling but doesnt' work.
>
Do not forget that the number passed to rt_task_sleep is a count of
> ticks (and documented as such), so, if you want to sleep for 10ms, you
> should call:
> rt_task_sleep(rt_timer_ns2ticks(10000000))


i try also this but nothing is changed.

this is the code of task:

void taskMav1 (void *cookie)
{
    int err, i;

    float a, b, c;
    //const float res2 = 14.6;
    //const float res3 = 22.5;
    //

    if( rt_task_set_mode( T_LOCK, T_RRB,0 ) != 0 )
    {
        printf( "Error rt_task_set_mode on task2samePrio\n" );
        fflush( stdout );
        return;
    }



    if( rt_task_slice( NULL, 1 ) != 0 )
    {
        printf( "Error rt_task_slice on task1samePrio\n" );
        fflush( stdout );
        return;
    }

    rt_sem_p( &rtSemStartAll, TM_INFINITE );
    rt_sem_v( &rtSemStartAll );


     for (;;) {

//      for( i = 0; i < 100; i++ )
//      {
//          a = 2.1;
//          b = a * 2.0;
//          c = b + 3.1;
//
//          if ( res1local != c )
//          {
//              /* Process interrupt. */
//              //  P9 on
//              *mapp_dout = *mapp_dout | 0x00000004;
//
//              //  P9 off
//              *mapp_dout = *mapp_dout & 0xFFFFFFFB;
//              rt_task_sleep( 100000000 );
//              continue;
//          }
//
//      }

        //rt_task_sleep( 100000000 );
         *mapp_dout = *mapp_dout | 0x00000004;
         err = rt_task_sleep(  rt_timer_ns2ticks(10000000) );
         if( err != 0 )
         {
             printf( "Error rt_task_sleep on taskMav1 %d\n", err );
             fflush( stdout );
             return;
         }
         *mapp_dout = *mapp_dout & 0xFFFFFFFB;
     }
 }

and this is the code of caller:

void testMaverickCrunch( void )
{
     int err;

     err = rt_sem_create( &rtSemStartAll, "rtSemStartAll", 0, S_FIFO );

     if( err != 0 )
     {
        printf( "Error on rt_sem_create rtSemStartAll \n" );
        fflush( stdout );

        return;
     }

     err = rt_timer_set_mode( 5000000 );
     if( err != 0 )
     {
        printf( "Error on rt_timer_set_mode \n" );
        fflush( stdout );

        return;
     }

     err = rt_task_spawn( &rtTaskMav1, "rtTaskMav1", 0, 1, 0, taskMav1,NULL
);
     if( err != 0 )
     {
        printf( "Error on rtTaskMav1\n" );
        fflush( stdout );

        rt_task_delete(&rtTaskMav1);

        return;
     }

     rt_sem_v( &rtSemStartAll );

}

>
> > It returns the value -11.
> >
> > Any idea ?
> >
> > Thanks a lot
> >
> > Roberto Bielli
> >
> > _______________________________________________
> >  Xenomai-core mailing list
> >  Xenomai-core@domain.hid
> >  https://mail.gna.org/listinfo/xenomai-core
> >
> >
>
>
>
> --
>                                                Gilles Chanteperdrix
>

------=_Part_40281_14052484.1201858946645
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">2008/2/1, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Fri, Feb 1, 2008 at 10:08 AM, axel axel &lt;<a href="mailto:softaxel@domain.hid">softaxel@domain.hid</a>&gt; wrote:<br>&gt; Hi,<br>&gt;<br>&gt; i try to use rt_task_sleep( 10000000 ) in a user-space task under<br>&gt; round-robin scheduling but doesnt&#39; work. <br>
</blockquote><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Do not forget that the number passed to rt_task_sleep is a count of<br>ticks (and documented as such), so, if you want to sleep for 10ms, you<br>
should call:<br>rt_task_sleep(rt_timer_ns2ticks(10000000))</blockquote><div><br>i try also this but nothing is changed.<br><br>this is the code of task:<br><br>void taskMav1 (void *cookie)<br>{<br>&nbsp;&nbsp;&nbsp; int err, i;<br><br>&nbsp;&nbsp;&nbsp; float a, b, c;<br>
&nbsp;&nbsp;&nbsp; //const float res2 = 14.6; <br>&nbsp;&nbsp;&nbsp; //const float res3 = 22.5; <br>&nbsp;&nbsp;&nbsp; // <br><br>&nbsp;&nbsp;&nbsp; if( rt_task_set_mode( T_LOCK, T_RRB,0 ) != 0 )&nbsp; <br>&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf( &quot;Error rt_task_set_mode on task2samePrio\n&quot; );<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fflush( stdout );<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; <br><br>&nbsp;&nbsp;&nbsp; if( rt_task_slice( NULL, 1 ) != 0 )<br>&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf( &quot;Error rt_task_slice on task1samePrio\n&quot; );<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fflush( stdout );<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; rt_sem_p( &amp;rtSemStartAll, TM_INFINITE );<br>&nbsp;&nbsp;&nbsp; rt_sem_v( &amp;rtSemStartAll );<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp; for (;;) {<br><br>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for( i = 0; i &lt; 100; i++ )<br>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a = 2.1;<br>
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b = a * 2.0;<br>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c = b + 3.1;<br>//<br>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ( res1local != c )<br>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Process interrupt. */<br>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; P9 on<br>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *mapp_dout = *mapp_dout | 0x00000004;<br>
//<br>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //&nbsp; P9 off<br>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *mapp_dout = *mapp_dout &amp; 0xFFFFFFFB;<br>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_sleep( 100000000 );<br>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>//<br>//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; //rt_task_sleep( 100000000 );<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;*mapp_dout = *mapp_dout | 0x00000004;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;err = rt_task_sleep(&nbsp; rt_timer_ns2ticks(10000000) );<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;if( err != 0 ) <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;{<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;printf( &quot;Error rt_task_sleep on taskMav1 %d\n&quot;, err );<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;fflush( stdout );<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;return;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;}<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;*mapp_dout = *mapp_dout &amp; 0xFFFFFFFB;<br>&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;}<br><br>and this is the code of caller:<br><br>void testMaverickCrunch( void )<br>{<br>
&nbsp;&nbsp;&nbsp; &nbsp;int err;<br><br>&nbsp;&nbsp;&nbsp; &nbsp;err = rt_sem_create( &amp;rtSemStartAll, &quot;rtSemStartAll&quot;, 0, S_FIFO );<br><br>&nbsp;&nbsp;&nbsp; &nbsp;if( err != 0 ) <br>&nbsp;&nbsp;&nbsp; &nbsp;{<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf( &quot;Error on rt_sem_create rtSemStartAll \n&quot; );<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fflush( stdout );<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>&nbsp;&nbsp;&nbsp; &nbsp;}<br><br>&nbsp;&nbsp;&nbsp; &nbsp;err = rt_timer_set_mode( 5000000 );<br>&nbsp;&nbsp;&nbsp; &nbsp;if( err != 0 ) <br>&nbsp;&nbsp;&nbsp; &nbsp;{<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf( &quot;Error on rt_timer_set_mode \n&quot; );<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fflush( stdout );<br>
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>&nbsp;&nbsp;&nbsp; &nbsp;}<br><br>&nbsp;&nbsp;&nbsp; &nbsp;err = rt_task_spawn( &amp;rtTaskMav1, &quot;rtTaskMav1&quot;, 0, 1, 0, taskMav1,NULL );<br>&nbsp;&nbsp;&nbsp; &nbsp;if( err != 0 ) <br>&nbsp;&nbsp;&nbsp; &nbsp;{<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf( &quot;Error on rtTaskMav1\n&quot; );<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fflush( stdout );<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; rt_task_delete(&amp;rtTaskMav1);<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>&nbsp;&nbsp;&nbsp; &nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp; rt_sem_v( &amp;rtSemStartAll );<br><br>}<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&gt;<br>&gt; It returns the value -11.<br>&gt;<br>&gt; Any idea ?<br>&gt;<br>&gt; Thanks a lot<br>&gt;<br>&gt; Roberto Bielli<br>&gt;<br>&gt; _______________________________________________<br>&gt;&nbsp;&nbsp;Xenomai-core mailing list<br>
&gt;&nbsp;&nbsp;<a href="mailto:Xenomai-core@domain.hid">Xenomai-core@domain.hid</a><br>&gt;&nbsp;&nbsp;<a href="https://mail.gna.org/listinfo/xenomai-core">https://mail.gna.org/listinfo/xenomai-core</a><br>&gt;<br>&gt;<br><br><br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles Chanteperdrix<br>
</blockquote></div><br>

------=_Part_40281_14052484.1201858946645--

