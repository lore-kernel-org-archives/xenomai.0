From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <968f7e35-f447-40d9-0d41-0ed8f13c59f5@siemens.com>
Date: Thu, 13 Jul 2017 21:59:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [RFC] Remove generated docs from git
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

would it be possible to remove the generated docs from git? When doing
full-text searches, it's extremely unhandy to have them in history
(that's unfortunately too late now) and in the current repo (git grep).
Moreover, they add more and more bloat to the repo.

I suppose you make use of them when generating release tarballs and for
pushing them to the webserver. But both could also be scripted, I'm sure.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

