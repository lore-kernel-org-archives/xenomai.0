From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <37666dc8-e631-c846-4fd1-4517f83cbd5d@xenomai.org>
Date: Thu, 14 Jun 2018 19:17:07 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Planning for 3.0.7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>


I'm preparing Xenomai 3.0.7 from the stable branch, which incidentally,
should be the ultimate release I'll be rolling out as the lead
maintainer of this project, before I hand over this role to Jan on
September.

In addition to the various bug fixes since 3.0.6 visible from the git
tree [1], this release enables Xenomai for the 4.14 kernel series. The
I-pipe for kernel 4.14 is currently available for the ARM and ppc32
architectures with the Xenomai 3.0.x series.

The release is due on June 25, unless any last minute red flag is raised
before that date.

Thanks,

[1] git://git.xenomai.org/xenomai-3.git, branch stable-3.0.x

-- 
Philippe.

