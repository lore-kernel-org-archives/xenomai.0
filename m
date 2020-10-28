MIME-Version: 1.0
References: <BN8PR15MB2915240F1729D1165109E036DB170@BN8PR15MB2915.namprd15.prod.outlook.com>
In-Reply-To: <BN8PR15MB2915240F1729D1165109E036DB170@BN8PR15MB2915.namprd15.prod.outlook.com>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Wed, 28 Oct 2020 19:08:21 +0100
Message-ID: <CAFc1U0v3a2ezV8+QYGxXeyZqrvVWj=OA8r_n8r3zpWeNKC9Hcg@mail.gmail.com>
Subject: Re: RTDM driver module
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
To: Robert Faron <RobertF@cmslaser.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I wrote such an example for a PCIe/FPGA board (not based on Cdev but it
works). I can share it :-)

regards


Le mer. 28 oct. 2020 =C3=A0 16:05, Robert Faron via Xenomai <xenomai@xenoma=
i.org>
a =C3=A9crit :

> I am trying to create a RTDM module. We developed an PCIe FPGA card.  Thi=
s
> card has many functions that will eventually be used in a real time
> application.  I have already created a cdev device that uses
> file_opperations mainly ioctl.  I am looking for a good example to model
> the creation of my RTDM driver.  The device is controlled solely through
> mmio.  Can someone point me in the right direction?  Any assistance would
> be greatly appreciated.
>
> Robert
> NOTICE: This e-mail message and all attachments transmitted with it may
> contain trade secrets and confidential information intended solely for th=
e
> use of the addressee. If the reader of this message is not the intended
> recipient, you are hereby notified that any reading, dissemination,
> distribution, copying, or other use of this message or its attachments is
> strictly prohibited. If you have received this message in error, please
> notify the sender immediately by telephone at 407-679-9716, and delete th=
is
> message and all copies and backups thereof. Thank you
>


--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
