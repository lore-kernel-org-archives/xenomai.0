From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <558043d8-942d-f79e-2e57-cbddeb48aae1@xenomai.org>
Date: Sun, 17 Dec 2017 19:42:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Ongoing work
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>


Some news about the ongoing day-to-day work:

- the Xenomai repository is being rehosted to the gitlab facility
offered by Denx Software Engineering (thanks Wolfgang), which currently
mirrors the original tree. We are working at making the final repository
publicly accessible before Xmas. We are still sorting out details for
making the transition as smooth as possible for users currently pulling
from the original tree.

- the existing documentation pages available from the website have been
made available at [1], and all changes contributed to this material are
first channeled through this repository before ending up on the website.
We can move this documentation to the gitlab wiki once the code
repository is publicly accessible from denx.de.

- A preliminary TODO list was published on the website at [2]. If you
have suggestions, you can submit patches against the TODO.adoc file from
the documentation repository, to get them discussed on this mailing list.

- I have ported the I-pipe for the ARM architecture to kernel 4.14, the
code is available from a new tree at [3]. I will post details about this
work - and a different workflow - in a separate mail later.

- Steven Seeger has started porting the I-pipe for the ppc32
architecture to kernel 4.14 too. His public tree is available at [4].

Thanks,

[1] git://git.xenomai.org/xenomai-kbase.git
[2] https://xenomai.org/todo/
[3] git://git.xenomai.org/ipipe-arm.git
[4] git://git.xenomai.org/ipipe-ppc32.git

-- 
Philippe.


