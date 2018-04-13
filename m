From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7be9b9c7-7393-eca0-6a86-bcf3d0302271@siemens.com>
Date: Fri, 13 Apr 2018 17:40:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] locking in copperplate/registry.
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

next userspace locking questions:

- Why are we using RT locks for protecting registery data structures?
  To my understanding, all these functions run without any RT
  requirements.

- Does this pattern make sense at all?

  read_lock_nocancel(); /* That means the caller must have cancellation
  ...                      off, no? */
  ...
  CANCEL_DEFER();
  ...

  I'm seeing this in a couple of functions in that module.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

