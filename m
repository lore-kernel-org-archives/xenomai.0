References: <CA+_GcoBZSOuEs_yrdG0EWXxUk5_PEC1qf69+jfqQFC_MpgFb9w@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <908427a1-bdb4-2ac8-ce51-3087f0006b17@xenomai.org>
Date: Mon, 19 Dec 2016 18:20:01 +0100
MIME-Version: 1.0
In-Reply-To: <CA+_GcoBZSOuEs_yrdG0EWXxUk5_PEC1qf69+jfqQFC_MpgFb9w@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] System hang when doing several rtdm_task_init()
	calling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastien Schneider <seb.schneider@gmail.com>, xenomai@xenomai.org

On 12/19/2016 03:04 PM, Sebastien Schneider wrote:
> Hello,
> 
> I am facing issues with the rtdm_task_init() function when trying to
> developp a xenomai real-time base driver.
> I firstly call the rtdm_task_init() method for a non periodic task with the
> lowest priority. This lowest priority task infinitly executes code which
> first consists on a rtdm_task_sleep() for a predefined amount of time,
> before other various operations.
> Then, I secondly call the rtdm_task_init() method for an another non
> periodic task with the highest priority. And what happens after compiling
> the code and trying to insert the obtained module, is that the system seems
> to hang.
> 
> Has anyone some idea that can help me ?

Runaway thread #2, maybe never blocking unlike you would expect it to?
Enabling the watchdog is recommended when developing Xenomai apps
(CONFIG_XENO_OPT_WATCHDOG); it would trap when a rt thread runs away,
suspending it with a warning message sent to the kernel log.

Sharing the driver code in question would help. Such issue basically
depends on what your code is exactly doing.

-- 
Philippe.

