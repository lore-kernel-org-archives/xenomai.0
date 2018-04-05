References: <99BAB48E90E86D42AD41F0BCE3225AEB019FC0631A@GRZSMS582.andritz.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bbb33d4c-e8d0-b383-0424-d99592486988@siemens.com>
Date: Thu, 5 Apr 2018 16:55:02 +0200
MIME-Version: 1.0
In-Reply-To: <99BAB48E90E86D42AD41F0BCE3225AEB019FC0631A@GRZSMS582.andritz.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] building Xenomai Apps with CMake (RFC)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>, Henning Schild <henning.schild@siemens.com>

On 2018-04-03 16:10, Lange Norbert wrote:
> Hello,
> 
> I went ahead and created a script to add support for Xenomai (3+) to CMake. Its currently sufficient for me,
> but I would like to get this in a shape that it is useful and robust enough for most people.
> Ultimately it should end up up streamed to CMake (I hope the binutils-specific wrappers aren't a knock-out against adoption).
> 
> Mostly this should interest people that want to use CMake, but a few things might need support from the Xenomai distribution.
> To be more specific: using precompiled object-files like the boostrap code and its linker wraps and redirections are something I would
> like to avoid, or atleast offer an alternative that does not need that much work outside of a "regular build".
> For that, having the bootstrap code (configurable or a few variants) installed as sourcecode would help.
> 
> Code is uploaded to Github : https://github.com/nolange/cmake_xenomai

Thanks for sharing this. IIRC, we have some Xeommai user in-house as
well who looked into cmake, need to check the status and scope again
(maybe Henning knows more). Could be interesting, indeed.

For my understanding: You need cmake upstream changes to make things
work? Or is this project something that could eventually be carried in
Xenomai upstream, just requiring some cmake version >= X?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

