Message-ID: <511B9E94.2030108@hilscher.com>
Date: Wed, 13 Feb 2013 15:09:24 +0100
From: =?ISO-8859-1?Q?St=E9phane_LOS?= <slos@hilscher.com>
MIME-Version: 1.0
References: <511A2964.4080902@hilscher.com> <511A2CA4.1000408@siemens.com>
In-Reply-To: <511A2CA4.1000408@siemens.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

Le 12/02/2013 12:51, Jan Kiszka a =E9crit :
> On 2013-02-12 12:37, St=E9phane LOS wrote:
>> Hello there,
>>
>> It seems we have managed to build an RTDM module and we can insmod it
>> and it shows up in the named devices list.
>>
>> If we forget to rmmod the module, the kernel crashes when stopping or
>> rebooting.
> So you have a bug in your driver that requires fixing. Is the device
> opened while you shutdown? What does the backtrace tell you you about
> the crash? If you share your code early, we could review it already.
>
> Jan
>
Yes, of course we have a bug. I think that we have plenty of them in=20
fact. ;-)
I would like to share the code but it is a little early since we are=20
trying to figure out what we have to do.
Something is written started from what we have found in the sources but=20
we still have to learn.
The RTDM API documentation is good but we have very little knowledge on=20
how RTDM drivers should be used with Xenomai.
We lack general information.
Since the following links are broken now :
http://www.xenomai.org/index.php/Weblinks#Installation_of_Xenomai_and_RTDM_=
Driver_Writing
I remember that there use to be here a documentation about the RTDM=20
driver for CIF boards, it was years ago.
My colleague is actually working on the driver, I intervene here because=20
I like writing in English and I am the support guy. ;-)

Best Regards,
Cordialement,

St=E9phane LOS
slos@hilscher.com
Support technique

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Hilscher France
12, rue du 35=E8me R=E9giment d'Aviation
Miniparc du Ch=EAne
69500 BRON
France
T=E9l. : +33 (0) 4 72 37 98 40
Fax  : +33 (0) 4 78 26 83 27
http ://www.hilscher.fr
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


