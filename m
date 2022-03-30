Message-ID: <47c73276-8050-c0ce-8cd7-030f4e401aed@ba-healthcare.com>
Date: Wed, 30 Mar 2022 09:40:46 +0200
Subject: Re: About previous patches to have multicast with RTnet
Content-Language: en-US
References: <AS8PR09MB535430FF3FD87C8651AE8B1D811E9@AS8PR09MB5354.eurprd09.prod.outlook.com>
From: Jean-Baptiste Tredez <jean-baptiste.tredez@ba-healthcare.com>
In-Reply-To: <AS8PR09MB535430FF3FD87C8651AE8B1D811E9@AS8PR09MB5354.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Yann Le Chevoir <yann.lechevoir@cae.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

Le 29/03/2022 à 20:24, Yann Le Chevoir via Xenomai a écrit :

> Hello Philippe, Jean-Baptiste, Jan, all,
>
> About
> https://xenomai.org/pipermail/xenomai/2019-March/040588.html
>      [PATCH 00/16] multicast, VLAN support for RTnet
> and https://xenomai.org/pipermail/xenomai/2021-May/045164.html
>      [PATCH 00/31] Update fec driver for xenomai 3 and linux kernel 5.4
>      and add I.MX8 support
> I am checking how to have multicast support with RTnet and I do not
> understand from which branch come the commits from Gilles + why they are
> not integrated to the master branch.
> I see that some commits were integrated (eb7f0dfd + ac17dceb + 04fab252)
> but that's not clear (I read CONTRIBUTING.md) why not all of them.

Multicast commit needed some work in order to integrate them. I focused 
on what was needed to have the fec driver working on xenomai 3 (eb7f0dfd 
+ ac17dceb  + rewrite of the fec driver in 04fab252).

> Any plan to add the multicast support soon?
>  From where should I start if I want to give a try with the commits from
> the "multicast, VLAN support for RTnet" thread? Should I apply the patches
> from the mailing list?
>
> Thanks for your help,
>
> Yann

Jean-Baptiste


