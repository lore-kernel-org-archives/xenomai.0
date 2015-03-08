MIME-Version: 1.0
Date: Sat, 7 Mar 2015 23:53:28 -0600
Message-ID: <CA+C+_XSBhPvzuLqrUTLzR63-bu0NsvCZ_u17domFcBy0dTZceQ@mail.gmail.com>
From: Mathew Benson <mathew.benson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] rt_mutex_acquire() timing out
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I'm running 2.6.3. I'm calling rt_mutex_acquire(&handle, TM_INFINITE) but
its returning -110 (ETIMEDOUT).  Under what conditions would it return
ETIMEDOUT when its passed TM_INFINITE?
