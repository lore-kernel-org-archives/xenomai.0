Message-ID: <4861F67F.7090805@domain.hid>
Date: Wed, 25 Jun 2008 09:40:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <838862596@domain.hid>
In-Reply-To: <838862596@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] latency in kernel mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Joachim Meyer <Jogi95@domain.hid>
Cc: xenomai@xenomai.org

Joachim Meyer wrote:
> bash-3.00# ./run -- -t1
> *
> *
> * Type ^C to stop this application.
> *
> *
> == Sampling period: 100 us
> == Test mode: in-kernel periodic task
> == All results in microseconds
> latency: failed to start in-kernel timer benchmark, code -25
> ---|------------|------------|------------|--------|-------------------------
> RTS|  267928.028|  805352.732|      32.768|       0|    00:00:10/00:00:10
> bash-3.00#
> ----------------------------------------------------------------------------------------------
> 
> Thanks for your help and patience.

Enable the timerbench driver in kernel configuration. If you want to
enable several testing drivers and everything to work "out of thebox",
enable them as module, and do not load the modules by yourself, let the
run script load the apropriate module. Otherwise, specify the correct
testing driver index to the test you run.

-- 


					    Gilles.

