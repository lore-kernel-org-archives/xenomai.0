Subject: Re: ipipe 4.19: spurious APIC interrupt when setting rt_igp to up
References: <VI1PR05MB5917761A9138FE1E9EC30710F6FA0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <9ebf71d7-6a49-3eeb-d5a6-89d122136999@siemens.com>
 <788b682a-4845-31af-df17-f1008d143068@siemens.com>
 <ab6862a6-de5c-2c37-50a1-86e509768ecf@siemens.com>
 <VI1PR05MB5917125E023F3F1588F1B817F6F50@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <6a2a0a5e-7390-a303-5fdf-0d6cd662d413@siemens.com>
 <39f2b9f2-845b-5746-e1c7-530ac48561b3@siemens.com>
 <VI1PR05MB5917503588E7C86637059656F6F10@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <83b4cde3-dd94-e25b-5b8e-f4e04c8dd168@siemens.com>
Date: Tue, 9 Jul 2019 18:33:30 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB5917503588E7C86637059656F6F10@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

On 09.07.19 18:21, Lange Norbert wrote:
> Hello,
> 
> maxcpus=1 still causes the spurious int, this time fully locking up.
> 
> I attached the debug/irq directory after the cause.
> > Some things that might be relevant:
> -   the SOC would use PINCTRL_BROXTON under linux, but this is disabled (not fixed up for Xenomai)
> -   I have the regular igb driver in use, and am unbinding the network card prior to binding the rt_igp driver
> 

Thanks. What's the interrupt number that Xenomai is using? Should be the same
that the Linux driver is using as well.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

