Message-ID: <4B86FFA0.3000403@domain.hid>
Date: Thu, 25 Feb 2010 23:54:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE2006483DE98C@us194mx002.tycoelectronics.net>	<4B86EDC2.7010905@domain.hid>
	<4B86FCBB.10203@domain.hid>
In-Reply-To: <4B86FCBB.10203@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] mlockall error after calling mlockall()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Charlton, John wrote:
>>> I have a xenomai application that runs without problems with xenomai-2.4.6.1/linux-2.6.27.7. When run under xenomai-2.5.1/linux-2.6.32.7 it fails with the warning: Xenomai: process memory not locked (missing mlockall?).  I verified that mlockall() is being called before any xenomai calls are made as follows with out error:
>>>
>> I'm afraid that warning is misleading.
> 
> And this should fix the error reporting (without any signal handler
> installed, your application will still terminate, though):

Arg, it will conflict with the libxenomai thing. I am punished for not
having pushed my work earlier.

Did you test it? Or should I wait for John to test it before merging it?

-- 
					    Gilles.

