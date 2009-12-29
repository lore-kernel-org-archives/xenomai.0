MIME-Version: 1.0
Sender: simon.boulay@domain.hid
In-Reply-To: <4B3917BF.5070600@domain.hid>
References: <729c4a400912260654vf4f99d1ta6105bdace1b4098@domain.hid>
	<4B3917BF.5070600@domain.hid>
Date: Tue, 29 Dec 2009 02:40:53 +0100
Message-ID: <729c4a400912281740g17ccf7bcn5d2fd7f63e08c2bd@domain.hid>
From: Simon Boulay <simon.boulay@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PATCH] Sensoray 526 analogy driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <alexis.berlemont@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On Mon, Dec 28, 2009 at 9:40 PM, Alexis Berlemont
<alexis.berlemont@domain.hid> wrote:
> Hi Simon,
>
> Simon Boulay wrote:
>>
>> Hi,
>>
>> Here is a patch which adds the support of the Sensoray Model 526 board
>> to analogy.
>
> Great ! I had a look at the code, that is fine for me. I just have few
> remarks:
> - some "printk" were left commented in the original comedi driver, you
> correctly translated them into a4l_info; however, could you use a4l_dbg
> instead and remove the comments ?
Yes.

> - the sources of the original driver contain many areas of commented code
> and "#if 0 #else #endif" directives. In order to keep coherency with the
> original driver, I think the import of the driver should be done as it is=
;
> nonetheless, the second step would be to clean it inside =C2=A0the git
> repository.
I totally agree. The "#if 0 #else #endif" directives are mainly
documentation or examples. I don't know if they are useful anymore but
I preferred to let them in place for first tests.
I'll send you patches when the driver will be available in your git reposit=
ory.
There are certainly things to add or optimize but I tried to not
divert too much from the original driver for the beginning.
If you think that's not the right way of doing, tell me. I plan to
publish the jr3 driver port this week. The original code is far more
clean but I'll appreciate your advices.

> I think it is wise to wait for the release of 2.5 before integrating it. =
It
> will be made available in Xenomai 2.5.1.
ok.

>> The driver compiles against head but have not been tested on real hardwa=
re
>> yet.
>
> Alessio was interested by this driver; Alessio, the drivers is yours as s=
oon
> as it is available in my git repository.
I'll be pleased to help anybody who can test the driver.

>> It has been ported from comedi (staging version) and should work as in
>> comedi:
>> - Encoder works
>> - Analog input works
>> - Analog output works
>> - PWM output works
>> - Commands are not supported yet.
>>
>> Regards,
>
> Many thanks for your work !
Your welcome. Let see if it works...

>
>> Simon.
>>
> Alexis.
>

