MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 4 Sep 2018 09:56:50 +0200
Message-ID: <CAFLxGvwYj_Yf210DV+GHv_bNuuR4uo0cC=7b37ZztQj4Y+cQPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Question on internal_get_unmapped_area()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi!

In kernel/cobalt/rtdm/drvlib.c your internal_get_unmapped_area() just
returns the requested virtual address. Shouldn't it at least check for
the address being aligned to PAGE_SIZE?
And much more important, on VIVT systems it has to enforce alignment to SHMLBA.

-- 
Thanks,
//richard

