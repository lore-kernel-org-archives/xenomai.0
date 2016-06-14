References: <E1b6BNz-0003TC-QN@sd-51317.xenomai.org>
 <20160614155740.GE23680@hermes.click-hack.org> <57602CA7.5050108@siemens.com>
 <20160614170443.GH23680@hermes.click-hack.org> <57603EB6.9040605@siemens.com>
 <20160614184022.GI23680@hermes.click-hack.org> <57605662.9060106@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5760572D.60803@siemens.com>
Date: Tue, 14 Jun 2016 21:12:45 +0200
MIME-Version: 1.0
In-Reply-To: <57605662.9060106@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/kernel: Allow to
 restart clock_nanosleep and select after signal processing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 2016-06-14 21:09, Jan Kiszka wrote:
> On 2016-06-14 20:40, Gilles Chanteperdrix wrote:
>> BTW, XNRESTART is a bad name. It does not say at all what this bit
>> means.
> 
> The art of finding a telling but not too lengthy name. Would
> XNSYSRESTART be sufficient already? Again: proposals welcome.

Or XNSYSRST - to stay within the current length limit. Can lift that as
well, just need a word.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

