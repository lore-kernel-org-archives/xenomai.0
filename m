Message-ID: <49F69377.7090005@domain.hid>
Date: Tue, 28 Apr 2009 07:26:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49F65852.6090401@domain.hid>
In-Reply-To: <49F65852.6090401@domain.hid>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Does not exist "xnpod_start_timer" on Xenomai
 2.4.7	???
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Kim, Hee-young" <plugdboy@domain.hid>
Cc: xenomai@xenomai.org

Kim, Hee-young wrote:
> Hi,
> 
> I'm trying to patch "rt-firewire 0.1" for lastest xenomai patched
> kernel. I fixed some functions to altered one. But, xnpod_start_timer(),
> xnpod_stop_timer() and relates do not exist in pod.c.
> and try to find same function name in Xenomai but there are no exists.
> Where can I find these functions? or How to solve it?

The replacement is xnpod_enable_timesource, but you should not need to
call it explicitely, especially not in a driver. So, you should rather
remove these calls.

BTW, any plan to publish the modified code ?

-- 
					    Gilles.

