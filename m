MIME-Version: 1.0
From: Andreas Glatz <andi.glatz@gmail.com>
Date: Mon, 30 Jan 2017 12:27:41 +0000
Message-ID: <CAKJ14NckF3bxk=o5k6U7krGyYLKA0bVRNmsNiT4qki==UAR6Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] POSIX socket() call switches to secondary mode
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi

During optimisation I found out that I have a POSIX socket() call for
opening a TCP connection that tends to switch to secondary mode, which
I expected to stay in primary mode. However, then I found a post [1],
which says that it is in fact considered normal behaviour:

"rt_dev_socket may cause a switch to secondary mode, yes, this is
perfectly normal, only sending and receiving data is guaranteed to not
cause a switch to secondary mode."

I also saw that this post was from 2014.... I am wondering now if this
is still considered normal behaviour for the current version of
socket() (POSIX skin of Xenomai 2.4.6 on arm linux 3.0.35)?

Thanks and regards,

Andreas




[1] https://xenomai.org/pipermail/xenomai/2014-December/032759.html

