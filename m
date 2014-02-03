Message-ID: <52EF93B6.6080606@siemens.com>
Date: Mon, 03 Feb 2014 14:03:50 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <52EBA6D0.2010208@siemens.com> <52EBAE26.8050901@xenomai.org>
In-Reply-To: <52EBAE26.8050901@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] forge/cobalt: Do we need to wrap all POSIX calls for
 non-POSIX skins?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 2014-01-31 15:07, Philippe Gerum wrote:
> On 01/31/2014 02:36 PM, Jan Kiszka wrote:
>> Hi,
>>
>> was asked why, e.g., xeno-config --skin=alchemy --ldflags returns
>> -Wl,@/data/xenomai-forge/inst64/lib/cobalt.wrappers. Is there a
>> technical reason? On first glance and after minimal testing, it seems
>> not.
>>
> 
> There is no technical reason, since all libs are required to use manual
> wrapping for these symbols (e.g. __RT()/__STD()) to keep automatic
> wrapping via the linker optional.
> 
> The current assumption is that application code using cobalt-provided
> routines do want such wrapping to take place automatically, for mixing
> APIs.
> 
> OTOH, we could require such applications to mention --posix explicitly
> for enabling this feature. It makes sense either way. We need to ponder
> which one follows the principle of least astonishment.

I would suggest explicit listing of --skin=posix|cobalt, thus this
patch:
http://git.xenomai.org/xenomai-jki.git/commit/?h=for-forge&id=eb8a1d4a69836c073461947eaab775b5fc7c01aa.
That is more consistent because there is no way to disable that wrapping
(except for fragile filtering on the returned ldflags).

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

