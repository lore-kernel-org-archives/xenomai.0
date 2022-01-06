Message-ID: <de71569b-291a-afad-14f1-6f876b9cffde@siemens.com>
Date: Thu, 6 Jan 2022 09:46:25 +0100
MIME-Version: 1.0
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: mm problems with 5.15.9-dovetail1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

Hi Philippe,

seems we have some issue with the new 5.15 dovetail kernel, see e.g.

https://source.denx.de/Xenomai/xenomai-images/-/jobs/371693
https://source.denx.de/Xenomai/xenomai-images/-/jobs/371694
https://source.denx.de/Xenomai/xenomai-images/-/jobs/371695
(kernel BUG at mm/rmap.c:1049!)

Or are there changes needed on Xenomai side?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

