From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: linux-v5.10.y-dovetail
Message-ID: <b711cb1b-096c-d278-02be-ed8ff208a568@siemens.com>
Date: Thu, 20 May 2021 20:35:38 +0200
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hi Philippe,

first, is source.denx.de/Xenomai/xenomai4/linux-evl.git already
replacing git.evlproject.org/linux-evl.git? At least CI is currently
stuck over the latter [update: was stuck, it's moving again].

Regarding 5.10, I think we are getting closer to the point where our
users also need a merging stable branch to track what happens
dovetail-wise (at least I have such folks). Would you move
linux-v5.10.y-dovetail in that way forward from now on? Or is there a
need for one more hard rebase first?

Some linux-v5.10.y-dovetail-rebase for the latest version could still be
provided in order to ease export to downstream kernels. That would bring
us in line with how -rt is maintained e.g.

If you need help on the stable side, let me know.

Thanks,
Jan

