Message-ID: <4505C0F7.5060404@domain.hid>
Date: Mon, 11 Sep 2006 15:03:03 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] max size for pipes and rt-fifos?
References: <44FF3A22.5060901@domain.hid> <44FFE509.3090009@domain.hid>
	<4500789C.9070804@domain.hid> <450113E7.6000907@domain.hid>
In-Reply-To: <450113E7.6000907@domain.hid>
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
To: Xenomai help <xenomai@xenomai.org>

Jan Kiszka wrote:
>>   /* Shut down the real-time thread */
>>   pthread_cancel (fifotest_task);
>>   pthread_join (fifotest_task, NULL);  
> 
> pthread_join requires RT context and will not work as expected. But
> that's unrelated to this problem.

Okay.  (I now see this restriction in the docs.)  What is the proper way to do this cleanup from kernel-space with Xenomai?  (Pardon my asking, as I haven't done much programming using POSIX threads.  I believe this syntax was suggested, or at least acceptable, with RTLinux.)

Thanks,

Jeff


