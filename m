Message-ID: <4FE6FCED.7040205@xenomai.org>
Date: Sun, 24 Jun 2012 13:41:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtcYjkF+TWLt6jk3_TpytsnZQ469SbBWQL+LCgy5VhEBLQ@mail.gmail.com>
In-Reply-To: <CAKKWdtcYjkF+TWLt6jk3_TpytsnZQ469SbBWQL+LCgy5VhEBLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] questions about the libraries
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai@xenomai.org

On 06/24/2012 12:00 PM, ali hagigat wrote:
> Is there any library file for POSIX interface?

libpthread_rt.so

> What library contains
> the nucleus API?

The nucleus API lives in kernel-space, so, there is no user-space
library for it.

> What is libanalogy.so?

Analogy is a skin containing a set of drivers for analog/digital capture
devices. libanalogy.so is the user-space side of this skin.


-- 
                                                                Gilles.

