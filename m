Message-ID: <49E87BB9.1050204@domain.hid>
Date: Fri, 17 Apr 2009 14:53:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <178051.15015.qm@domain.hid>
In-Reply-To: <178051.15015.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai - realtime task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: luan dinh <dinhluanbmt@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

luan dinh wrote:
> hi all.
> i write a real-time task by using Native API such as :rt_task_create(), rt_task_start(rttask_demo,..)...
> 
> void rttask_demo(void *arg)
> {
> .../* posix API*/
> }
> In rttask_demo body code i use standard POSIX API such as : socket(), send(), recev() to connect to Network base on original Network driver.
> in this case, does my rttask_demo execute as hard-realtime ?
> I'm a newbabie in Xenomai
> thanks for any advise.

No, of course not. See the "life with adeos" and "native API tour"
documents:

http://www.xenomai.org/index.php/Publications

-- 
					    Gilles.

