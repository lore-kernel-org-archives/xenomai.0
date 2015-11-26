Date: Thu, 26 Nov 2015 10:10:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151126091052.GC19641@hermes.click-hack.org>
References: <trinity-1b427f3b-dabe-48c1-a434-82562a3226e1-1448528416329@3capp-webde-bs12>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-1b427f3b-dabe-48c1-a434-82562a3226e1-1448528416329@3capp-webde-bs12>
Subject: Re: [Xenomai] rtdm driver open_rt/nrt handler question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: JK.Behnke@web.de
Cc: xenomai@xenomai.org

On Thu, Nov 26, 2015 at 10:00:16AM +0100, JK.Behnke@web.de wrote:
>    Xenomai 2.6.3 documentation states, that the usage of open_rt handlers
>    is deprecated
>    as this feature will be removed in the future.

Xenomai 2.6.3 is very old now. It is not even the latest release in
the 2.6 branch. open_rt has been removed from Xenomai 3.

>    As a consequence one cannot use rtdm_mutex_lock inside an nrt_open
>    handler
>    to synchronize multiple callers, as this will result in a
>    (!xnpod_unblockable_p()) assertion.
>    So using a spinlock would be the only solution in that situation.
>    Is that true?

No, the caller is a Linux task, or a Xenomai task running in
secondary mode. As such, any Linux service can be used, such as
mutex or semaphores (the Linux ones).

> 
>    By the way, if an rtdm driver only supports RTDM_EXCLUSIVE mode, is
>    there
>    a need to synchronize concurrent calls to rt_dev_open on this device at
>    all?
>    I guess not, because the second caller will be refused.
>    Is that also true?

Yes.

-- 
					    Gilles.
https://click-hack.org

