MIME-Version: 1.0
In-Reply-To: <5253DBAE.9060105@xenomai.org>
References: <CAKc2Hpbkaj3j1sPCWy-k6JD8ACz=85VnbqPFbfmk3sP1MsNwcA@mail.gmail.com>
	<CAMJ=MEcadCsTrsjfHNtW0Wr17T0CBrjtvf2j0O4L+zKtwFDi4g@mail.gmail.com>
	<5253DBAE.9060105@xenomai.org>
Date: Wed, 9 Oct 2013 10:26:28 +0200
Message-ID: <CAKc2HpYGYS1M7+_4fSdmJUkxocEYtCF9NijxSQRURq+8MUd1cA@mail.gmail.com>
From: "K. De Mey" <kim.demey@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Fuse version in Xenomai-forge with
	"--enabled-registry"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

When I started adding the registry support for pSOS skin I first looked at
the vxworks implementation.
Then I implemented similar functionality in a similar manner for pSOS. So I
make use of the registry code. These changes work fine.

However when adding some more changes where I wanted to make use of the
"fuse_file_info->fh" data field I first noticed an issue.
The fh data field is only supported in Fuse 2.5 and beyond. As we use Fuse
2.9.2 this should work but it did not.
I first suspected the FUSE_USE_VERSION but this is (as you mention also)
already defined at 26 for copperplate.

To be sure that I did not do something wrong in my adjusted code, I just
reverted my changes and build xenomai-forge as is with registry enabled.
Even then when running a pSOS test application it seems to be using the
fuse_main_real_compat22() function (I added some debug strings in the Fuse
code).

So I am a rather clueless now about what is causing this issue.

I found a topic about a similar issue (not with Xenomai) on the internet
where they assume linking issues (Binutils?) of the symbolic versioning.
(
http://sourceforge.net/mailarchive/forum.php?thread_name=9e0cf0bf0711211110l5ab3cd0bpfcd624fde8efb928%40mail.gmail.com&forum_name=fuse-devel
)
Not sure if the issues are related....

Regards,
Kim





2013/10/8 Philippe Gerum <rpm@xenomai.org>

> On 10/08/2013 10:54 AM, Ronny Meeus wrote:
>
>> On Tue, Oct 1, 2013 at 12:13 PM, K. De Mey <kim.demey@gmail.com> wrote:
>>
>>  Hello everybody,
>>>
>>> We use xenomai-forge for a project. I however came across a problem when
>>> adding the "--enabled-registry" option.
>>> It seems that the FUSE functions (for example fuse_main()) that are being
>>> used are the compat functions of version 2.2 (fuse_main_real_compat22()).
>>> I found this strange as I have FUSE_USE_VERSION defined at 26.
>>>
>>> I suspect it has something to do with the symbol versioning in FUSE.
>>> I believe so as when I change the version 22 ".symver" mapping in FUSE to
>>> use the newer compat functions then that works. (or removing all the
>>> symver
>>> completely works also)
>>> This is obviously not the way to make it work, however I don't know how
>>> to
>>> do it properly.
>>> I know this might be a FUSE issue and not necessary a Xenomai issue but I
>>> can't seem to get it working.
>>> I must say I know little to nothing of symbol versioning.
>>>
>>> As test I also created a stand alone FUSE application (no Xenomai
>>> involved)
>>> and then it does use the functions of the latest version.
>>> So to be sure, I would like to know if there is something more in Xenomai
>>> that sets the "compat" version of FUSE to 2.2? Am I missing something
>>> ...?
>>>
>>> By the way, the actual version of FUSE that we use is 2.9.2 and the
>>> version
>>> of Xenomai-forge is also quite recent.
>>>
>>> I hope my question is a clear enough, else I can of course add more
>>> information.
>>>
>>> Thanks!
>>>
>>> Regards,
>>> Kim
>>> ______________________________**_________________
>>> Xenomai mailing list
>>> Xenomai@xenomai.org
>>> http://www.xenomai.org/**mailman/listinfo/xenomai<http://www.xenomai.org/mailman/listinfo/xenomai>
>>>
>>>
>> Hello guys,
>>
>> any feedback on the questions above?
>>
>> Kim is working on the introduction of the full registry support for the
>> pSOS skin in forge.
>> I think this is a major step to improve the debugability of applications
>> using this skin.
>>
>>
> Mentioning that you wanted to work on the registry support for a real-time
> API gives the information which triggers an answer, since I could not
> figure out how I could help Xenomai-wise, beyond the fact that we do set
> FUSE_USE_VERSION appropriately and it does not seem to work for you
> although it should.
>
> However, we set this definition only for building copperplate and the
> registry daemon, since there is no reason to call any fuse library services
> outside of this scope. So, if you intend to provide the registry support
> for pSOS, please use the abstract registry infrastructure exposed by the
> copperplate library (see vxworks for a -terse- example). If you think it's
> not sufficient, then please submit some improvements to the abstract
> interface, but don't call fuse services directly from the emulator code.
>
> I suspect the latter is the reason why you have the legacy fuse interface
> referred to by your additional code to the pSOS emulator, since the pSOS
> makefile does not (and should not) define FUSE_USE_VERSION.
>
> --
> Philippe.
>
