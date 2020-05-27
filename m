Subject: Re: XENO_OPT_DEBUG_MUTEX_SLEEP and serial drivers
References: <e2afc05d-6965-f5a1-700f-32d419156f5b@rsi-elektrotechnik.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <26937928-896e-f829-4862-2ed9279adaa8@siemens.com>
Date: Wed, 27 May 2020 13:03:00 +0200
MIME-Version: 1.0
In-Reply-To: <e2afc05d-6965-f5a1-700f-32d419156f5b@rsi-elektrotechnik.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Leupold <leupold@rsi-elektrotechnik.de>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 27.05.20 11:11, Jan Leupold via Xenomai wrote:
> Hi,
> 
> it seems to me that the write() methods in 16550.c, mpc52xx_uart.c and
> rt_imx_uart.c cause a SIGDEBUG when used on a kernel with
> XENO_OPT_DEBUG_MUTEX_SLEEP set.
> 
> All drivers lock a mutex (named "out_lock") for the duration of these
> functions and eventually call rtdm_event_timedwait() later - with the
> mutex locked.
> 
> I think it is a good thing to serialize write() there, but it does not combine
> well with the debug option. Currently I disable the test with
> pthread_setmode_np() for the duration of write() in the application,
> but maybe someone has a better idea how to deal with it.

Good catch.

We would need to a way to tag in-kernel mutexes that are fine to hold
while sleeping. Those could be exempted from xnthread_get/put_resource().

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

