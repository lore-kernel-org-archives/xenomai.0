Date: Thu, 14 Nov 2019 04:20:56 +0000
From: Jeff Webb <w1@codecraftsmen.org>
Reply-To: Jeff Webb <w1@codecraftsmen.org>
Subject: Xenomai crashes when braking into the debugger
Message-ID: <2u87Hl2UpsEtXAS7EiIuDq2s2Al-bYe3kGo-YcQ6Ei6vQbKRca_XkzuxhFnirsRXDkeM7HoO3_rmpNrifF7yaMpVBWb3uancGND79NzGc5c=@codecraftsmen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jeff Webb wrote:
> I have personally experienced what seems (to me) to be a similar
> issue involving signal handling where a signal handling thread
> received a SIGINT via sigwait (other threads had SIGINT blocked),
> and tried to set a global variable that should have caused the
> other threads to terminate.  The other threads had an issue where
> they would not wake up from sem_timedwait calls (or even sleep
> calls) after the SIGINT was received by the other thread, so they
> would not terminate properly.

I forgot to mention that I solved this issue by creating the
signal handling thread using __STD(pthread_create) instead of the
cobalt version.  When this linux thread received a SIGINT, the
other threads continued to operate normally.  There seemed to be
a difference in behavior even though I also used SCHED_OTHER with
the cobalt pthread_create call.  This may be a clue...  If I can
reproduce the issue again with a simple test case, I will post
it.  I attempted to do this earlier today, but I couldn't
recreate the problem.

Thanks,

-Jeff


