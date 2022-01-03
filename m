Message-ID: <c0473efe-2766-790e-f001-b1a20da8ecd0@siemens.com>
Date: Mon, 3 Jan 2022 14:12:19 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] Added verbosity to 16550A serial driver.
Content-Language: en-US
References: <20211217073655.56036-1-ksmola51@gmail.com>
 <CAC2JQeiute4x2hDno72pL9P5JNGZbRBVbGT17g-mz5s4rmv+Qg@mail.gmail.com>
 <CA+K1mPF-EL0pkUOr7XrPEy9p0N20Md6=exDm6zbi4rmHSUH+pA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CA+K1mPF-EL0pkUOr7XrPEy9p0N20Md6=exDm6zbi4rmHSUH+pA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>, k smo <ksmola51@gmail.com>
Cc: Xenomai List <xenomai@xenomai.org>

On 17.12.21 08:55, C Smith wrote:
> There are development scenarios where different versions of a driver
> are substituted. I can tell you some long stories when one day we meet
> over a few beers...

I can imagine those cases - but only when you patch the driver locally
anyway. In that case, a local instrumentation patch is not an issue to
carry along that.

If you are using Xenomai upstream, the driver version is defined by the
Xenomai version. If you like to make that more precise, submit a patch
that also forwards (prepare-kernel.sh -> XENO_VERSION_SRCREV) and dumps
(kernel/cobalt/init.c, sys_init) the git revision. That may even solve
your local modification scenario as well if that uses git to manage the
changes.

There are reasons why Linux no longer prints version information for
drivers as well (except for historic cases). The kernel version /
revision is sufficient, and the boot log would explode if every loaded
driver did that.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

