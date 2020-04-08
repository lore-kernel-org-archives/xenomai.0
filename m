Subject: =?utf-8?q?Re=3A_rt=5Ftask=5Funblock=28=29_POSIX_alternative?=
Date: Wed, 08 Apr 2020 11:44:06 +0200
From: =?utf-8?q?Petr_=c4=8cervenka?= <grugh@centrum.cz>
References: <20200407154117.5D7D71C2@centrum.cz>,
 <b9ce43ab-526d-71b8-c761-150dc7c1fd3f@siemens.com>,
 <20200407171816.E0B3979D@centrum.cz>
 <CAFLxGvx2EhOgUnB1VkW+7TendLUcsZ0XGGcwYhiPw7PcxwFkTw@mail.gmail.com>
In-Reply-To: <CAFLxGvx2EhOgUnB1VkW+7TendLUcsZ0XGGcwYhiPw7PcxwFkTw@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <20200408114406.6119E0D9@centrum.cz>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?q?Richard_Weinberger?= <richard.weinberger@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

> Use pthread_kill() plus a custom signal. Such as SIGRTMIN + 2.
Calling of kill() or pthread_kill() does not help. Nothing is able to interrupt read() from timerfd (only pthread_cancel). Do I have to prepare the task or timerfd to be interruptible by a signal?
Petr

