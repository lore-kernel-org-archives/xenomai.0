References: <20210327095417.2289913-1-rpm@xenomai.org>
 <20210327095417.2289913-5-rpm@xenomai.org>
 <556e88f0-6b20-ab48-1d22-d0dcf8a2d8f0@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 4/8] lib: y2038: convert to internal timespec type
In-reply-to: <556e88f0-6b20-ab48-1d22-d0dcf8a2d8f0@siemens.com>
Date: Wed, 31 Mar 2021 11:03:51 +0200
Message-ID: <87wntnr8y0.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: chensong@tj.kylinos.cn, Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi Philippe,
>
> which "internal timespec type" are you talking about?

struct __user_old_timespec. The one added to make the user / kernel
boundary wrt time specification explicit.

-- 
Philippe.

