Message-ID: <4F7756AF.5000602@domain.hid>
Date: Sat, 31 Mar 2012 21:10:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAGq8jPgJUWE2YrhUMCshCtSsRyTWPqx5zV5vPnVzpF2ctN0edg@domain.hid>
In-Reply-To: <CAGq8jPgJUWE2YrhUMCshCtSsRyTWPqx5zV5vPnVzpF2ctN0edg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] difference Analogy API et rtdm API in xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Minh GIANG <giang.hminh@domain.hid>
Cc: xenomai@xenomai.org

On 03/30/2012 03:45 PM, Minh GIANG wrote:
> hello everybody,
> 
> i have a small question, which is the difference between the analogy API
> and rtdm API in xenomai. for exemple, i think that i can open a port for
> data transmission in the two api.

The RTDM API is an API allowing to implement drivers for xenomai using
the usual POSIX open/close/ioctl/etc... API.

Analogy is a driver implemented using the RTDM API. So, you can access
it using either the usual POSIX open/close/ioctl/etc... API, or using
the analogy library provided.

So, yes, you can use the two APIs, but using the analogy library is
probably simpler.

-- 
                                                                Gilles.

