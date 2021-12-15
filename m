From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: stable/v3.2.x started, future of other stable branches
Message-ID: <aa070ad1-89ca-f8eb-3b88-b3c2e7d11b87@siemens.com>
Date: Wed, 15 Dec 2021 11:48:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi all,

in order to permit ABI/API breaking changes in next/master, I've just
started the stable/v3.2.x based on current master. On xenomai-images
side, CI/CT has been updated as well to account for that [1].

As already indicated in [1], one change planed for master is to drop
I-pipe support, thus kernels < 5.10. Therefore, CI for master is already
limited to that scope.

Now the question is how to continue with stable maintenance. I do have
users on 3.0.x, thus I plan to keep that alive (though it is definitely
calming down now). For 3.1.x, I'm lacking a feeling how the userbase is
and how motivated that base is to consume stable updates vs. to move
forward to 3.2.x. Any indications on that will help to decide about that
branch. Without any feedback, I would push out yet another 3.2 release
early next year and then close the branch.

With that, I wish you already happy vacations (those who plan to) - I'll
be offline from next week on and will be back in January.

Jan

[1]
https://source.denx.de/Xenomai/xenomai-images/-/commit/beea63dd69ab6cf762f8d52748677d8e6be30be3

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

