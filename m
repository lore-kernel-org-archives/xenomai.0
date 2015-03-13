Message-ID: <55032CCB.3010607@siemens.com>
Date: Fri, 13 Mar 2015 19:30:35 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <1426262234.3156.18.camel@triphase.com>
In-Reply-To: <1426262234.3156.18.camel@triphase.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xeno3_rc3_alchemy What is the effect of
	rt_task_delete on a RT_SEM?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Niels Wellens <niels.wellens@triphase.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2015-03-13 16:57, Niels Wellens wrote:
> Hi,
> 
> While porting our code to xeno3 I noticed that one of our tasks blocked
> on a semaphore during exit (code worked on xeno 2.6.4 Native, some small
> changes where needed for Alchemy but nothing fundamental). It seems that
> deletion of a task that is waiting on a RT_SEM doesn't decrement the
> nwaiters field of the semaphore. Afterwards, when I raise the semaphore,
> the nwaiters decrement without releasing an existing task. Are there
> some changes here in Xeno3? I looked in the migration guide but the only
> remark about semaphores is for posix.
> 
> Please find in attachment a small working example with some comments in
> the exit part of the code.

I've pushed two related patches to
http://git.xenomai.org/xenomai-jki.git/log/?h=for-forge. The first one
fixes the semaphore value after interrupted waiting as you saw it, the
second one the reported nwaiters value if the semaphore is positive
(unrelated but caught by your test case as well).

Thanks for reporting and specifically for preparing the test case that well!

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

