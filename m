MIME-Version: 1.0
Date: Thu, 9 Apr 2015 16:52:26 -0400
Message-ID: <CAJZRki9RpfcQQ+c8oz1bJ7RsFQE4MrsQdULxvHAuh-STi0fhkQ@mail.gmail.com>
From: Phil Mitchell <p.mitch@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Why does mqueue.h define mqd_t as unsigned
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai Mailing List <xenomai@xenomai.org>

Dear All,

mqueue.h defines mqd_t as an unsigned long. The function mq_open returns
type mqd_t and states that -1 is returned in case of error.

Is mqd_t defined incorrectly or am I missing something?

Thanks,
Phil Mitchell

