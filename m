MIME-Version: 1.0
From: Michael Smith <2michael.smith@gmail.com>
Date: Thu, 4 Feb 2016 17:28:22 +0200
Message-ID: <CANWkrROZXVOO1nSV0yJtky9H5XefA6Jqs8fC5bxGn3Zo5miv7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] DMA userspace access
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi guys.
I am currently converting an existing Linux driver to RTDM.
I came across a read() file operations function where the author uses
the function
get_user_pages() to get a pointer to userspace memory do to a direct
DMA transfer operation to it.
I don't see any equivalent functionality in the RTDM API, so I just
wanted to check if
I'm not missing something.
There are various RTDM functions to map IO & kernel memory to
userspace but not to
aquire and lock userspace pages in order to do a transfer to it like
with this function.

It seems that the only solution in this case is to keep the code as it
is and to call it
in the secondary domain instead of the primary.
Please let me know if there is an alternative way to do this from the
primary domain.

Thanks.
Michael

