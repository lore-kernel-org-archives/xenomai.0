MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 13 Mar 2020 09:18:46 +0100
Message-ID: <CAFLxGvw70Rm88zfFXRqLv2_qJkd=k_C-mYxLCX0qnFwCYyGZyg@mail.gmail.com>
Subject: Namespace pollution due to compiler.h in Xenomai 3.1
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

Hi!

Our application uses cobalt/stdio.h, which includes at the end
boilerplate/compiler.h.
compiler.h defines since 3.1 __packed and other gcc attribute helpers
in the global namespace. Is this intended?

We noticed because out application also defines __packed...

-- 
Thanks,
//richard

