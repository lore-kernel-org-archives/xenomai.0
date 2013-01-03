MIME-Version: 1.0
In-Reply-To: <CABi95VOOcH7uCKXrEyYf5Jw9MTyhVtTRLJzafXxZft-X=9hWYg@mail.gmail.com>
References: <CABi95VNaL3VuLq-qBEGgG1Fnwtpi2eQsDCMyEqPqvh9yNuZ-Eg@mail.gmail.com>
	<50E03E2E.9000803@xenomai.org>
	<201212301534.06581.paul_c@tuxcnc.org>
	<CABi95VOOcH7uCKXrEyYf5Jw9MTyhVtTRLJzafXxZft-X=9hWYg@mail.gmail.com>
Date: Thu, 3 Jan 2013 13:58:59 +0800
Message-ID: <CABi95VOmgcCRDSGOs=SQqQOm4PauK82DnTWh0JOpn-3Y1AD-3Q@mail.gmail.com>
From: =?GB2312?B?yfLMzg==?= <xst0001@gmail.com>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Can not run test on Raspberry Pi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

2013/1/3 =C9=F2=CC=CE <xst0001@gmail.com>
>
>
>
> 2012/12/30 Paul <paul_c@tuxcnc.org>
>>
>> On Sunday 30 December 2012, Gilles Chanteperdrix wrote:
>>
>> > The most common reason for such issues is if you are not compiling
>> > xenomai with the same toolchain or same toolchain options (regarding
>> > for instance the EABI setting) as the one used to compile the target
>> > libc.
>>
>> If you are using a Raspian install, then try using:
>>  configure --host=3Darm-bcm2708hardfp-linux-gnueabi
>> The alternative is to compile Xenomai on the PI which doesn't take too
>> long. Both options work fine for me.
>>
>> The kernel should have also been compiled with  the bcm2708hardfp
>> toolchain so as to avoid problems further down the line.
>>
I use arm-bcm2708hardfp-linux-gnueabi instead of arm-bcm2708-linux-gnueabi
to compile the kernl and Xenomai,and there is no error now.Maybe the libc o=
f
Raspbian is compiled by arm-bcm2708hardfp-linux-gnueabi.

Thank you for your help,Gilles and Paul.


               Shen Tao

