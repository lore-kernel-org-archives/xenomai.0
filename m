MIME-Version: 1.0
In-Reply-To: <4DCB8544.60705@domain.hid>
References: <BANLkTimLY=RNyzZi7zm_Ln8iLDriEHPBUw@domain.hid>
	<4DCA45CA.1020208@domain.hid>
	<BANLkTim7dgHQn4seiQ+t2kSg0CHEq2oydA@mail.gmail.com>
	<4DCB8544.60705@domain.hid>
Date: Thu, 12 May 2011 18:22:31 +0800
Message-ID: <BANLkTi=KQMr=APNq_JrTPcQSvSx--A2+Sw@domain.hid>
From: AKS <aungkyas@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Adeos-main] building user space xenomai 2.5.6 for ARM
Reply-To: aungkyas@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Adeos <adeos-main@gna.org>

Hi

Thanks for the tips and cheers.

On 5/12/11, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> On 05/12/2011 02:37 AM, AKS wrote:
>> Hi Gilles
>>
>> Thanks and how to configure so that thumb will not be included.
>>
>> I checked ./configure --help | grep -i thumb
>>
>> But I did not see any hint how to omit thum2.
>>
>> I can native compile kernel, drivers and user space applications on
>> target. But xenomai client is an issue. Please advise. Thanks!
>
> I never had this issue, so, I do not know how to get a toolchain
> compiling for thumb by default to compile for the arm instruction set.
> What you can do, however, is to use a different toolchain.
>
> See crosstool-ng is you want to build your own. Or use one which does
> not compile for thumb. Codesourcery for instance, or a linux distribution.
>
> In any case, the Xenomai or Adeos mailing lists are not the best place
> to get an answer to such question.
>
> --
>                                                                 Gilles.
>

