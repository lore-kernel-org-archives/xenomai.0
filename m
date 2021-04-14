Subject: Re: Path to xeno-config - packages vs. scripts
References: <c94b173cb6a3e8453133a98694795346ff5086a0.camel@siemens.com>
 <37b0982595d8fc4df22ea9c5b07bb2b5b233bd2f.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c7aac5f2-0501-1be4-0192-895edf1bdbfc@siemens.com>
Date: Wed, 14 Apr 2021 13:04:11 +0200
MIME-Version: 1.0
In-Reply-To: <37b0982595d8fc4df22ea9c5b07bb2b5b233bd2f.camel@siemens.com>
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
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 14.04.21 12:39, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
> On Wed, 2021-04-14 at 10:08 +0000, Bezdeka, Florian via Xenomai wrote:
>> Hi!
>>
>> While porting a simple application to Xenomai I had some problems
>> related to the xeno-config tool:
>>
>> xeno-config is part of the xenomai-runtime package when installing
>> xenomai using the debian packages. I guess that's a packaging bug and
>> it should be located in libxenomai-dev. Calling xeno-config having
>> xenomai-runtime installed but not libxenomai-dev fails because of unmet
>> dependencies.
> 
> A patch has already been posted by Jan. My mailbox exploded today, so I
> missed that...
> 
>>
>> While preparing a patch for that I noticed that we have documented
>> "/usr/xenomai/bin/xeno-config" as path to xeno-config in the project
>> wiki while debian packages install to "/usr/bin/xeno-config"
>>
>> "/usr/xenomai/bin" is correct in case someone used scripts/maint/test-
>> xeno-test.rb. Which path should be documented in the wiki?
> 
> The question which path should be documented is still stands.
> 

Both I would say. I think we install to /usr/xenomai/bin/ by default
unless you set an own prefix. And Debian uses a regular prefix when
packaging.

The documentation wiki is a git repo as well. Please clone, fix and send
the patch. Or give me the link which page to edit.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

