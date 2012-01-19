Message-ID: <4F187E84.1000704@domain.hid>
Date: Thu, 19 Jan 2012 21:35:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CA+fRa6evoCQZuWrRNQL2+SjLKTqcW1vJtfxAyZs60jS83sv5Gw@domain.hid>
In-Reply-To: <CA+fRa6evoCQZuWrRNQL2+SjLKTqcW1vJtfxAyZs60jS83sv5Gw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] error compiling pipe function
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: daniele.gottfried@domain.hid
Cc: xenomai@xenomai.org, Daniele <danielegottfried@domain.hid>

On 01/19/2012 04:50 PM, Daniele wrote:
> Hi dear,
> 
> 
> We are trying to implement pipe communication between real-time tasks
> and non real-time main with:
> 
> [xenomai 2.6.0, kernel 2.6.38.8]
> 
> Compiling the program  we got several of the following error:
> 
> "implicit declaration of function 'rt_pipe_alloc'"

See:
http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__pipe.html#ga40f294bf6254d2e1b66b8b6b400fc2e5

-- 
                                                                Gilles.

