From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c62e4ab4-a439-9e7a-5e84-43702f2ffbf7@siemens.com>
Date: Wed, 14 Jun 2017 11:30:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] x86/ipipe: force lazy FPU management
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

this commits looks fishy: the original code already disabled eager mode
reliably because of

if (cpu_has_xsaveopt && eagerfpu != DISABLE)
                        ^^^^^^^^^^^^^^^^^^^

right after the original disabling under I-pipe. Instead, the new code
now keeps xfeatures_mask untouched as it performs the disabling too
late. Could you clarify this?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

