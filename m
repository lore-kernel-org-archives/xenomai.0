MIME-Version: 1.0
In-Reply-To: <4BEA9F96.7020207@domain.hid>
References: <AANLkTinbt2EqgVr_rzyJJEgOVfgRYgHEhQB8CtBOCGsr@domain.hid>
	<4BEA9F96.7020207@domain.hid>
Date: Wed, 12 May 2010 20:49:33 +0800
Message-ID: <AANLkTimdnd4VxL6jiKoxTMtzX3t-T6dWPjIewdxG91we@domain.hid>
From: Everett Wang <everteq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] my first test run on beagleboard
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

I am using 2.5.3 and the patches is for kernel 2.6.33. I applied the patche=
s to
the vanilla kernel 3.6.33.3. Does it matter which 2.6.33 kernel to use
(2.6.33.1 2.6.33.2 or 2.6.33.3) ? The cross compiler is CodeSourcery
2010Q1.

I am glad that the VFP is supported in xenomai 2.5.3 :-). Thanks for the
xenomai developers.

My next step is to develop my real time application. Should I use the
same cross
compiler if I want real time and VFP support?

 Best regards,

Everett

On Wed, May 12, 2010 at 8:31 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Everett Wang wrote:
>> Hi all,
>>
>> I finally managed to compile and install xenomai on my beagleboard C4.
>> I just did a
>> kernel latency test and this is the result. Does it look reasonable?
>> the board is not running
>> anything except the kernel latency in the testsuit directory (C4
>> running at 720Mhgz)
>
> Hi,
>
> You are probably running latency on an idle board. With more load, you
> should get latencies around 70us.
>
> Note that for correct behaviour of floating point operations, you should
> use Xenomai 2.5.3 with the patches it contains for Linux 2.6.31 or 2.6.33=
.
>
> Regards.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

