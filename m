Message-ID: <51B726CE.2010201@siemens.com>
Date: Tue, 11 Jun 2013 15:31:58 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <51A30F04.701@xenomai.org> <51A39043.5010609@xenomai.org>
	<51B70BF0.9040904@siemens.com> <51B724A9.4040307@xenomai.org>
In-Reply-To: <51B724A9.4040307@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] git://git.xenomai.org/ipipe.git reshuffle,
	3.8.0 kernel support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 2013-06-11 15:22, Philippe Gerum wrote:
> On 06/11/2013 01:37 PM, Jan Kiszka wrote:
>> On 2013-05-27 18:56, Philippe Gerum wrote:
>>> On 05/27/2013 09:45 AM, Philippe Gerum wrote:
>>>>
>>>> The I-pipe tree at git://git.xenomai.org/ipipe.git will be reorganized
>>>> today at 3pm GMT. At this chance, support for the 3.8.0 kernel will be
>>>> introduced.
>>>>
>>>> The complete commit history will be preserved, along with existing tags.
>>>> Branches may be renamed though, to better reflect the new development
>>>> workflow introduced with the pipeline "core" series.
>>>>
>>>> If you have scripts pulling from this repository in any automated way,
>>>> you may want to stop them for the day.
>>>>
>>>> A description of the few changes involved will be sent to this mailing
>>>> list later today, shortly before the new repository is published.
>>>>
>>>
>>> The reshuffled repository is now on line.
>>>
>>> The changes are as follows:
>>>
>>> - all legacy pipeline branches (i.e. pre-"core" series) have moved under
>>> the legacy/ hierarchy, e.g.
>>> ipipe-2.6.20-powerpc => legacy/ipipe-2.6.20-powerpc
>>> All branches under legacy/ are frozen, and won't be updated anymore.
>>>
>>> - the master branch now reflects the state of the mainline I-pipe
>>> development. Pull from this branch for the latest validated commits, for
>>> the latest supported kernel.
>>>
>>> - new ipipe-<kernel.version> branches are started off master
>>> periodically, for maintaining the pipeline over stable kernel releases.
>>> These branches include the pipeline code for a given kernel release, for
>>> a set of architectures we support in this release. There is neither
>>> arch-specific nor -noarch branches anymore.
>>
>> Will pulling in stable updates for a kernel major release create new
>> branches
> 
> ipipe-3.8.0 is actually checkout -b from master prior to working on a 
> more recent release in ipipe-next. This is really for 3.8.0 material only.

So where should the 3.8.13 merge go to?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

