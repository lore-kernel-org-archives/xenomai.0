Message-ID: <45EECBA5.1090205@domain.hid>
Date: Wed, 07 Mar 2007 15:26:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Help regarding Native API
References: <528bc2040703070447nae71f36yea1a972966fa6457@domain.hid>
In-Reply-To: <528bc2040703070447nae71f36yea1a972966fa6457@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: manoj kumar <manojkpanghal@domain.hid>
Cc: xenomai@xenomai.org

manoj kumar wrote:
> Hi,
>  
> Could any body explain the native task managment api rt_task_slice &
> rt_task_set_mode?
> How these are useful, please explain with example?
>  
> I tried to set a time slice for a particuler rt task through
> rt_task_slice but could not get much.

There is no example of how the round-robin mode works. The information
which is not obvious and which you are probably missing is that the
round-robin mode only works if the system timer is set to periodic mode.

To set the system timer to periodic mode, set the configuration option
CONFIG_XENO_OPT_NATIVE_PERIOD to a non null value, or use rt_timer_set_mode.

-- 
                                                 Gilles Chanteperdrix

