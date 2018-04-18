References: <8cb23a1388df4237bd2b132fe0addd83@ocnapvsw3301.ocr.priv>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c7507d3b-9477-e834-e0e4-f8f7dee397c1@siemens.com>
Date: Wed, 18 Apr 2018 08:44:22 +0200
MIME-Version: 1.0
In-Reply-To: <8cb23a1388df4237bd2b132fe0addd83@ocnapvsw3301.ocr.priv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] kernel panic - xenomai3.0.6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fazio Maurizio <maurizio.fazio@leonardocompany.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2018-04-17 17:27, Fazio Maurizio wrote:
> Good morning,
> I’ve attached a kernel panic problem that occurs during the execution of my application.
> Have you some ideas?
> 
> Cpu:  Intel Core i7
> OS: Centos 7 64bit with kernel 3.18.20 and path Xenomai 3.0.6

Please use a supported kernel version. That is currently 4.9 [1] or
4.4-based [2].

Then please catch such bugs (if they still occur) as text log, using a
UART console or netconsole to extract the information from the machine.
We cannot see in your picture if that was the first issue the kernel
found or just a subsequent fault.

Jan

[1] http://git.xenomai.org/ipipe.git/log/?h=ipipe-4.9.y
[2] http://git.xenomai.org/ipipe-jki.git/log/?h=for-upstream/4.4-update

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

