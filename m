Subject: Re: Question about NMIs and Xenomai.
References: <CAAvDm6axS26JLd173jd_7Q9zpzWACHmoxyiV5aiJ30qsVF-RyA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6301dbb7-54a4-2c47-230b-7399ef71667f@siemens.com>
Date: Tue, 14 Jul 2020 09:45:40 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6axS26JLd173jd_7Q9zpzWACHmoxyiV5aiJ30qsVF-RyA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>, xenomai <xenomai@xenomai.org>

On 14.07.20 08:52, 孙世龙 sunshilong via Xenomai wrote:
> Hi, list.
> 
> I have googled for a long time and read the posts on the official
> website(besides <<Life-with-Adeos>>) carefully, but I still can't find
> the answers which directly answer these questions about NMIs:
> *Is it possible that NMI watchdog influences the latency of Xenomai?
> *Is it possible that Xenomai threads(which are busy running for
> several seconds) block the Linux domain from handling the non-maskable
> interrupts?
> 
> I would be grateful if somebody shed some light on these questions.
> Yours sincerely.
> 

Neiher Xenomai nor I-pipe block NMIs. If Linux is configuring them for 
certain debugging or observation purposes, e.g. perf, they hit also the 
real-time domain.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

