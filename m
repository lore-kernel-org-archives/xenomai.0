References: <cover.1623434743.git.jan.kiszka@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 00/17] Dovetail integration - the finals
In-reply-to: <cover.1623434743.git.jan.kiszka@siemens.com>
Date: Sun, 13 Jun 2021 19:07:34 +0200
Message-ID: <87r1h57kx5.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org, Hongzhan Chen <hongzhan.chen@intel.com>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On top, I would also still like to understand - and ideally address
> prior to releasing a new major version - if we cannot align the ARM
> syscall ABI of Xenomai to the kernel /wrt argument passing. Now is a
> good chance to do that.

That would be fairly simple implementation-wise, problem though: this
would require to add this change to the next I-pipe/arm releases,
invalidating all previous I-pipe releases for 3.2 in the same move. In
theory, all existing I-pipe/arm patches starting from kernel 3.10 can
run the -next branch (although it may be better to stick with 4.14+ in
practice).

-- 
Philippe.

