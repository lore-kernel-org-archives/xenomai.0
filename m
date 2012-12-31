Message-ID: <50E1AAFE.5020503@xenomai.org>
Date: Mon, 31 Dec 2012 16:10:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMgy_J0idydJq8wzH3CwQoCa+BEbSyUyOJoWmvwc+oAB3jpZ6w@mail.gmail.com>	<CAKvQZ_2Nzfgj7oK12+t3CtLj-YWBCB=nFYSDU6B4KqW4aWQpnQ@mail.gmail.com>	<50B88506.6000002@xenomai.org>	<CAKvQZ_3LJ-u2B0zc0+pobSGnMZ4nNviyxfuP1uiVRVuHw9Y9pQ@mail.gmail.com>	<50B8F21B.5090503@xenomai.org>
	<CAKvQZ_2FFgp7gh9a5VrqAd0-qy3CEEKPayZcXkUfxbaWodh=yQ@mail.gmail.com>
In-Reply-To: <CAKvQZ_2FFgp7gh9a5VrqAd0-qy3CEEKPayZcXkUfxbaWodh=yQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Frustrating experience with Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Willy Lambert <lambert.willy@gmail.com>
Cc: xenomai@xenomai.org

On 12/30/2012 12:47 PM, Willy Lambert wrote:

> 2012/11/30 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>> On 11/30/2012 03:29 PM, Willy Lambert wrote:
>>> 2012/11/30 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>>>> On 11/30/2012 09:45 AM, Willy Lambert wrote:
>>>>> P.S. : to xenomai community, is there a problem if I continue some
>>>>> support here, or should we go somewhere else more on topic ?
>>>>
>>>> Absolutely no problem, this is a recurring problem, so, we can not
>>>> really ignore it. The thingx I would add is:
>>>> - if you have a very recent computer, you will have more trouble
>>>> installing really old kernels than install the latest revision, so, I
>>>> would advise to use the I-pipe patch for Linux 3.2 with xenomai 2.6.1
>>>> - we can give you write access to the wiki if you wish to write some
>>>> documents about this.
>>>>
>>>
>>> Ok, let me know where I should write something.
>>>
>>> I'll rewrite something like my first mail in the "old debian way"
>>> (should be ok for debian and ubuntu) :
>>> _ explaining the idea "first compile your vanilla kernel before
>>> patching it, try boot, and add xenomai".
>>> _ getting compile tools
>>> _ getting linux source with ketchup (cause it's really no brain)
>>> _ getting current config, configuring personnal version
>>> _ compile command (producing .deb)
>>> _ install command / remove
>>> Keeping the aim to show a simple method without getting into details,
>>> and providing some general linux doc to read.
>>>
>>> I don't have time to update my process to "latest pratices", but at
>>> least it a starting point.
>>
>> Ok, I will create a login/password on the wiki.
>>
>> However, for the particular case of Debian, starting with the I-pipe for
>> Linux 3.4, we can probably provide a precompiled kernel with a
>> debian-like configuration which will run on any platform.
>>
>> --
> 
> Hi all,
> 
> back from holidays, so I have some time to write some documentation
> about this. I suggest that I add a page linked from :
> http://www.xenomai.org/index.php/Howtos
> That I'll call :
> http://www.xenomai.org/index.php/Building_kernel
> I wonder if something should be added there :
> http://www.xenomai.org/index.php/Included_documentation_summary
> The howto page is not linked. Maybe the "building kernel" should comes
> first, at least the warning that "before doing a xenomai kernel you
> have to have a kernel"
> 
> Do I need to update any "source" documentation ? If y please tell me
> how (there is plain text, html, pdf,...)


Hi Willy,

go ahead for the documentation. The page explaining how to build a
kernel should point to the page about configuring a kernel for x86
machines. Then the source documentation pointing to this patch should be
README.INSTALL, README.INSTALL sources are
doc/asciidoc/README.INSTALL.adoc in xenomai sources.

Regards.

-- 
                                                                Gilles.

