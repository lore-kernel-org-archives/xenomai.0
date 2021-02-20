From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: Y2038 re-sync request
Message-ID: <375d9f2d-4182-cc45-6ac1-12fa44b7af96@siemens.com>
Date: Sat, 20 Feb 2021 20:07:26 +0100
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org, rick.y.wang@intel.com, chensong <chensong@tj.kylinos.cn>

Hi all!

I'm a little bit surprised to see patches caring about the Y2038 problem
coming up. I guess Song and me have been to silent in the last months
due to new year vacations and internal schedules...

Maybe it's time to re-sync. CCing Rick as organizer of the community
call minutes. Maybe we can get a timeslot in the meeting for that topic.
Song already mentioned via private channel that he would be available as
well.

The results of our investigations can be found here [1]. When we started
we tried to stay fully backward compatible, so allowing updates of
libcobalt without any need to update the Cobalt core as well. That may
no longer be necessary, so let's discuss it. (IOW: Do we need a Y2038
safe Xenomai 3.1?)

Btw: It isn't to late yet. Song reviewed [1] again over the weekend and
we planned to discuss the roadmap with you within the next week(s). So
Philippe was some kind of "ahead of time" for us ;-)

Happy hacking!

Florian

[1] https://gitlab.com/fbezdeka/xenomai/-/wikis/Y2038_Roadmap


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

