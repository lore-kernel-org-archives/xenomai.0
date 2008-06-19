Message-ID: <6132061f0806190723x7f1716f4v1b3f3831c78717f6@domain.hid>
Date: Thu, 19 Jun 2008 11:23:34 -0300
From: "Breno Carneiro Pinheiro" <brenodee@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_4135_19363633.1213885414184"
Subject: [Xenomai-help] Xenomai App question
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

------=_Part_4135_19363633.1213885414184
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

 Hi all,

I'm implementing  an predictive control application to run on my powerpc
(MPC5200 - 400Mhz) with Xenomai patch. Now that I have it done, I wonder
estimate the computation time of some parts in my code.
I trying to use the Native/Xenomai API to get it but the results are weirds.
My task code is below:


void Simulator (void* c)
{

    unsigned char n;
    unsigned long overrun;
    FILE *stream;
    unsigned int i;

    float v, t;
    n    = 20;
    v    = (float) V;
    t    = (float) T;
    alfa = (float) sqrt(29);
    stream = fopen("time.dat", "w+t"); // where I print the results



    for(i=na_mfd;i<nref;i++)
    {
        *infoTempo = rt_timer_ticks2ns(rt_timer_read());
       fprintf(stream, "%lld\n",infoTempo);*

       // ------------- My control Code ---------------//
        x_sys[i]    = (float) (x_sys[i-1] + V*cos(teta_sys[i-1]+fi[i-1])*T);

        y_sys[i]    = (float) (y_sys[i-1] + V*sin(teta_sys[i-1]+fi[i-1])*T);

        teta_sys[i] = (float) (teta_sys[i-1] + (V*sin(fi[i-1])*T)/LE);
        y[0] = x_sys[i-1];
        y[1] = y_sys[i-1];
        abs2local(&y[0], &y[1], &x_sys[i], &y_sys[i], &teta_sys[i]);
        y[0] = teta_sys[i];
        purePursuit(r, &x_sys[i], &y_sys[i], &teta_sys[i], xref, yref, &n,
&nref, &alfa, &dg, &t, &v);
        processFreeResponseOP(R, B, f, y, du, h, na_mfd, nb_mfd, nout, nin);

        processCommand(K, r, f, du, 0, h, na_mfd, nb_mfd, nout, nin, n);
        #ifdef DEBUG
        printArray(f, TAILREF, "Resposta Livre:");
        printArray(du, nb_mfd*nin, "du:");
        #endif
        fi[i] = fi[i-1] + du[nb_mfd-1];
        infoTempo = rt_timer_ticks2ns(rt_timer_read());

//------------------------------------------------------------------------------//


    }
    fclose(stream);

}

That's the only one task I have on my system. I wonder compute the time to
process every single step of *for* loop. What you think?

Besides this, I'm looking some documents that say:

The selection
of the proper operation mode (oneshot or periodic) of the timer is made at
build time using the configuration switch
named *CONFIG_XENO_OPT_TIMING_PERIOD* from the nucleus section. A
zero value causes the native skin to operate in oneshot mode; otherwise,
periodic
mode is used according to the given duration of the clock tick, expressed in
nanoseconds. If support for periodic timing has been disabled at
configuration
level (i.e. *CONFIG_XENO_OPT_TIMING_PERIODIC* is unset), the timer mode
always defaults to oneshot.

What is *CONFIG_XENO_OPT_TIMING_PERIOD*? And where configure it?

I hope someone have some time for that.

Thanks a lot,

Breno
*
*

------=_Part_4135_19363633.1213885414184
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline




  
  

Hi all,<br>
<br>
I&#39;m implementing&nbsp; an predictive control application to run on my
powerpc (MPC5200 - 400Mhz) with Xenomai patch. Now that I have it done, I wonder estimate
the computation time of some parts in my code.<br>
I trying to use the Native/Xenomai API to get it but the results are
weirds. My task code is below:<br>
<br>
<br>
void Simulator (void* c)<br>
{<br>
<br>
&nbsp;&nbsp; &nbsp;unsigned char n; <br>
&nbsp;&nbsp;&nbsp; unsigned long overrun;<br>
&nbsp;&nbsp; &nbsp;FILE *stream; <br>
&nbsp;&nbsp; &nbsp;unsigned int i; <br>
&nbsp;&nbsp; &nbsp; <br>
&nbsp;&nbsp; &nbsp;float v, t; <br>
&nbsp;&nbsp; &nbsp;n&nbsp;&nbsp;&nbsp; = 20; <br>
&nbsp;&nbsp; &nbsp;v&nbsp;&nbsp;&nbsp; = (float) V; <br>
&nbsp;&nbsp; &nbsp;t&nbsp;&nbsp;&nbsp; = (float) T; <br>
&nbsp;&nbsp; &nbsp;alfa = (float) sqrt(29);<br>
&nbsp;&nbsp; &nbsp;stream = fopen(&quot;time.dat&quot;, &quot;w+t&quot;); // where I print the results<br><br>
&nbsp;&nbsp; <br>
&nbsp;&nbsp; &nbsp; <br>
&nbsp;&nbsp; &nbsp;for(i=na_mfd;i&lt;nref;i++) <br>
&nbsp;&nbsp; &nbsp;{<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;<b>infoTempo = rt_timer_ticks2ns(rt_timer_read());<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fprintf(stream, &quot;%lld\n&quot;,infoTempo);</b><br>
&nbsp;<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // ------------- My control Code ---------------//<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;x_sys[i]&nbsp;&nbsp;&nbsp; = (float) (x_sys[i-1] +
V*cos(teta_sys[i-1]+fi[i-1])*T); <br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;y_sys[i]&nbsp;&nbsp;&nbsp; = (float) (y_sys[i-1] +
V*sin(teta_sys[i-1]+fi[i-1])*T); <br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;teta_sys[i] = (float) (teta_sys[i-1] + (V*sin(fi[i-1])*T)/LE); <br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;y[0] = x_sys[i-1]; <br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;y[1] = y_sys[i-1]; <br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;abs2local(&amp;y[0], &amp;y[1], &amp;x_sys[i], &amp;y_sys[i],
&amp;teta_sys[i]); <br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;y[0] = teta_sys[i]; <br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;purePursuit(r, &amp;x_sys[i], &amp;y_sys[i], &amp;teta_sys[i],
xref, yref, &amp;n, &amp;nref, &amp;alfa, &amp;dg, &amp;t, &amp;v); <br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;processFreeResponseOP(R, B, f, y, du, h, na_mfd, nb_mfd, nout,
nin); <br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;processCommand(K, r, f, du, 0, h, na_mfd, nb_mfd, nout, nin,
n); <br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;#ifdef DEBUG <br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; printArray(f, TAILREF, &quot;Resposta Livre:&quot;); <br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; printArray(du, nb_mfd*nin, &quot;du:&quot;); <br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;#endif <br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;fi[i] = fi[i-1] + du[nb_mfd-1];<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;infoTempo = rt_timer_ticks2ns(rt_timer_read());<br>
&nbsp;&nbsp; &nbsp; //------------------------------------------------------------------------------//&nbsp;  <br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;<br>
&nbsp;&nbsp; &nbsp;} <br>
&nbsp;&nbsp; &nbsp;fclose(stream);<br>
<br>
}<br>
<br>
That&#39;s the only one task I have on my system. I wonder compute the time
to process every single step of <b>for</b> loop. What you think?<br>
<br>
Besides this, I&#39;m looking some documents that say:<br>
<br>
The selection<br>
of the proper operation mode (oneshot or periodic) of the timer is made
at build time using the configuration switch<br>
named <b>CONFIG_XENO_OPT_TIMING_PERIOD</b> from the nucleus section. A<br>
zero value causes the native skin to operate in oneshot mode;
otherwise, periodic<br>
mode is used according to the given duration of the clock tick,
expressed in<br>
nanoseconds. If support for periodic timing has been disabled at
configuration<br>
level (i.e. <b>CONFIG_XENO_OPT_TIMING_PERIODIC</b> is unset), the
timer mode<br>
always defaults to oneshot.<br>
<br>
What is <b>CONFIG_XENO_OPT_TIMING_PERIOD</b>? And where configure it? <br>
<br>
I hope someone have some time for that.<br>
<br>
Thanks a lot,<br>
<br>
Breno<br>
<b><br>
</b>

------=_Part_4135_19363633.1213885414184--

