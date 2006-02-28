Date: Tue, 28 Feb 2006 05:45:59 -0800
Subject: Re: [Xenomai-help] resume/suspend periodic timing issue
From: Steven Seeger <steve@domain.hid>
Message-ID: <C0299417.2562%steve@domain.hid>
In-Reply-To: <17411.18293.205947.507401@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

I have never see an RTOS exhibit this behavior, and previous versions of
Fusion and the classic RTAI did not.

Steven


On 2/27/06 10:39 AM, "Gilles Chanteperdrix"
<gilles.chanteperdrix@xenomai.org> wrote:

> 
> This behaviour is due to the way the overruns are accounted for: not
> having called rt_task_wait_period while the periodic timer elapses is
> currently considered an abnormal usage of the interface, and counted as
> an overrun.
> 
> A way around this behaviour is to create an alarm object with
> rt_alarm_create, and use rt_alarm_start and rt_alarm_wait for each
> shot.


