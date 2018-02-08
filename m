From: Lowell Gilbert <kludge@be-well.ilk.org>
Date: Thu, 08 Feb 2018 18:45:42 -0500
Message-ID: <44eflvcaft.fsf@lowell-desk.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Xenomai] rtdm_timer_start latency?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Am I correct in assuming that when calling rtdm_timer_start(), I should
not be getting multi-second latencies before the first call to the timer
routine? Just checking before I dig in too far.

Thanks.

