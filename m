Subject: Re: Installing Xenomai Cobalt and Mercury in the same system
References: <20200914182002.cw6tdq2n7sjlbnqm@altlinux.org>
 <1096405435.3387889.1600110400342.JavaMail.zimbra@wolfram.com>
 <20200914212942.wtrp57bjh6jmosbl@altlinux.org> <87zh5ra67n.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <66cac805-e9d3-b7b1-0979-f8eaba6689ba@siemens.com>
Date: Tue, 15 Sep 2020 13:27:37 +0200
MIME-Version: 1.0
In-Reply-To: <87zh5ra67n.fsf@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, Vitaly Chikunov <vt@altlinux.org>
Cc: xenomai@xenomai.org

On 15.09.20 08:45, Philippe Gerum via Xenomai wrote:
> 
> Vitaly Chikunov via Xenomai <xenomai@xenomai.org> writes:
> 
>> On Mon, Sep 14, 2020 at 02:06:40PM -0500, Per Oberg via Xenomai wrote:
>>> ----- Den 14 sep 2020, på kl 20:20, xenomai xenomai@xenomai.org skrev:
>>>
>>>> I wish to create two sets of packages for ALT Linux for libxenomai one
>>>> for Cobalt and another for Mercury core.
>>>
>>>> But, it seems this is hard to achieve, because sonames would be the same.
>>>
>>>> Is there any suggestions how to achieve this properly?
>>>
>>> Wow, this takes me back.
>>> Back when I was a student our sysadmins would use cmod so that they could have all versions of all possible software installed at the same time. This way different departments could tune what versions were available to their students and they could install new versions without anyone getting angry about breakage. (And if something broke because they changed the default one could easily go back by making a different pick )
>>>
>>> The last contribution is well over 17 years old. Those were the days...
>>>
>>> https://git.lysator.liu.se/cmod/cmod
>>
>> Thanks for the suggestion. But, sysadmin level solutions does not solve
>> repository level problems for distributions. We only can create (RPM)
>> packages which any users should be able to install in usual way.
>> Otherwise, they could just use configure & make install for the
>> downloaded source code.
>>
>> One suggestion I got is to actually rename all xenomai sonames, for
>> example, to add core suffix to all library names. (Such as,
>> libcopperplate.so -> libcopperplate-mercury.so).
>>
>> Jan, Philippe, what do you think if we extend auto-scripts with a
>> possibility to specify soname suffix (via configure)? Thus, both
>> versions of the libs could be properly installed or used correctly.
>>
> 
> This would make sense to me.
> 

Ack.

We could also think of setting defaults for upcoming major releases so 
that the suffix does not needlessly become distro-specific. I have no 
feeling how many users we have on the mercury side, but I'm somehow 
leaning towards setting a suffix there while keeping the naming scheme 
on the cobalt side.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

