Message-ID: <4E305D5E.8070908@domain.hid>
Date: Wed, 27 Jul 2011 20:47:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1311085450.21897.YahooMailClassic@domain.hid>
In-Reply-To: <1311085450.21897.YahooMailClassic@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] clock problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philip Ha <philwman@domain.hid>
Cc: xenomai@xenomai.org

On 07/19/2011 04:24 PM, Philip Ha wrote:
> Dear all,
> 
> I am running a serial port test in xenomai (xenomai-2.5.5.2) using 16550A driver.
> In my program, I am calling
> 
> rt_dev_ioctl(dev_id, RTSER_RTIOC_WAIT_EVENT, & rx_event);
> 
> when an event happens, I use clock_gettime(CLOCK_MONOTONIC, & curr_time)
> to get the current time. The program runs continuosly in a while loop. In this way, I 
> measure the elapsed time between the previous and current events.

Hi,

we do not have enough details here, if you are compiling for the native
skin, the call to clock_gettime is linux clock_gettime, so, can not
really be relied upon in a thread which you with to remain in primary
mode. You should use rt_timer_read.

If you are compiling for the posix skin, you do not give us enough
information to even begin understanding the issue you have .

Regards.

-- 
                                                                Gilles.

