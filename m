Subject: Re: Reminder: Contributions welcome, check issue list
References: <4c33582e-0b6a-dbef-d002-8a96453a689f@siemens.com>
 <BN9PR11MB5227BD97572BBD1F25865507F2359@BN9PR11MB5227.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f61c0667-1bf8-ac72-83c6-d4612b483f3a@siemens.com>
Date: Thu, 10 Jun 2021 07:43:12 +0200
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5227BD97572BBD1F25865507F2359@BN9PR11MB5227.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10.06.21 03:21, Chen, Hongzhan wrote:
>> To: Xenomai <xenomai@xenomai.org>
>> Subject: Reminder: Contributions welcome, check issue list
>>
>> Hi all,
>>
>> just a reminder to all who would like to give something back the Xenomai:
>>
>> We have a steadily growing list of issues on
>> https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues. Specifically
>> those tagged with "testing"
>> (https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues?label_name%5B%5D=testing)
> 
> I would like to work on issue #14 for x86 in the following. Would I provide difference 
> patch for already existing config or provide a new complete config?
> 

Great, thanks in advance! That issue could be addressed most quickly by
changing the existing config.

But the config topic is in fact broader, see #11. Once we split, we need
config fragments as well.

And we should probably also consider creating true defconfigs, to
massively reduce their size and also make them more robust across the
kernel versions. I'm currently hunting boot issues on the BeagleBone
with 5.10 (no output at all...), and those might be related to that we
are missing - or accidentally disabling - an important switch for that
kernel only.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

