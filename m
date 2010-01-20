Message-ID: <4B572A0E.30108@domain.hid>
Date: Wed, 20 Jan 2010 17:06:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1aa9845a1001200715l326fa5e8kd5c09cc1dff52298@domain.hid>
In-Reply-To: <1aa9845a1001200715l326fa5e8kd5c09cc1dff52298@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Is true task parallelism possible in Xenomai??
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Saravanan S <sarans1987@domain.hid>
Cc: xenomai@xenomai.org

Saravanan S wrote:
> Hi,
>     Is it possible to run two xenomai user space real time tasks in parallel
> on say two different cores(assuming the threads are not contending for same
> memory resources at the same time)?? I have tried  giving two real time
> tasks equal priorities of 99 and using T_CPU to bind them to different cores
> .Is this enough???
> Does T_CPU(x) guarantee that my task will be run always on CPU x or does it
> just increase the chances of running on CPU x??
> 
> How do i know which core my real time task is running ??Is some tool
> available for real time monitoring of threads and the cores they are running
> on ??

Do you have any specific problem, for which you would need some help?
Something does not work as expected?

-- 
					    Gilles.

