Message-ID: <4C87C126.1050203@domain.hid>
Date: Wed, 08 Sep 2010 10:00:22 -0700
From: Bob Feretich <bob.feretich@domain.hid>
MIME-Version: 1.0
References: <4C8605E6.4000400@domain.hid> <4C862A3B.2050300@domain.hid>
	<4C8713A2.9010705@domain.hid> <4C87418D.1090601@domain.hid>
In-Reply-To: <4C87418D.1090601@domain.hid>
Content-Type: multipart/alternative;
	boundary="------------090604010204090403020406"
Subject: Re: [Xenomai-help] Oops during rt_event_wait();
 formerly "How do I force..."
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

This is a multi-part message in MIME format.
--------------090604010204090403020406
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

  I changed the subject from "How do I force a core dump on a page fault 
event?", because the thread's topic has drifted.
Comments inline...
On 9/8/2010 12:55 AM, Gilles Chanteperdrix wrote:
> ...Snipped...
>> No. This problem started occurring when I integrated the whole system
>> together. I'm going to have to work on it a bit to reduce it to a
>> suitable code segment .
>> The Xenomai content of the loop is:
>> while (!end) {
>>       ...
>>       rc = rt_event_wait(&event1,..);
>>       ...
>>       rc = rt_event_clear(&event1,..);
>>       ...
>>       rc = rt_event_wait(&event2,..);
>>       ...
>>       rc = rt_event_clear(&event2,..);
>>       ...
>>       rc = rt_event_wait(&event3, TM_NONBLOC, ...);
>>       if (rc==0) end = 1;
>> }
> Is this is a loop using all the CPU (all the events with TM_NONBLOCK) ?
No, just the last wait has TM_NONBLOCK. CPU utilization for the task is 
about 2%.

I examined my use of the rt_event mechanism, trying to identify how my 
use might be unusual.

    * The above calls are in a rt-user-task and are bracketed with
      bind/unbind, outside the loop. The task starts in secondary mode,
      performs the loop in primary mode, then finishes in secondary mode.
    * rt_event_create and rt_event_delete occur in a rtdm driver init
      and exit routines.
    * However, rt_event_signal is invoked in interrupt handlers. I think
      that this may be unusual. Normally, interrupt handlers would use
      the rtdm_event mechanism.

Could rt_event_signal be sensitive to being invoked from the context of 
a real time interrupt?

Interrupt handler stack space is usually quite small. Does 
rt_event_signal make heavy use of the stack?

Regards,
Bob Feretich

--------------090604010204090403020406
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
    <title></title>
  </head>
  <body bgcolor="#ffffff" text="#000000">
    I changed the subject from "How do I force a core dump on a page
    fault event?", because the thread's topic has drifted.<br>
    Comments inline...<br>
    On 9/8/2010 12:55 AM, Gilles Chanteperdrix wrote:
    <blockquote cite="mid:4C87418D.1090601@domain.hid" type="cite">
      <pre wrap="">...Snipped...
</pre>
      <blockquote type="cite">
        <pre wrap="">No. This problem started occurring when I integrated the whole system 
together. I'm going to have to work on it a bit to reduce it to a 
suitable code segment .
The Xenomai content of the loop is:
while (!end) {
     ...
     rc = rt_event_wait(&amp;event1,..);
     ...
     rc = rt_event_clear(&amp;event1,..);
     ...
     rc = rt_event_wait(&amp;event2,..);
     ...
     rc = rt_event_clear(&amp;event2,..);
     ...
     rc = rt_event_wait(&amp;event3, TM_NONBLOC, ...);
     if (rc==0) end = 1;
}
</pre>
      </blockquote>
      <pre wrap="">
Is this is a loop using all the CPU (all the events with TM_NONBLOCK) ?
</pre>
    </blockquote>
    No, just the last wait has TM_NONBLOCK. CPU utilization for the task
    is about 2%.<br>
    <br>
    I examined my use of the rt_event mechanism, trying to identify how
    my use might be unusual.<br>
    <ul>
      <li>The above calls are in a rt-user-task and are bracketed with
        bind/unbind, outside the loop. The task starts in secondary
        mode, performs the loop in primary mode, then finishes in
        secondary mode.<br>
      </li>
      <li>rt_event_create and rt_event_delete occur in a rtdm driver
        init and exit routines.</li>
      <li>However, rt_event_signal is invoked in interrupt handlers. I
        think that this may be unusual. Normally, interrupt handlers
        would use the rtdm_event mechanism. </li>
    </ul>
    Could rt_event_signal be sensitive to being invoked from the context
    of a real time interrupt?<br>
    <br>
    Interrupt handler stack space is usually quite small. Does
    rt_event_signal make heavy use of the stack?<br>
    <br>
    Regards,<br>
    Bob Feretich<br>
  </body>
</html>

--------------090604010204090403020406--

