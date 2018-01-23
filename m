From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3b845105-f0b5-6df1-c800-e4bb954d8aa0@siemens.com>
Date: Tue, 23 Jan 2018 18:52:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] ipipe: kernel updates in the light of recent fixes
	(meltdown...)
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

as the number of question increase here, but I bet elsewhere as well,
and I'm planning to work on some parts soonish, I'd like to coordinate:

Where are we standing with 4.14 right now? There is nothing for x86 yet,
right?

What are the update plans for 4.9? We currently have one x86 user on
that kernel, but I suppose we could also move on to 4.14 once it's
ready. For me the question is right now where to invest x86-wise, 4.9
update or 4.14 completion + update?

For 4.4, which we will need for product use for sure, I'm considering to
lift the support from 4.4 LTS to the CIP [1][2] kernel. That one will be
longer maintained and basically differs from LTS only in mainline
backports of certain hardware support and critical features. Plus some
reverts of broken LTS commits that will later on be reverted there as
well. The fuss that meltdown brings in would be a good point to do the
jump IMHO (there is no CIP kernel with meltdown fixes yet, due to issues
in LTS, but that will change soon).

Regarding spectre, I'm not expected that much impact on ipipe, but that
situation is still too much in flux, even in upstream.

What do you think?

@all: What are requirements of other users here?

Jan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-cip.git
[2]
https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipkernelmaintenance

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

