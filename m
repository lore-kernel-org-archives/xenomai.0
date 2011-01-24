Message-ID: <4D3D71BA.4090204@domain.hid>
Date: Mon, 24 Jan 2011 13:34:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=ba-NePDr0bem0yFuZfV7TwXubF3HQSNLV8bxY@mail.gmail.com>
	<4D3D6FF5.9050209@domain.hid>
In-Reply-To: <4D3D6FF5.9050209@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Detect switch in secondary mode + mlockall = bug?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Charles Clerdan <charles.clerdan@domain.hid>
Cc: armadeus-forum@domain.hid, xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Charles Clerdan wrote:
>> Hi,
>>
>> I'm trying to catch the signal SIGXCPU, in order to know when a task goes in
>> secondary mode.
>> I would like to know, why I have to comment the fonction mlockall.
> 
> http://www.xenomai.org/index.php/Request_for_information

Also, does the latency test run on your platform? Because if it does, it
shows that the bug is elsewhere: latency contains a call to mlockall and
registers a signal handler for SIGXCPU.

And if you want us to help you, you should tell us what happens if you
do not comment mlockall, because we can not guess it. See, we run
latency all the time, and obviously, we have no issue.

-- 
                                                                Gilles.

