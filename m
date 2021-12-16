MIME-Version: 1.0
References: <aa070ad1-89ca-f8eb-3b88-b3c2e7d11b87@siemens.com>
In-Reply-To: <aa070ad1-89ca-f8eb-3b88-b3c2e7d11b87@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Thu, 16 Dec 2021 00:47:49 -0800
Message-ID: <CA+K1mPGWep5ceZmry1cdhNv9z3ftqWo+HSN-70i1NaPe4E_1ig@mail.gmail.com>
Subject: Re: stable/v3.2.x started, future of other stable branches
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai List <xenomai@xenomai.org>

It is very important to our project that 3.1 be maintained, as we are
still in the stage of testing our porting effort from 2.6 to 3.1.
Thank you for 3.1!  Ideally a stable branch like 3.1 should get
bugfixes (but no new features) for at least the first year of its
successor (3.2) so as to insure that the successor itself becomes
stable during that period.  The most reliable place to develop is on a
stable branch, getting bugfixes. That is crucial to the success of
development, a product using Xenomai, and its users.

-C Smith

On Wed, Dec 15, 2021 at 2:48 AM Jan Kiszka via Xenomai
<xenomai@xenomai.org> wrote:
>
> Hi all,
>
> in order to permit ABI/API breaking changes in next/master, I've just
> started the stable/v3.2.x based on current master. On xenomai-images
> side, CI/CT has been updated as well to account for that [1].
>
> As already indicated in [1], one change planed for master is to drop
> I-pipe support, thus kernels < 5.10. Therefore, CI for master is already
> limited to that scope.
>
> Now the question is how to continue with stable maintenance. I do have
> users on 3.0.x, thus I plan to keep that alive (though it is definitely
> calming down now). For 3.1.x, I'm lacking a feeling how the userbase is
> and how motivated that base is to consume stable updates vs. to move
> forward to 3.2.x. Any indications on that will help to decide about that
> branch. Without any feedback, I would push out yet another 3.2 release
> early next year and then close the branch.
>
> With that, I wish you already happy vacations (those who plan to) - I'll
> be offline from next week on and will be back in January.
>
> Jan
>
> [1]
> https://source.denx.de/Xenomai/xenomai-images/-/commit/beea63dd69ab6cf762f8d52748677d8e6be30be3
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
>

