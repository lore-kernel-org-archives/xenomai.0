References: <55B0B2EA.8000602@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <55B0B5CA.9080608@siemens.com>
Date: Thu, 23 Jul 2015 11:37:14 +0200
MIME-Version: 1.0
In-Reply-To: <55B0B2EA.8000602@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_print_auto_init()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 2015-07-23 11:24, Philippe Gerum wrote:
> 
> Hi Jan,
> 
> Do you still have a use case for calling rt_print_auto_init(false) or
> not calling rt_print_auto_init(true) from libcobalt's bootstrap code?
> 

Huh, that was a day-one feature, now 8 years old, barely remember the
details. I'm currently not aware of a concrete scenario. It definitely
makes sense to revisit this think.

I guess one, if not the major problem back then was that the implicit
malloc of the initialization step was not consistently causing a
SIGDEBUG warning. That is now different.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

