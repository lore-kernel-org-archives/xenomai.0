Subject: Re: Can ipipe support for arch MIPS ?
References: <c6477e9d-15cc-3182-f17b-c3af18c23df4@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7f1048c3-d257-3fe9-b24a-a7b983980744@siemens.com>
Date: Mon, 21 Sep 2020 07:57:29 +0200
MIME-Version: 1.0
In-Reply-To: <c6477e9d-15cc-3182-f17b-c3af18c23df4@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: carver4lio@163.com, xenomai@xenomai.org

On 19.09.20 16:38, carver4lio--- via Xenomai wrote:
> Hello,
> 
> I noticed that ipipe has been adapted to various architectures such as ARM,
> x86, powerPC, but does not include MIPS. Is this an issue left over from
> history? Or is it technically inappropriate for arch MIPS?

A couple of downstream ports of I-pipe existed IIRC, none was ever 
proposed for upstream. So there is no technical issue with the arch per 
se. It's just that it is so much niche that no one was willing to lift 
and maintain it officially.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

