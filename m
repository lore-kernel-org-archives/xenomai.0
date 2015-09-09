Date: Wed, 9 Sep 2015 11:31:51 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20150909113151.0fed6fd7@md1em3qc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] 4.x merge
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>
Cc: "KISZKA, JAN" <jan.kiszka@siemens.com>

Hi,

i am about to merge ipipe into a more recent kernel and would like to
discuss the approach with you guys. As far as i have seen and been told
i should merge and not rebase.

My current plan:
1 choose release (4.1 since its LTS)
2 merge it into ipipe
3 resolve obvious conflicts
4 commit broken merge
5 repair common bits and x86
6 publish my tree for others to repair other archs

Steps 2,3 and 4 might become iterations stepping over 3.19 and 4.0. The
merges will not work but the smaller steps will result in less
conflicts at a time.

What do you guys think of the approach? Are my version choices sane or
are there any reasons to consider other releases as well?

Henning

