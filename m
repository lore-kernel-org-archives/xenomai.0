Date: Tue, 28 Feb 2006 06:07:50 -0800
Subject: Re: [Xenomai-help] resume/suspend periodic timing issue
From: Steven Seeger <steve@domain.hid>
Message-ID: <C0299936.2566%steve@domain.hid>
In-Reply-To: <17412.22080.12915.184100@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

My "opinion" is that if a task is forcibly suspended, it should not accrue
overruns. This should only occur when a task is delayed or ready.

Steven


On 2/28/06 5:55 AM, "Gilles Chanteperdrix"
<gilles.chanteperdrix@xenomai.org> wrote:

> Steven Seeger wrote:
>> I have never see an RTOS exhibit this behavior, and previous versions of
>> Fusion and the classic RTAI did not.
> 
> In your opinion, rt_task_wait_period should return -ETIMEDOUT only once
> and reset the overruns count ? How does the application get the overruns
> count then ? With an additional function call ?


