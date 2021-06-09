From: Philippe Gerum <rpm@xenomai.org>
Subject: Xenomai 4 kick-off
Message-ID: <87im3jnjyg.fsf@xenomai.org>
Date: Wed, 09 Jun 2021 09:04:31 +0200
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
To: xenomai@xenomai.org, evl@evlproject.org


As hinted some time ago, the EVL project is being gradually merged into
the Xenomai project. As a result, the git trees hosted at
git.evlproject.org are now moving to git.xenomai.org. This code is the
cornerstone of the Xenomai 4 effort, which is now officially live. Many
thanks -once more- to Denx Engineering and particularly to Wolfgang Denk
for providing us with hosting services.

To this end, a xenomai4 sub-group was created in the main Xenomai group
which runs on the official gitlab instance on source.denx.de, for
maintaining the Xenomai 4 resources. The mapping from the old trees to
the new ones is as follows:

git://git.evlproject.org/linux-evl.git -> git@git.xenomai.org:Xenomai/xenomai4/linux-evl.git
git://git.evlproject.org/libevl.git -> git@git.xenomai.org:Xenomai/xenomai4/libevl.git

At this chance, the Dovetail development moved away from linux-evl.git
to its own separate tree at:

git@git.xenomai.org:Xenomai/linux-dovetail.git
https://git.xenomai.org/linux-dovetail.git

The former trees at git://git.evlproject.org will remain accessible
until June 18 2021, please update your scripts/bookmarks to point at
https://git.xenomai.org/xenomai4 before this date.

In addition, the sources of the website currently located at
https://evlproject.org are now available from
git@git.xenomai.org:Xenomai/xenomai4/website.git. This is the base of
the upcoming Xenomai 4 documentation.

If you are interested in knowing more about the EVL real-time core
Xenomai 4 is based on, you may want to visit these pages:
https://evlproject.org/core/
https://evlproject.org/overview/

Thanks,

-- 
Philippe.

