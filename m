MIME-Version: 1.0
From: Norbert Lange <nolange79@gmail.com>
Date: Thu, 23 Nov 2017 13:17:46 +0100
Message-ID: <CADYdroPKrKnkUEDvY84Ez47Ua98GxvgcSy54vt9KCy5U7CYO8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] [RFC] Service hosting for Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

Yes, if Xenomai moves to such a service it only makes sense if all
additional workflows that fit, will move along.

Regards to issues with mailing lists:

At work I have a rather big problem, that the Office infrastructure
doesn't cater to mailing lists, and the IT will violently filter out
most protocols. This is the reason you won't get an email from my
office account, and I am usually to lazy to copy over replies not
directly addressed to me.

There is no such issues with web-based interfaces or ssh.

Gitlab/Github:
How Gitlab/github works can be seen on big projects, and IMHO its no
surprise that they meanwhile host a huge amount of projects.

-   you can search in issues (vs. some external services for mailing
lists, which never worked in a useful manner when I tried)
-   you can tag issues
-   you can add them to milestones
-   you can merge patchsets (organised in branches) to master, get
them checked and commented
-   you can pickup work from anyone, by simple using their branch.

Particularly the last is a killer argument for me, since getting a
valid source tree from multiple mails is time consuming. with a modern
service, if you want a u-boot with fixes for RK3288 from various
sources, just go there:
https://github.com/nolange/u-boot/commits/ethernet_new and add yours
on top or try rebasing, cherry-picking. You have a working setup with
a single git clone at any rate.

And anything is intuitively accessible and visible via a GUI.

The disadvantages:
-   you need to register (theoretically you dont need to register for
mailing lists, but practically you still do most of the times...)

In short, if you want anything comparable with Mailing lists you will
have to add services on top for handling issues (patchwork, bugzilla,
search).

Or to put it another way: what workflows in regards to mailing lists
will be broken and can`t easily adapted? (git-push instead of
git-sendmail)

Kind regards,
Norbert

