MIME-Version: 1.0
From: Norbert Lange <nolange79@gmail.com>
Date: Tue, 26 Feb 2019 00:10:27 +0100
Message-ID: <CADYdroMXfpiF0Yv+tGg2FGZmKxOiz9e7eUfRE5u9EGgVBzDH_g@mail.gmail.com>
Subject: Re: Fwd: Debugging system freeze, SIGXCPU
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, arimozes@neocisinc.com

> Sure - make sense - IMO just knowing which calls are potentially
problematic is
> the difficult part here.  I expect I will just continue to stumble
through them
> and learn more as I go.

I wrote some checkers that should be able to catch those calls
(had pretty much the same issue, legacy code...).

https://github.com/nolange/preload_checkers

Guinea pigs welcome.

Norbert
