Message-ID: <1495194985.29062.9.camel@smigroup.net>
From: Mauro Salvini <mauro.salvini@smigroup.net>
Date: Fri, 19 May 2017 13:56:25 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] TM_INFINITE and TM_NONBLOCK not documented for some
	functions
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi,

reading 3.0.4 API documentation I discovered that for some blocking
functions (e.g. rt_sem_p(), rt_mutex_acquire(), rt-event_wait() and
relative _until calls) is not documented that TM_INFINITE or TM_NONBLOCK
can be passed as timeout argument. Also on master branch sources doxygen
code for these functions does not report that.
Is this wanted or is a documentation leak? In the latter case, I can
submit a patch to fix it.

Thanks in advance, regards
Mauro


