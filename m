Message-ID: <e325d110607130946m47041caai13413b69288b71a1@domain.hid>
Date: Thu, 13 Jul 2006 17:46:58 +0100
From: "Kim Chuan Lim" <lim.kim.chuan@domain.hid>
Subject: Re: [Xenomai-help] RT timer help
In-Reply-To: <17590.28495.53263.24303@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e325d110607130503k37a4e648p1ae581e7b984abb4@domain.hid>
	<17590.14655.583084.480317@domain.hid>
	<e325d110607130737j3011b167wef31d2bf8fa6fd42@domain.hid>
	<17590.23816.918869.787019@domain.hid>
	<e325d110607130902r6bdd04e4l1001f33e094d9d4a@domain.hid>
	<17590.28495.53263.24303@domain.hid>
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

Hi Gilles,

I am a bit confused with the defination of "latency suffer".
The following is the output of example program at /xenomai/testuites/latency.
Is 38.5ms average latency consider good?


== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      37.714|      38.552|      41.066|       0|      37.714|      41.066
RTD|      37.714|      38.552|      48.609|       0|      37.714|      48.609
RTD|      37.714|      38.552|      47.771|       0|      37.714|      48.609
RTD|      37.714|      38.552|      47.771|       0|      37.714|      48.609
RTD|      37.714|      38.552|      72.076|       0|      37.714|      72.076
RTD|      37.714|      38.552|      46.933|       0|      37.714|      72.076
RTD|      37.714|      38.552|      46.933|       0|      37.714|      72.076
RTD|      37.714|      38.552|      47.771|       0|      37.714|      72.076
RTD|      37.714|      38.552|      47.771|       0|      37.714|      72.076
RTD|      37.714|      38.552|      47.771|       0|      37.714|      72.076
---|------------|------------|------------|--------|-------------------------
RTS|      37.714|      38.552|      72.076|       0|    00:00:10/00:00:10

Regards,
Kim Chuan.

On 7/13/06, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> Kim Chuan Lim wrote:
>  > Hi Gilles,
>  >
>  > > Does the latency test suffer from the same issue ?
>  >
>  > I read the system time(rt_timer_read()) and the different is the same,
>  > almost 1,000,000,000 different. But my program just took ~10seconds
>  > for every update..
>
> If latency suffers from the same issue, then your problem is in the
> setup and I advise you once more to read the TROUBLESHOOTING
> file. If latency does not suffer from the same issue, then you have made
> a mistake in the code.
>
> --
>
>
>                                             Gilles Chanteperdrix.
>

