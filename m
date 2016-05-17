From: TALBI Ahmed -EXT <ahmed.talbi-ext@alstom.com>
Date: Tue, 17 May 2016 09:11:09 +0000
Message-ID: <28dcd6ac421c4696a7f60ccef160c8ef@AM3PR48MB0177.041d.mgd.msft.net>
References: <f5af5dc73c2046f789592c7f15246c24@AM3PR48MB0177.041d.mgd.msft.net>
 <20160514123051.GB27354@hermes.click-hack.org>,
 <3CC67847-B96B-4A25-A4C0-D92F267E4E3F@temporubato.com>
In-Reply-To: <3CC67847-B96B-4A25-A4C0-D92F267E4E3F@temporubato.com>
Content-Language: fr-FR
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] system freeze on IMX6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?Windows-1252?Q?Rolf_W=F6hrmann?= <info@temporubato.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Rolf and Gilles,

Thanks for your responses and sorry for my delayed one (we had 3 days off .=
..)

Unfortunately we can not afford to upgrade to newer versions of kernel and =
xenomai. We are near to a major release and we have very short deadlines.

In the logs I attached I can see that xnlock  is locked in do_taskexit_even=
t (by CPU0) and then in the same context we try to lock it a second time in=
 xintr_clock_handler. May this be the issue ? or is xnlock a recursive lock=
 ?

Cheers
Ahmed

________________________________________
De : Rolf W=F6hrmann <info@temporubato.com>
Envoy=E9 : samedi 14 mai 2016 15:01:14
=C0 : Gilles Chanteperdrix; TALBI Ahmed -EXT; xenomai@xenomai.org
Objet : Re: [Xenomai] system freeze on IMX6

Hi

not sure if this helps:

I=92m running fine Xenomai 3.0.1 with mainline 4.1 on a i.MX6Q phyCORE boar=
d.

Phytec has a new PD15.3.0 released which contains a mainline 4.1.18 only wi=
th some DTS additions and minor driver changes. Applying the ipipe-4.1.18ar=
m 4 was without problems.
So, may it=92s worth a try to upgrade.

Cheers
Rolf


> On 14 May 2016, at 14:30, Gilles Chanteperdrix <gilles.chanteperdrix@xeno=
mai.org> wrote:
>
> On Fri, May 13, 2016 at 01:25:31PM +0000, TALBI Ahmed -EXT wrote:
>> Hi all,
>>
>>
>> I'm new to this mailing list so please feel free to correct me if i'm no=
t using it as it should.
>>
>> We are facing a freeze on our platform based on a IMX6 soc (see backtrac=
e dump bellow). Please, can anybody take a look to it and give us a feedbac=
k  or an idea on the root cause of this issue ?
>>
>>
>> thanks in advance
>>
>>
>> we use kernel 3.0.35 and xenomai 2.6.4.
>
> Do you have the same problem with the 4.1 mainline kernel on Xenomai
> 3.0.2 ?
>
> --
>                                           Gilles.
> https://click-hack.org
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


________________________________
CONFIDENTIALITY : This e-mail and any attachments are confidential and may =
be privileged. If you are not a named recipient, please notify the sender i=
mmediately and do not disclose the contents to another person, use it for a=
ny purpose or store or copy the information in any medium.

