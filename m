Message-ID: <4DCB8544.60705@domain.hid>
Date: Thu, 12 May 2011 08:59:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTimLY=RNyzZi7zm_Ln8iLDriEHPBUw@domain.hid>	<4DCA45CA.1020208@domain.hid>
	<BANLkTim7dgHQn4seiQ+t2kSg0CHEq2oydA@mail.gmail.com>
In-Reply-To: <BANLkTim7dgHQn4seiQ+t2kSg0CHEq2oydA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] building user space xenomai 2.5.6 for ARM
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: aungkyas@domain.hid
Cc: Adeos <adeos-main@gna.org>

On 05/12/2011 02:37 AM, AKS wrote:
> Hi Gilles
> 
> Thanks and how to configure so that thumb will not be included.
> 
> I checked ./configure --help | grep -i thumb
> 
> But I did not see any hint how to omit thum2.
> 
> I can native compile kernel, drivers and user space applications on
> target. But xenomai client is an issue. Please advise. Thanks!

I never had this issue, so, I do not know how to get a toolchain
compiling for thumb by default to compile for the arm instruction set.
What you can do, however, is to use a different toolchain.

See crosstool-ng is you want to build your own. Or use one which does
not compile for thumb. Codesourcery for instance, or a linux distribution.

In any case, the Xenomai or Adeos mailing lists are not the best place
to get an answer to such question.

-- 
                                                                Gilles.

