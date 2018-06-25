From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <f9fc1bc9-5794-4408-8f85-f7ad3a12a05e@xenomai.org>
Date: Mon, 25 Jun 2018 11:25:33 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Xenomai 3.0.7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>


Xenomai 3.0.7 is out [1]. The GIT repository can be cloned from [2].

Some GPIO driver updates, several bug fixes in the Cobalt core, and a
critical bug removed from the pshared heap (for users of non-POSIX APIs
building with --enable-pshared).

An effort to sanitize some legacy from RTnet causing invalid accesses
from kernel space to userland memory also stands out, although more work
remains in this area.

This release supports up to the Linux 4.14 series for ARM, ARM64 and
PPC32. Work is still ahead for running Cobalt over 4.14/x86 though.

[1] http://xenomai.org/downloads/xenomai/stable/latest/
[2] https://git.xenomai.org/xenomai/

-- 
Philippe.

