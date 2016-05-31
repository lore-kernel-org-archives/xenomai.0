References: <E1b7OM2-0000oL-Q7@sd-51317.xenomai.org>
 <20160530152043.GE17483@hermes.click-hack.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <574D702F.6000303@siemens.com>
Date: Tue, 31 May 2016 13:06:23 +0200
MIME-Version: 1.0
In-Reply-To: <20160530152043.GE17483@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : lib/cobalt: Provide
	RT-capable usleep
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

On 2016-05-30 17:20, Gilles Chanteperdrix wrote:
> On Mon, May 30, 2016 at 04:39:42PM +0200, git repository hosting wrote:
>> Module: xenomai-jki
>> Branch: for-forge
>> Commit: ec9a8c81944d4a3e3f50af314fa58ade68dd28c2
>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=ec9a8c81944d4a3e3f50af314fa58ade68dd28c2
>>
>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>> Date:   Mon May 30 14:58:07 2016 +0200
>>
>> lib/cobalt: Provide RT-capable usleep
>>
>> User may expect this (probably last) sleeping service to be available
>> under Cobalt just like sleep, nanosleep & Co.
> 
> CONFORMING TO
>        4.3BSD,  POSIX.1-2001.   POSIX.1-2001  declares this function obsolete;
>        use nanosleep(2) instead.  POSIX.1-2008 removes  the  specification  of
>        usleep().

Do you expect people - and specifically Linux - to follow this soon?

The idea here is to reduce the level of surprise, and as long as using
usleep in your app doesn't cause an "undefined symbol" error, this risk
persists.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

