Message-ID: <440456CE.1070807@domain.hid>
Date: Tue, 28 Feb 2006 14:57:34 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] resume/suspend periodic timing issue
References: <C0299417.2562%steve@domain.hid>
In-Reply-To: <C0299417.2562%steve@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Steven Seeger wrote:
> I have never see an RTOS exhibit this behavior,

Perhaps you were not misusing that RTOS?

  and previous versions of
> Fusion

Check the code, it's no novelty.

  and the classic RTAI did not.
> 

Who cares?

> Steven
> 
> 
> On 2/27/06 10:39 AM, "Gilles Chanteperdrix"
> <gilles.chanteperdrix@xenomai.org> wrote:
> 
> 
>>This behaviour is due to the way the overruns are accounted for: not
>>having called rt_task_wait_period while the periodic timer elapses is
>>currently considered an abnormal usage of the interface, and counted as
>>an overrun.
>>
>>A way around this behaviour is to create an alarm object with
>>rt_alarm_create, and use rt_alarm_start and rt_alarm_wait for each
>>shot.
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

