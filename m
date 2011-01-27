Message-ID: <4D4174C5.5030903@domain.hid>
Date: Thu, 27 Jan 2011 14:36:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <29228600.131296118733562.JavaMail.SYSTEM@PC-MRINALDI>
In-Reply-To: <29228600.131296118733562.JavaMail.SYSTEM@PC-MRINALDI>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems with rt_task_create and rt_task_join
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michel Rinaldi <automation.03@domain.hid>
Cc: xenomai@xenomai.org

Michel Rinaldi wrote:
> Posted by Gilles Chanteperdrix on January 25, 2011 - 14:27: 
> 
>> Well, no. dd if=/dev/zero of=/dev/null is far from being a proper load. 
>> What you should do is at least to create some disk and network activity, 
>> continuously. And the ideal, is to run the LTP test in parallel. If you 
>> can not, then at least run hackbench in a loop. All this during several 
>> hours. 
> 
> Ok. I run LTP test and latency test in parallel for about 15 hours continuously. 
> I have this result at the end: 
> 
> RTD| 6.182| 7.627| 47.662| 0| 0| 15:04:32/15:04:32 

Strange, here, the LTP test takes only around 2 hours. Just to be sure:
you also generated disk and network activity in parallel to LTP and
latency? If yes, then this system has no issue with Xenomai, and the
problem you have with your application is in the application itself.

-- 
                                                                Gilles.

