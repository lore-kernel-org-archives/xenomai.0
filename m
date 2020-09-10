From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Useless dovetail hacks
Message-ID: <55694df3-85a8-cca8-1801-d55a4e7f0e53@siemens.com>
Date: Thu, 10 Sep 2020 18:47:36 +0200
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
Cc: "Meng, Fino" <fino.meng@intel.com>, "Pirou, Florent" <florent.pirou@intel.com>, "Wang, Rick Y" <rick.y.wang@intel.com>, "Hu, Mingliang" <mingliang.hu@intel.com>

Hi all,

to permit sharing the work of porting Xenomai over dovetail, I finally
pushed my baseline hacks to [1]. You can "use" that on [2] (use
fa1e9ba5e822, 0d68e5607286 leaks evl bits and is broken) just like you
would for an I-pipe kernel (prepare-kernel.sh). The thing builds for me,
it even starts and gives a prompt, but that's because of

[    1.186025] [Xenomai] init failed, code -19

All the timing stuff is not mapped yet. Like a lot of other things. ETIME...

Please raise your hand when you'd like to join this endeavor, then we
can discuss a split-up of tasks. Next steps would be:

- make it initialize dovetail properly and activate Xenomai
- hack on it until Xenomai tasks work properly
- look at the result an decide how to integrate with I-pipe or whether
  to make this Xenomai 3.2 without any I-pipe support

Jan

[1] https://gitlab.denx.de/Xenomai/xenomai/-/tree/wip/dovetail
[2] https://git.evlproject.org/linux-evl.git/log/?h=dovetail/master

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

