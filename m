Message-ID: <4A81CE4F.9060301@domain.hid>
Date: Tue, 11 Aug 2009 22:02:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE20060EFA4BEC@us194mx002.tycoelectronics.net>
	<4A81CA67.9060301@domain.hid>
In-Reply-To: <4A81CA67.9060301@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread_setschedparam: Function not implemented
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Charlton, John" <john.charlton@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Charlton, John wrote:
>> I have been using xenomai-2.4.6.1 with linux-2.6.27.7 without problems. We have changed our open embedded build to build xenomai within open embedded and with recent xenomai/kernel builds I am getting the following error output from xeno-test:
>>
>> latency: failed to open benchmark device, code -38
>> (modprobe xeno_timerbench?)                       
>> Xenomai Posix skin init: pthread_setschedparam: Function not implemented
>>
>> Any ideas on what the problem is?
> 
> Exactly what version of Xenomai kernel-space suppors runs with what
> version of user-space support?
> Normally, latency does not use Xenomai posix skin, so you should not see
> this message. Could you show us the result of the ldd command with the
> version of latency you are running?

Also, please post your .config to the list.

-- 
					    Gilles.

