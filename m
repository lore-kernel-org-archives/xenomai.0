Date: Tue, 21 Feb 2006 05:50:21 -0800
Subject: Re: [Xenomai-help] no-brainer realtime issue
From: Steven Seeger <steve@domain.hid>
Message-ID: <C0205A9D.249C%steve@domain.hid>
In-Reply-To: <43F61611.7010902@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

No, my application uses and always has used periodic timing with a tick of
125 us.

Steven


On 2/17/06 10:29 AM, "Philippe Gerum" <rpm@xenomai.org> wrote:

> Steven Seeger wrote:
>> Could my problem be caused by me using the latest SVN for xenomai? Should I
>> try the released version instead?
> 
> You should first try my last suggestion, i.e. disable the forced periodic
> support 
> from the configuration. If your application used to rely on the deprecated
> rt_timer_start() call for setting the oneshot mode, then enabling the periodic
> timing option is inappropriate.
> 
>> 
>> Steven
>> 
>> 
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>> 
> 


