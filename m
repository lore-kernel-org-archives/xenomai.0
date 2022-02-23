Message-ID: <cb5a9c17-e018-da8f-7a05-790900aa07f7@siemens.com>
Date: Wed, 23 Feb 2022 13:00:30 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] kernel-shark related patches
Content-Language: en-US
References: <20220222023101.31013-1-hongzhan.chen@intel.com>
 <15f28a0f-c4bd-b737-5ba7-0aaf3d603456@siemens.com>
 <MN2PR11MB428537181ED4AD3AD56E27B6F23C9@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MN2PR11MB428537181ED4AD3AD56E27B6F23C9@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
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

On 23.02.22 08:04, Chen, Hongzhan wrote:
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com> 
>> Sent: Wednesday, February 23, 2022 2:51 PM
>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>> Cc: y.karadz@gmail.com
>> Subject: Re: [PATCH 0/2] kernel-shark related patches
>>
>> On 22.02.22 03:30, Hongzhan Chen wrote:
>>> 1. Add kernel-shark plugin to visualize OOB state of xenomai realtime
>>>    thread.
>>> 2. Add libtraceevent plugin to parse xenomai_schedparams correctly.
>>>
>>> With the help of Yordan Karadzhov <y.karadz@gmail.com>, we finally
>>> create xenomai plugin and can build standalone. Thanks for his help
>>> again.
>>>
>>
>> So these build targets can basically live "anywhere" and are not
>> connected with our autoconf/automake build system of Xenomai.
>> Intentionally due to the more complex preparation steps?
> 
> The plugin actually depends on libkshark-devel and libtraceevent dev which we may have to
> get updated kernel-shark and libtraceevent code and build and install them before build the plugins. 
> I am wondering the better way is to integrate all these tools  with our plugin patches and maintain them
>  in our xenomai-image?

Actually, xenomai-image would only be a bonus, and it will not address
the use case of running graphical kernelshark. For now, I'm thinking of
something like ./configure --with-kernelshark ... for the Xenomai
userland build. That would not change what is built, just how it's
accessible. We will still need READMEs for what is currently needed as
special dependencies.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

