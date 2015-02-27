Message-ID: <54F0D584.1030307@siemens.com>
Date: Fri, 27 Feb 2015 21:37:24 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <54F0CF9E.1040707@siemens.com>
 <20150227202453.GK434@hermes.click-hack.org>
In-Reply-To: <20150227202453.GK434@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] Consolidated exception prologue/epiloge for x86
 and ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2015-02-27 21:24, Gilles Chanteperdrix wrote:
> On Fri, Feb 27, 2015 at 09:12:14PM +0100, Jan Kiszka wrote:
>> Hi,
>>
>> just pushed a first implementation of the general model that I proposed
>> for exception handling. You can find it at
>>
>> http://git.xenomai.org/ipipe-jki.git/log/?h=queues/trap-rework
> 
> NACK. The ARM implementation is broken, re-enabling hardware irqs
> before stalling root is wrong.

Ok, will adjust.

> 
> Besides, I find that
> 
> 
> if (foo) {
>    bar;
> } else {
>   qux;
> }
> 
> When there is nothing after adds useless indentation.
> 
> if (foo) {
>    bar;
>    return;
> }
> 
> qux;

Which function?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

