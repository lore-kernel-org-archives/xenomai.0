MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17412.22080.12915.184100@domain.hid>
Date: Tue, 28 Feb 2006 14:55:12 +0100
Subject: Re: [Xenomai-help] resume/suspend periodic timing issue
In-Reply-To: <C0299417.2562%steve@domain.hid>
References: <17411.18293.205947.507401@domain.hid>
	<C0299417.2562%steve@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Steven Seeger wrote:
 > I have never see an RTOS exhibit this behavior, and previous versions of
 > Fusion and the classic RTAI did not.

In your opinion, rt_task_wait_period should return -ETIMEDOUT only once
and reset the overruns count ? How does the application get the overruns
count then ? With an additional function call ?

-- 


					    Gilles Chanteperdrix.

