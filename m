Message-ID: <45E88077.5020407@domain.hid>
Date: Fri, 02 Mar 2007 20:52:23 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] some problems using RTCAN on PEAK dongle
References: <bc4264770703021005g52d0e416i359e9de91bcd38c9@domain.hid>
In-Reply-To: <bc4264770703021005g52d0e416i359e9de91bcd38c9@domain.hid>
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
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

roland Tollenaar wrote:
> Hi,
> 
> Ok rtcan2 and the peak dongle seem to be working. I am now running
> into new problems with my application.
> 
> The first question is how do I reset the ctrl_mode to nothing.
> Listen-only and loopback are both debugging/testing states but how do
> I reset them to ....what is the normal state called? At the moment I
> am in loop_back mode all the time.

# rtcanconfig -c none rtcan0

Wiil be documented a.s.a.p.

> I am writing to rtcan2 from my application and subsequently reading
> from it. Works by the look of things BUT my CPU is working overtime.
> syslogd and klogd are consuming 50-60% plus 30-40% of the processor

O, ah, what gets logged that often?

> time. Obviously everything gets sticky but I can still see that the
> task times are being maintained and the actual applicaiton is using
> less than 3% of the processor time.

Polling too often is a typical problem of the polling method.

> Besides this simple can functionality there is nothing happening in
> the tasks and this does not happen if I write and read on rtcan0.
> 
> Finally after a long while of running and stopping the application I
> get the message
> 
> rt_dev_bind: -no space left on device.
> 
> This bind is called before the read-call.
> 
> Can anyone please shed some light on these issues. Much appreciated as 
> usual.

Grrr, I already told you that it does not make sense to use bind and 
ioctl SSIOCGIFINDEX for every read here: 
https://mail.gna.org/public/xenomai-help/2007-02/msg00354.html. Please 
(re-)read 
http://www.xenomai.org/documentation/trunk/html/api/group__rtcan.html#Bind
and
http://www.xenomai.org/documentation/trunk/html/api/group__rtcan.html#gee74ae50c8ea0a6aee277c6f124a3866
to understand why.

Nevertheless, there seem to be a memory leak when re-binding the device. 
I will have a look a.s.a.p. (but it should not be a problem for your app 
when you just do it once per socket).

Wolfgang.

> 
> Kind regards,
> 
> 
> Roland
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 
> 


