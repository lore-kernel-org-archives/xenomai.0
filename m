From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai Hacker Space @gitlab.com
Message-ID: <ff21d617-4a4e-4fe6-ed6e-6c8072aa0dc2@siemens.com>
Date: Wed, 17 Mar 2021 12:26:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

in order to make central project resources more accessible to
contributors, I've set up a mirror of the main Xenomai repository on
gitlab.com:

https://gitlab.com/Xenomai/xenomai-hacker-space

This hacker space shall not replace the official project page but
augment it. Users with gitlab.com accounts can file issue or comment on
them, developers can request access in order to edit the wiki, and - in
the future - also benefit from CI and test lab resources Siemens is
donating to the project.

I've migrated two things from the main repo to gitlab.com:

 - Xenomai and xenomai-images issue trackers (to enable broader access
   and use)

 - CI builds of main Xenomai, but not of xenomai-images (and, thus, CT
   via LAVA)

The latter migration allows us to use the free shared runners of
gitlab.com, reducing load and costs of our CI farm.

If you are interested in using resources that require developer access
(currently only the wiki), let us know on the list (to make this
transparent), specify your account name and then request access via
gitlab.com so that I can grant it.

Happy hacking,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

