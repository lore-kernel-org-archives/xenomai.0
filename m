Message-ID: <trinity-1b427f3b-dabe-48c1-a434-82562a3226e1-1448528416329@3capp-webde-bs12>
From: JK.Behnke@web.de
Date: Thu, 26 Nov 2015 10:00:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] rtdm driver open_rt/nrt handler question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

   Xenomai 2.6.3 documentation states, that the usage of open_rt handlers
   is deprecated
   as this feature will be removed in the future.
   As a consequence one cannot use rtdm_mutex_lock inside an nrt_open
   handler
   to synchronize multiple callers, as this will result in a
   (!xnpod_unblockable_p()) assertion.
   So using a spinlock would be the only solution in that situation.
   Is that true?

   By the way, if an rtdm driver only supports RTDM_EXCLUSIVE mode, is
   there
   a need to synchronize concurrent calls to rt_dev_open on this device at
   all?
   I guess not, because the second caller will be refused.
   Is that also true?

   Thanks for your help
   Jochen
