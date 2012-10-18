MIME-Version: 1.0
Sender: sink00@gmail.com
In-Reply-To: <CAJgr76msAay2EpQ57bhABx3hoe9LeiGVnEqFAW5vLbtsrQDJuA@mail.gmail.com>
References: <CAODUr7vXcUGmeN9dso5ENeAXWugR9ojj=P3oJOY+3Vr4+mJRiQ@mail.gmail.com>
	<507F0E6E.6050308@xenomai.org>
	<CAODUr7t4LOoRhMdv8SidzPstvw+bhuBqghzrh4P+OB7FtB=XLw@mail.gmail.com>
	<CAFNBftfqDZfsR5jjeESgMFFPKb=EuBBEV8yQ8oomJ4jhMiCfkw@mail.gmail.com>
	<CAJgr76msAay2EpQ57bhABx3hoe9LeiGVnEqFAW5vLbtsrQDJuA@mail.gmail.com>
Date: Thu, 18 Oct 2012 03:55:55 -0300
Message-ID: <CAODUr7s-7C87NU7ri6vYE2Gou_1h7naiojwq2vU6Rm2BOo3KFw@mail.gmail.com>
From: Luis Rossi <luisf.rossi@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Error during kernel build
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Flavio Castro Alves Filho <flavio.alves@gmail.com>
Cc: xenomai@xenomai.org

Ok,

Using version 2.6.1 and correcting the reported bug (
http://www.mail-archive.com/xenomai@xenomai.org/msg00455.html) i was able
to build and install Xenomai on my Pc/104+. I could run for about one hour
today the xeno-test with a maximum latency of about 25us. I will have more
time in the lab tomorrow to run a more extensive test.

Thank you!

Best regards,

On Wed, Oct 17, 2012 at 11:10 PM, Luis Filipe Rossi
<luisf.rossi@gmail.com>wrote:

> No.. just build the kernel. As the target machine is a PC/104 with limite=
d
> flash (2GB) i will build on another computer.
>
> Regards,
>
>
> On Wed, Oct 17, 2012 at 11:07 PM, Flavio Castro Alves Filho <
> flavio.alves@gmail.com> wrote:
>
>> 2012/10/17 Luis Rossi <luisf.rossi@gmail.com>:
>> > Thank you,
>> >
>> > I will take a try. I chose version 2.5.4 becouse it was stated as stab=
le
>> > for debian in the website. How about 2.6.1?
>> >
>> > Quick question, if i build the kernel inside a Virtual Box with linux
>> (on a
>> > x86) computer will i have any problem? I cant see any reason why i
>> would,
>> > but it is nice to check.
>>
>> Do you want to execute Xenomai from a standard virtual machine?
>>
>> I believe that, at least, the real time results will not be reliable.
>>
>> >
>> > Regards,
>> >
>> > On Wed, Oct 17, 2012 at 5:00 PM, Gilles Chanteperdrix <
>> > gilles.chanteperdrix@xenomai.org> wrote:
>> >
>> >> On 10/17/2012 09:22 PM, Luis Rossi wrote:
>> >>
>> >> > Hi i am trying to build a kernel with xenomai for debian and i am
>> >> following
>> >> > all the instuctions.
>> >> >
>> >> > The target PC will be an Intel Atom.
>> >> >
>> >> > I am usign xenomai version 2.5.4 with kernel 2.6.34
>> >>
>> >>
>> >> As we said many times, the ABI do not change in a branch, so, there i=
s
>> >> absolutely no reason to use Xenomai 2.5.4 and not Xenomai 2.5.6. And
>> >> update to 2.6.1 is recommended.
>> >>
>> >> --
>> >>                                                                 Gille=
s.
>> >>
>> >> _______________________________________________
>> >> Xenomai mailing list
>> >> Xenomai@xenomai.org
>> >> http://www.xenomai.org/mailman/listinfo/xenomai
>> >>
>> >
>> >
>> >
>> > --
>> > Lu=EDs Filipe Rossi
>> > Electrical Engineer
>> > Biomechatronics Lab. / Grupo de Sensores Integr=E1veis e Sistemas
>> > Escola Polit=E9cnica
>> > Universidade de S=E3o Paulo
>> > Cel. +55 (11) 7662-9234
>> > _______________________________________________
>> > Xenomai mailing list
>> > Xenomai@xenomai.org
>> > http://www.xenomai.org/mailman/listinfo/xenomai
>>
>>
>>
>> --
>> Flavio de Castro Alves Filho
>>
>> flavio.alves@gmail.com
>> www.linuxembarcado.com
>> Twitter: http://twitter.com/#!/fraviofii
>> LinkedIn profile: www.linkedin.com/in/flaviocastroalves
>>
>
>
>
> --
> Lu=EDs Filipe Rossi
> Electrical Engineer
> Biomechatronics Lab. / Grupo de Sensores Integr=E1veis e Sistemas
> Escola Polit=E9cnica
> Universidade de S=E3o Paulo
> Cel. +55 (11) 7662-9234
>
>


--=20
Lu=EDs Filipe Rossi
Electrical Engineer
Biomechatronics Lab. / Grupo de Sensores Integr=E1veis e Sistemas
Escola Polit=E9cnica
Universidade de S=E3o Paulo
Cel. +55 (11) 7662-9234
