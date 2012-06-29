Message-ID: <4FEDF65A.50401@grandegger.com>
Date: Fri, 29 Jun 2012 20:39:22 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <4FED4948.8080906@basystemes.fr> <4FED4B42.6000808@wanadoo.fr>
In-Reply-To: <4FED4B42.6000808@wanadoo.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM driver for the Advantech 1680U CANbus Adapter
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: Linux-CAN <linux-can@vger.kernel.org>, xenomai@xenomai.org

Hi Thierry,

On 06/29/2012 08:29 AM, Thierry Bultel wrote:
> Hi,
> 
> I have ported the adv_pci driver from
> http://git.toiit.sgu.ru/people/samarkinpa/public/?p=adv_pci.git;a=tree;h=a57c5d22415f8dbf92eeae0e05ff482839d8c2f3;hb=a57c5d22415f8dbf92eeae0e05ff482839d8c2f3

Thanks for your contribution. This driver is not yet mainline and it's
the first time that I see it. I added the Linux-CAN ML to the CC as it
might be of general interest.

> I has been quite intensively been tested and cycled for several days in
> real industrial conditions.
> 
> The patch for 2.6.38-8 is attached to this mail.
> 
> Is it of interest and does is have a chance to be integrated in the
> xenomai mainline ?

There is interest, of course. But we need a proper patch against the git
head of xenomai-2.6. At a first glance I realized the following issues:

- The patch does high-check and remove the plx_pci driver, please fix.

- What is Advantech specific in that driver? It looks pretty generic to
  me and it could easily support other similar devices.

- The Linux driver mentioned above does support much more Advantech
  devices. Any chance to support them in your driver as well.

- Please send patches *inline*.

- Please respect the Linux coding style (check CodingStyle and use
  checkpatch.pl).

Thanks in advance.

Wolfgang.

