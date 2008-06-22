Message-ID: <6132061f0806221237l24195e2ta5a0e62e9f890c36@domain.hid>
Date: Sun, 22 Jun 2008 16:37:52 -0300
From: "Breno Carneiro Pinheiro" <brenodee@domain.hid>
In-Reply-To: <485E6AC6.9070005@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_14648_21080229.1214163472783"
References: <6132061f0806190723x7f1716f4v1b3f3831c78717f6@domain.hid>
	<485E6AC6.9070005@domain.hid>
Subject: Re: [Xenomai-help] Xenomai App question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

------=_Part_14648_21080229.1214163472783
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Gilles. On my system I have:

*include/config/auto.conf:CONFIG_XENO_OPT_TIMING_PERIODIC=y
include/linux/autoconf.h:#define CONFIG_XENO_OPT_TIMING_PERIODIC 1*

Is that correctly set? I wanna run periodic tasks and my processor's clock
is 400Mhz. Which is the best config.?

Thanks again,

Breno

2008/6/22 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:

> Breno Carneiro Pinheiro wrote:
>
>>  Hi all,
>>
>> I'm implementing  an predictive control application to run on my powerpc
>> (MPC5200 - 400Mhz) with Xenomai patch. Now that I have it done, I wonder
>> estimate the computation time of some parts in my code.
>> I trying to use the Native/Xenomai API to get it but the results are
>> weirds.
>> My task code is below:
>>
>
> The simple way to estimate the computation time of some parts of the code
> is:
>
> unsigned long long start, end;
>
> some code 1
> start = rt_timer_tsc();
> some code 2
> end = rt_timer_tsc();
>
> To get the duration of "some code 2", compute:
> rt_timer_tsc2ns(end - start)
>
>  Besides this, I'm looking some documents that say:
>>
>> The selection
>> of the proper operation mode (oneshot or periodic) of the timer is made at
>> build time using the configuration switch
>> named *CONFIG_XENO_OPT_TIMING_PERIOD* from the nucleus section. A
>> zero value causes the native skin to operate in oneshot mode; otherwise,
>> periodic
>> mode is used according to the given duration of the clock tick, expressed
>> in
>> nanoseconds. If support for periodic timing has been disabled at
>> configuration
>> level (i.e. *CONFIG_XENO_OPT_TIMING_PERIODIC* is unset), the timer mode
>> always defaults to oneshot.
>>
>> What is *CONFIG_XENO_OPT_TIMING_PERIOD*? And where configure it?
>>
>
> In the kernel configuration menu.
>
>
> --
>
>
>                                            Gilles.
>

------=_Part_14648_21080229.1214163472783
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Gilles. On my system I have:<br><br><b>include/config/auto.conf:CONFIG_XENO_OPT_TIMING_PERIODIC=y<br>include/linux/autoconf.h:#define CONFIG_XENO_OPT_TIMING_PERIODIC 1</b><br><br>Is that correctly set? I wanna run periodic tasks and my processor&#39;s clock is 400Mhz. Which is the best config.?<br>
<br>Thanks again,<br><br>Breno <br><br><div class="gmail_quote">2008/6/22 Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">Breno Carneiro Pinheiro wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&nbsp;Hi all,<br>
<br>
I&#39;m implementing &nbsp;an predictive control application to run on my powerpc<br>
(MPC5200 - 400Mhz) with Xenomai patch. Now that I have it done, I wonder<br>
estimate the computation time of some parts in my code.<br>
I trying to use the Native/Xenomai API to get it but the results are weirds.<br>
My task code is below:<br>
</blockquote>
<br></div>
The simple way to estimate the computation time of some parts of the code is:<br>
<br>
unsigned long long start, end;<br>
<br>
some code 1<br>
start = rt_timer_tsc();<br>
some code 2<br>
end = rt_timer_tsc();<br>
<br>
To get the duration of &quot;some code 2&quot;, compute:<br>
rt_timer_tsc2ns(end - start)<div class="Ih2E3d"><br>
<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Besides this, I&#39;m looking some documents that say:<br>
<br>
The selection<br>
of the proper operation mode (oneshot or periodic) of the timer is made at<br>
build time using the configuration switch<br>
named *CONFIG_XENO_OPT_TIMING_PERIOD* from the nucleus section. A<br>
zero value causes the native skin to operate in oneshot mode; otherwise,<br>
periodic<br>
mode is used according to the given duration of the clock tick, expressed in<br>
nanoseconds. If support for periodic timing has been disabled at<br>
configuration<br>
level (i.e. *CONFIG_XENO_OPT_TIMING_PERIODIC* is unset), the timer mode<br>
always defaults to oneshot.<br>
<br>
What is *CONFIG_XENO_OPT_TIMING_PERIOD*? And where configure it?<br>
</blockquote>
<br></div>
In the kernel configuration menu.<br>
<br>
<br>
-- <br><font color="#888888">
<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Gilles.<br>
</font></blockquote></div><br>

------=_Part_14648_21080229.1214163472783--

