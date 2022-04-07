MIME-Version: 1.0
From: Yunjie Gu <yunjie.gu1@gmail.com>
Date: Thu, 7 Apr 2022 09:20:05 +0100
Message-ID: <CAKcohPwheCLCT-h-itxuL_Lc0qEZr6KG8e=YGX14Ne=nT40Cfw@mail.gmail.com>
Subject: pthread_cancel services not documented
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi All,

I'm trying to use xenomai with posix interface, and I found some
differences in the documentation for xenomai 2 and xenomai 3. In xenomai
2, pthread_cancel related services (including pthread_setcancelstate, .etc)
are clearly documented. In xenomai 3, however, only pthread_kill is
documented, but it seems other services are still there in source codes. My
guessing is that pthread_cancel related services are managed by the linux
rather than cobalt core and therefore were not explicitly documented in
xenomai 3, and we can use them in the same way as we do in linux. Can
anyone confirm this? See link below

https://xenomai.org/documentation/xenomai-2.6/html/api/group__posix__cancel.html

https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt__api__thread.html#gae1a96424296ef872696c7fb90a8ae9aa

Regards,
Yunjie
