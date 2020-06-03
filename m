Subject: Re: "invalid use of FPU" on x86_64 architecture
References: <em9b7bdc8b-b4c0-42d6-9bb9-715021076898@nbmcorallini>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c64eec68-a4b8-18a8-0b98-7893ba2bb83d@siemens.com>
Date: Wed, 3 Jun 2020 17:08:35 +0200
MIME-Version: 1.0
In-Reply-To: <em9b7bdc8b-b4c0-42d6-9bb9-715021076898@nbmcorallini>
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
To: Marco Corallini <MCorallini@sigmaspa.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03.06.20 16:48, Marco Corallini via Xenomai wrote:
> Hi all.
> 
> I've got an application running on linux 4.1.18 with Xenomai 2.6.5
>   (commit 917dcebb26ec492f276cdc3b55867aa90e01fa12).

Unfortunately, both are completely unsupported versions by now. Any
chance to reproduce the issue on a maintained configuration?

A lot of bugs have been addressed since then, and it would a huge effort
to find out which could be relevant. And then the next question will be
if those could still be backported.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

