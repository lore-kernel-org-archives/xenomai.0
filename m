References: <CAJZRki9RpfcQQ+c8oz1bJ7RsFQE4MrsQdULxvHAuh-STi0fhkQ@mail.gmail.com>
From: Paul Janzen <pcj@xenomai.sez.to>
Date: Thu, 09 Apr 2015 14:11:53 -0700
In-Reply-To: <CAJZRki9RpfcQQ+c8oz1bJ7RsFQE4MrsQdULxvHAuh-STi0fhkQ@mail.gmail.com> (Phil
 Mitchell's message of "Thu, 9 Apr 2015 16:52:26 -0400")
Message-ID: <oqegntropy.fsf@merlin.sez.to>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Xenomai] Why does mqueue.h define mqd_t as unsigned
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Phil Mitchell <p.mitch@gmail.com>
Cc: Xenomai Mailing List <xenomai@xenomai.org>

Phil Mitchell <p.mitch@gmail.com> writes:

> mqueue.h defines mqd_t as an unsigned long. The function mq_open returns
> type mqd_t and states that -1 is returned in case of error.
>
> Is mqd_t defined incorrectly or am I missing something?

The man page says mq_open returns (mqd_t)(-1) on error. If you include
that cast when you test the return value it works, even if mqd_t is
unsigned.  (Or a pointer.)

-- Paul

