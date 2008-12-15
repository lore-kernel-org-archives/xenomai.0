Message-ID: <4946872D.8000009@domain.hid>
Date: Mon, 15 Dec 2008 17:34:53 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20081215143435.15493.94798.stgit@domain.hid>
	<494684E5.9070807@domain.hid>
In-Reply-To: <494684E5.9070807@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH  0/6] Various fixes and cleanups
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Here is a queue of patches that piled up on my side. Most have been
>> posted earlier already, find details in the descriptions. I have some
>> more that will be posted later this week.
>>
>> All patches are also available at
>> git://git.kiszka.org/xenomai.git assorted-queue
>>
>> Jan
>>
>> PS: BTW, I started mirroring the Xenomai SVN on my server. So far I pull
>> from SVN on 1:00, 12:00 and 18:00 (CET), maybe I will subscribe some
>> robot to the svn-commit list later. Feel free to make use of this
>> service as you like. For me it is a tool to keep control over my
>> various patch queues, and using only git (+stg) for this simplified
>> things significantly.
>>
> 
> I'm git-based on my side as well. At some point we should get rid of SVN altogether.
> 

That would be great. As I don't feel brave enough for a "git svn
dcommit" from my cloned tree, I still have to apply patches on a real
SVN repository whenever I have to commit on my own.

Once we switched to git, please also let us discuss how to deal with
ChangeLog in the future. Describing modifications twice or more is not
very efficient (nor motivating for a lazy developer). If we want some
high-level description in that file, then let's define what to be logged
there, and how. Its current level of details appears to be overkill
IMHO. I would prefer to focus on more verbose git commit logs.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 26
Corporate Competence Center Embedded Linux

