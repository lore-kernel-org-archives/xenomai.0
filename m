Subject: Re: "cobalt/vfile: seq_file seek index must progress"
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <f31cf9eb-1bbe-f4ea-cf7e-ba10f3969236@siemens.com>
Message-ID: <f6e381d0-2325-2b4c-31be-37c0b2574512@siemens.com>
Date: Fri, 21 May 2021 11:48:09 +0200
MIME-Version: 1.0
In-Reply-To: <f31cf9eb-1bbe-f4ea-cf7e-ba10f3969236@siemens.com>
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

On 20.05.21 18:13, Jan Kiszka wrote:
> Hi Philippe,
> 
> https://source.denx.de/Xenomai/xenomai/-/commit/dd9a5ee0ed6f734f40d3733f9fff23394c8647bd
> 
> Bug fix unrelated to dovetail? There is no description, so I cannot
> easily asses this.
> 

Also, it seems to revert parts of
https://source.denx.de/Xenomai/xenomai/-/commit/4cc1e7727d2144098e2f512be71dfe7199d0f7cd
- granted, that was 11 years ago and had no description either.

I'd like to clarify this before tagging some 3.1.1.

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

