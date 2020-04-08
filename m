Subject: Re: What function does cobalt_thread_probe() provides.
References: <20200408115535.628C1F0D@centrum.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <71837375-fdaf-b01c-c25b-e41fe6a7acdc@siemens.com>
Date: Wed, 8 Apr 2020 12:38:02 +0200
MIME-Version: 1.0
In-Reply-To: <20200408115535.628C1F0D@centrum.cz>
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
To: =?UTF-8?Q?Petr_=c4=8cervenka?= <grugh@centrum.cz>, Xenomai <xenomai@xenomai.org>, sunshilong369@gmail.com

On 08.04.20 11:55, Petr Červenka via Xenomai wrote:
> Kill doesn't mean to "kill" anything, but to send a signal to a thread.
> I bet that cobalt_thread_probe() is meant to send a signal 0 with no reaction, only to find out if the thread exists and is xenomai capable.
> Petr
> 

Exactly.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

