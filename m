MIME-Version: 1.0
In-Reply-To: <531D6083.3030006@xenomai.org>
References: <CAFNBftdTVXFwu5OjMML0R7GJTXDQricBYACkV_HmQmf9Rv6DDg@mail.gmail.com>
 <531D6083.3030006@xenomai.org>
Date: Mon, 10 Mar 2014 11:57:50 -0300
Message-ID: <CAFNBftfGFHxWN0eV=_rfq1y6sAVzgnqm0qKZ6bWaX1cYNSaV7g@mail.gmail.com>
From: Flavio Castro Alves Filho <flavio.alves@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Build Xenomai Lib native on the Beaglebone Black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hello Gilles,

It worked :-)

Thank you.

Flavio


2014-03-10 3:49 GMT-03:00 Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org>:
> On 03/10/2014 04:00 AM, Flavio Castro Alves Filho wrote:
>> Hello,
>>
>> Does anybody tried to build the Xenomai user space native on a BeagleBone Black?
>>
>> I'm using Debian on my board, with the build-essential package installed.
>
> If you do not use xenomai 2.6 git, you will probably need this patch:
> http://git.xenomai.org/xenomai-2.6.git/commit/?id=b10527ed14399a6485f69b935988d9d5211066d0
>
> to allow compiling xenomai for the armhf flavor of debian.
>
>>
>> Should we have the same result as cross-compiling?
>
> With the same versions of the tools, you should have exactly the same result.
> Only, you will probably get it after some more time.
>
> Regards.
>
> --
>                                                                 Gilles.



-- 
Flavio de Castro Alves Filho

flavio.alves@gmail.com
www.linuxembarcado.com
Twitter: http://twitter.com/#!/fraviofii
LinkedIn profile: www.linkedin.com/in/flaviocastroalves

