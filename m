Message-ID: <54B3D39B.7040900@siemens.com>
Date: Mon, 12 Jan 2015 15:00:59 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <E1Y9Fya-0004Me-Ao@sd-51317.xenomai.org>
 <54B3A339.7040501@xenomai.org> <54B3C134.5020101@siemens.com>
In-Reply-To: <54B3C134.5020101@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : sysregd: Install as suid
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 2015-01-12 13:42, Jan Kiszka wrote:
> On 2015-01-12 11:34, Philippe Gerum wrote:
>> On 01/08/2015 05:30 PM, git repository hosting wrote:
>>> Module: xenomai-jki
>>> Branch: for-forge
>>> Commit: 7d56f2b19f987069ef0025f9ce5f8cc52781f340
>>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=7d56f2b19f987069ef0025f9ce5f8cc52781f340
>>>
>>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>>> Date:   Thu Jan  8 14:30:52 2015 +0100
>>>
>>> sysregd: Install as suid
>>>
>>> sysregd has to run with root privileges in order to be able to clean up
>>> the mounts of unprivileged users.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>
>> This one assumes root id on "make install", which is not a prerequisite
>> for installing a Mercury setup. This leads to sysregd losing root
>> privileges on execution, which contradicts the purpose.
>>
>> We need sudo detection and use for this, just like we do in the top
>> level Makefile for creating /dev entries.
> 
> OK.

Is there a way to maintain that sudo test code only in one place? I'm
currently not finding an obvious one.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

