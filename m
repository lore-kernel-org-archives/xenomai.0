Message-ID: <54778CF6.6000909@siemens.com>
Date: Thu, 27 Nov 2014 21:43:34 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <54775097.30705@siemens.com> <20141127181823.GK7842@hermes>
 <547772AF.108@siemens.com> <20141127191438.GI24110@csclub.uwaterloo.ca>
 <20141127203400.GP7842@hermes>
In-Reply-To: <20141127203400.GP7842@hermes>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [pull] forge: Adjust default registry mount point
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Xenomai <xenomai@xenomai.org>

On 2014-11-27 21:34, Gilles Chanteperdrix wrote:
> On Thu, Nov 27, 2014 at 02:14:38PM -0500, Lennart Sorensen wrote:
>> On Thu, Nov 27, 2014 at 07:51:27PM +0100, Jan Kiszka wrote:
>>> On 2014-11-27 19:18, Gilles Chanteperdrix wrote:
>>>> According to the filesystem hierarchy standard, /mnt is the standard
>>>> place for "temporarily mounted filesystems".
>>>>
>>>> http://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard
>>>
>>> Right, another reason to NOT mess around with it: if something was
>>> temporarily mounted there, we will create the mountpoint inside that
>>> filesystem with unforeseeable side effects.
>>
>> I always read that as "temporarily mounted there by the admin or some
>> other human".  Certainly not automatic mounts by software.  There is a
>> reason /media and such exists on many distributins.
> 
> I would not venture an "always", autofs for instance, used to mount
> things under /mnt. and /media has not always existed either, we used
> /mnt/cdrom.

FHS on /mnt purpose:

"This directory is provided so that the system administrator may
temporarily mount a filesystem as needed. The content of this directory
is a local issue and should not affect the manner in which any program
is run."

I think this makes it crystal clear that Xenomai is not supposed to
touch it.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

