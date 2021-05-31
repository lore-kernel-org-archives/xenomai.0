MIME-Version: 1.0
References: <CAB9YM8jgdbEYTB8Sb7212KWcLEkRDSVjEYZ8P2qCCStaX9CuPQ@mail.gmail.com>
 <a8412431-ccfb-dcc9-dfba-2da5374bcf1a@siemens.com>
 <CAB9YM8hdM5R9nsALRGQnXZ4hX0drJdYMDy=OroH92EzA_rqi5A@mail.gmail.com>
 <f2b82aaf-f92e-ea00-e871-f089562f5a00@siemens.com>
 <e87823b6-31b5-bb5d-201f-3054939024de@siemens.com>
 <CAB9YM8gaH8phRFH=z_0ES2N0Tgy0tWUtUQB7ULDcyihPAkpUmQ@mail.gmail.com>
In-Reply-To: <CAB9YM8gaH8phRFH=z_0ES2N0Tgy0tWUtUQB7ULDcyihPAkpUmQ@mail.gmail.com>
From: =?UTF-8?Q?Jo=C3=A3o_Costa?= <joaocostalapin@gmail.com>
Date: Mon, 31 May 2021 16:46:47 +0100
Message-ID: <CAB9YM8gUHXQtvuDXe_T+gpPyngVSKc6mnH-Ufmu5NU1UiK1kng@mail.gmail.com>
Subject: Re: error: implicit declarations while compiling
 (xenomai3.1+ubuntu20.04)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Just to be more precise, everything seemed to be going well until some
other errors shown up.
I have been fighting with these since then and I wasn't able to finish the
installation.
I will open a new and more generic thread.

Jo=C3=A3o Costa <joaocostalapin@gmail.com> escreveu no dia quinta, 27/05/20=
21
=C3=A0(s) 15:26:

> [ SOLUTION / SOLVED ] with the help of Jan. Thanks
>
> Turn off CONFIG_HYPERV - neither needed nor supported (but the failure
>> mode is indeed unfortunate).
>>
> I guess it was enabled or because I could not find it in previously in th=
e
> "GUI" of  *menuconfig *or because is was one of those options that was
> selected by default and could not be disabled.
>
> I edited the file *.config* and disabled it as suggested.
> Still I was getting this error:
>
>> make[1]: Leaving directory '/home/xxx/linux-5.4.77'
>> make: *** [debian/ruleset/targets/common.mk:301:
>> debian/stamp/build/kernel] Error 2
>
>
> So I followed your other suggestion of using "*make localmodconfig*"
> instead and everything worked.
>
>
> Jan Kiszka <jan.kiszka@siemens.com> escreveu no dia quinta, 27/05/2021
> =C3=A0(s) 13:20:
>
>> On 27.05.21 14:01, Jan Kiszka via Xenomai wrote:
>> > On 27.05.21 13:52, Jo=C3=A3o Costa wrote:
>> >> Thanks for your feedback.
>> >>
>> >> I had no report of errors in the CLI while patching the kernel.
>> >> In attach you may find the .config file I am using.
>> >>
>> >
>> > Thanks, will give that a try.
>> >
>>
>> Turn off CONFIG_HYPERV - neither needed nor supported (but the failure
>> mode is indeed unfortunate).
>>
>> In general, as you are building a full-featured distro config, you will
>> likely get much more than you need. And have to wait for that much
>> longer. I can recommend "make localmodconfig" as alternative.
>>
>> Jan
>>
>> --
>> Siemens AG, T RDA IOT
>> Corporate Competence Center Embedded Linux
>>
>
