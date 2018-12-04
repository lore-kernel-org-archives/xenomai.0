Subject: Re: improve and provide a header for bootstrapping
References: <20181023151647.25508-1-norbert.lange@andritz.com>
 <7571eedc-7844-2703-e553-72cf9a1abbe0@siemens.com>
 <CADYdroNgOFKaEQ0UfcxhdniU54PYt119g+Y9Gnz7SGrCtBGiUA@mail.gmail.com>
 <d36e64a62d0d42b6981fc4657025acea@andritz.com>
 <d110a7bf-4017-87b5-5eff-2ee1900dbd88@siemens.com>
 <f86296ea09fb43b483179cea784c3f66@andritz.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d7521284-01f5-4ba2-4ccd-e8cbf7ad2cb5@siemens.com>
Date: Tue, 4 Dec 2018 18:59:05 +0100
MIME-Version: 1.0
In-Reply-To: <f86296ea09fb43b483179cea784c3f66@andritz.com>
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
To: Lange Norbert <norbert.lange@andritz.com>
Cc: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

On 04.12.18 18:21, Lange Norbert wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Dienstag, 4. Dezember 2018 17:30
>> To: Lange Norbert <norbert.lange@andritz.com>
>> Cc: Xenomai <xenomai@xenomai.org>; Philippe Gerum
>> <rpm@xenomai.org>
>> Subject: Re: improve and provide a header for bootstrapping
>>
>> E-MAIL FROM A NON-ANDRITZ SOURCE: AS A SECURITY MEASURE, PLEASE
>> EXERCISE CAUTION WITH E-MAIL CONTENT AND ANY LINKS OR
>> ATTACHMENTS.
>>
>>
>> On 04.12.18 16:53, Lange Norbert wrote:
>>> So any update on this.
>>> Do you have something similar to patchwork to keep up on those loose
>> email-threads?
>>>
>>
>> This was less a patch tracking issue than the missing decision how to address
>> the topic.
> 
> I understand that, but there is still a lack of feedback. (And I already brought that topic
> up some months ago, so there is some redundancy explaining it again).

Just saw your first round from April which didn't get any feedback at all - not 
optimal, I agree.

> 
>> On the one hand, I see a desire to control bootstrapping in more details. On
>> the other hand, I wonder how much *additional* control is practically
>> needed - did you study --no-auto-init sufficiently? And I wonder how much
>> new interfaces we want to open up that way.
> 
> Yes I know --no-auto-init, but that’s only one side of the story. What are you doing
> in place of auto-init?

Call xenomai_init() - or what are you missing then?

> To me, the most sensible approach is to place building blocks in the xenomai
> Headers and libraries.
> 
> *   parsing of the commandline args got moved from the bootstrap (lib/boilerplate/init/bootstrap.c)
>      to the DSO. Don’t want to replicate this everywhere

Are you using command line parameters to tune the Xenomai core?

> *   the setup code from bootstrapping is separated from the main wrapping magic (currently this is either both or none)
>      That’s currently done with a header, as quite frankly proving object code does not scale well with compilerflags and options.
> 
> What I generally want is to easily add the setup code into an application, while avoiding the additional wrapping magic.
> The cause of action is either to do everything myself or try to modulize the upstream bootstrapping.
> 
> In terms of external interfaces, only 'xenomai_init_fetchargv' would be added to libcobalt/libmercury.
> A second function 'xenomai_bootstrap_getargv' is defined by the bootstrapping code,
> to be consumed by the application (or can be ignored).

In fact, the other reason I'm reluctant to create new interfaces here is that I 
don't believe hooking into the command line of the main process is a good 
interface for a library like Xenomai in the first place. We had problems with 
that before, and I would rather like to think about moving away from it. Without 
all that parameter parsing, xenomai_init would take void as arguments, and we 
had no need for moving code around here.

A better interface for Xenomai would actually be prefixed (e.g. "XENO_") 
environment variables, because they do not interfere with the process' command 
line and can be picked up or even modified without much effort at any point 
between application start and xenomai initialization.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

